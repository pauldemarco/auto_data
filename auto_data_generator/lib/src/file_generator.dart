// Copyright 2019, Paul DeMarco.
// All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

part of auto_data_generator;

class FileGenerator {
  static final _regexTypeSpecifier = RegExp(r'\<(.*?)\>');

  static StringBuffer generate(List<DataClass> classes) {
    final buffer = new StringBuffer();
    classes.forEach((dataClass) {
      buffer.write(_generateClassHeader(dataClass));
      buffer.writeln(_generateFinalFields(dataClass));
      buffer.writeln(_generateNamedConstructor(dataClass));
      buffer.writeln(_generateOtherConstructors(dataClass));
      buffer.writeln(_generateOperatorEquals(dataClass));
      buffer.writeln(_generateHashCode(dataClass));
      buffer.writeln(_generateToString(dataClass));
      buffer.writeln(_generateCopyWith(dataClass));
      buffer.writeln(_generateFromRtdbMap(dataClass));
      buffer.writeln(_generateToRtdbMap(dataClass));
      buffer.write(_generateClassFooter(dataClass));
    });
    return buffer;
  }

  static String camelToSnakeCase(String name) {
    final buffer = new StringBuffer();
    for (var c in name.codeUnits) {
      if (c >= 65 && c <= 90) {
        c += 32;
        if (buffer.length > 0) {
          buffer.write('_');
        }
      }
      buffer.writeCharCode(c);
    }
    return buffer.toString();
  }

  static StringBuffer _generateClassHeader(DataClass c) {
    final buffer = new StringBuffer();
    if (c.documentationComment != null) {
      buffer.writeln(c.documentationComment);
    }
    buffer.writeln('@immutable');
    buffer.writeln('class ${c.name} {');
    return buffer;
  }

  static String _generateClassFooter(DataClass c) {
    return '}\n';
  }

  static StringBuffer _generateFinalFields(DataClass c) {
    final buffer = new StringBuffer();
    c.props.forEach((p) {
      if (p.documentationComment != null) {
        buffer.writeln(p.documentationComment);
      }
      buffer.write('final ${p.type} ${p.name};\n');
    });
    return buffer;
  }

  static StringBuffer _generateNamedConstructor(DataClass c) {
    final buffer = new StringBuffer();
    // FIXME: List.unmodifiable causes error: Initializer expressions in constant constructors must be constants.
    if (!c.props.any((p) => p.type.startsWith('List'))) {
      buffer.write('const ');
    }
    buffer.write('${c.name}({');

    c.props.forEach((p) {
      if (!p.isNullable && p.assignmentString == null) {
        buffer.write('@required ');
      }
      if (p.type.startsWith('List')) {
        buffer.write('${p.type} ${p.name}');
      } else {
        buffer.write('this.${p.name}');
      }
      if (p.assignmentString != null) {
        buffer.write(p.assignmentString);
      }
      buffer.write(', ');
    });

    buffer.write('})');
    if (c.props.any((p) => p.type.startsWith('List'))) {
      buffer.write(':');
      final initializers = c.props.where((p) => p.type.startsWith('List')).map(
          (p) =>
              '${p.name} = (${p.name} != null) ? List.unmodifiable(${p.name}) : null');
      buffer.write(initializers.join(','));
    }

    buffer.writeln(';');
    return buffer;
  }

  static StringBuffer _generateOtherConstructors(DataClass c) {
    final buffer = new StringBuffer();
    c.constructors.forEach((c) {
      if (c.documentationComment != null) {
        buffer.writeln(c.documentationComment);
      }
      buffer.writeln(c.declaration.replaceAll('\$', ''));
      buffer.writeln('');
    });
    return buffer;
  }

  static StringBuffer _generateOperatorEquals(DataClass c) {
    final buffer = new StringBuffer();
    buffer.writeln('@override');
    buffer.writeln('bool operator ==(Object other) =>');
    buffer.writeln('identical(this, other) ||');
    buffer.writeln('other is ${c.name} &&');
    buffer.writeln('runtimeType == other.runtimeType &&');

    final params = c.props.map((p) {
      if (p.type.startsWith('List')) {
        return 'const ListEquality().equals(${p.name}, other.${p.name})';
      } else {
        return '${p.name} == other.${p.name}';
      }
    }).join(' && ');
    buffer.write(params);

    buffer.writeln(';');
    return buffer;
  }

  static StringBuffer _generateHashCode(DataClass c) {
    final buffer = new StringBuffer();
    buffer.writeln('@override');
    buffer.write('int get hashCode => ');

    final params = c.props.map((p) => '${p.name}.hashCode').join(' ^ ');
    buffer.write(params);

    buffer.writeln(';');
    return buffer;
  }

  static StringBuffer _generateToString(DataClass c) {
    final buffer = new StringBuffer();
    buffer.writeln('@override');
    buffer.writeln('String toString() {');
    buffer.write('return \'${c.name}{');

    final params = c.props.map((p) => '${p.name}: \$${p.name}').join(', ');
    buffer.write(params);

    buffer.writeln('}\';');

    buffer.writeln('}');
    return buffer;
  }

  static StringBuffer _generateCopyWith(DataClass c) {
    final buffer = new StringBuffer();
    buffer.writeln('${c.name} copyWith({');

    c.props.forEach((p) {
      buffer.writeln('${p.type} ${p.name},');
    });

    buffer.writeln('}) {');

    buffer.writeln('return ${c.name}(');

    c.props.forEach((p) {
      final name = p.name;
      buffer.write('$name: ');
      if (p.type.startsWith('List')) {
        buffer.write(
            '($name != null) ? ($name == this.$name) ? $name.sublist(0) : $name :');
      } else {
        buffer.writeln('$name ?? ');
      }
      buffer.writeln('this.$name, ');
    });

    buffer.writeln(');');

    buffer.writeln('}');
    return buffer;
  }

  static StringBuffer _generateFromRtdbMap(DataClass c) {
    String _getConverter(
        String name, String type, String argument, bool isEnum) {
      if (type.startsWith('DateTime')) {
        return 'DateTime.fromMillisecondsSinceEpoch($argument)';
      } else if (type.startsWith('\$')) {
        return '$type.fromFirebaseMap($argument)';
      } else if (type.startsWith('List')) {
        final buffer = new StringBuffer();
        buffer.write('(m[\'$name\'] as Map).values');
        if (_regexTypeSpecifier.hasMatch(type)) {
          final listType = _regexTypeSpecifier.firstMatch(type).group(1);
          final converter = _getConverter(name, listType, 'm', false);
          buffer.write('.map((m) => $converter)');
        }
        buffer.write('.toList()');
        return buffer.toString();
      } else if (isEnum) {
        return '$type.values[$argument]';
      } else {
        return '$argument';
      }
    }

    final buffer = new StringBuffer();
    buffer.writeln('${c.name}.fromFirebaseMap(Map m):');

    final params = c.props.map((p) {
      var assignment =
          _getConverter(p.name, p.type, 'm[\'${p.name}\']', p.isEnum);
      if (p.isNullable && assignment != 'm[\'${p.name}\']') {
        assignment = 'm[\'${p.name}\'] != null ? $assignment : null';
      }
      return '${p.name} = $assignment';
    }).join(',');

    buffer.write(params);

    buffer.writeln(';');
    return buffer;
  }

  static StringBuffer _generateToRtdbMap(DataClass c) {
    String _getConverter(String name, String type, bool isEnum) {
      if (type.startsWith('DateTime')) {
        return '$name.millisecondsSinceEpoch';
      } else if (type.startsWith('\$')) {
        return '$name.toFirebaseMap()';
      } else if (type.startsWith('List')) {
        final buffer = new StringBuffer();
        buffer.write('Map.fromIterable($name,');
        if (_regexTypeSpecifier.hasMatch(type)) {
          final listType = _regexTypeSpecifier.firstMatch(type).group(1);
          var converter = _getConverter(name, listType, false);
          converter = converter.replaceFirst('$name.', 'm.');
          final key = listType.startsWith('\$') ? 'm.id' : 'm.hashCode';
          buffer.write('key: (m) => $key, value: (m) => $converter)');
        }
        return buffer.toString();
      } else if (isEnum) {
        return '$name.index';
      } else {
        return '$name';
      }
    }

    final buffer = new StringBuffer();
    buffer.writeln('Map toFirebaseMap() => {');

    final params = c.props.map((p) {
      var assignment = _getConverter(p.name, p.type, p.isEnum);
      if (p.isNullable && assignment != p.name) {
        assignment = '${p.name} != null ? $assignment : null';
      }
      return '\'${p.name}\': $assignment';
    }).join(',');

    buffer.write(params);

    buffer.writeln('};');
    return buffer;
  }
}
