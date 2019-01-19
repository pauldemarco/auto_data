// Copyright 2019, Paul DeMarco.
// All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

part of auto_data_generator;

class FileGenerator {
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
    buffer.write('const ');
    buffer.write('${c.name}({');

    c.props.forEach((p) {
      if (!p.isNullable && p.assignmentString == null) {
        buffer.write('@required ');
      }
      buffer.write('this.${p.name}');
      if(p.assignmentString != null) {
        buffer.write(p.assignmentString);
      }
      buffer.write(', ');
    });

    buffer.writeln('});');
    return buffer;
  }

  static StringBuffer _generateOtherConstructors(DataClass c) {
    final buffer = new StringBuffer();
    c.constructors.forEach((c) {
      if (c.documentationComment != null) {
        buffer.writeln(c.documentationComment);
      }
      buffer.writeln(c.declaration);
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

    final params =
        c.props.map((p) => '${p.name} == other.${p.name}').join(' && ');
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
}
