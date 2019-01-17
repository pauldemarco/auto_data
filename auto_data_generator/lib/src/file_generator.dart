// Copyright 2019, Paul DeMarco.
// All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

part of auto_data_generator;

class FileGenerator {
  static StringBuffer generate(List<DataClass> classes) {
    final result = new StringBuffer();
    classes.forEach((dataClass) {
      result.write(_generateClassHeader(dataClass));
      result.writeln(_generateFinalFields(dataClass));
      result.writeln(_generateNamedConstructor(dataClass));
      result.writeln(_generateOtherConstructors(dataClass));
      result.writeln(_generateOperatorEquals(dataClass));
      result.writeln(_generateHashCode(dataClass));
      result.writeln(_generateToString(dataClass));
      result.writeln(_generateCopyWith(dataClass));
      result.write(_generateClassFooter(dataClass));
    });
    return result;
  }

  static String camelToSnakeCase(String name) {
    final result = new StringBuffer();
    for (var c in name.codeUnits) {
      if (c >= 65 && c <= 90) {
        c += 32;
        if (result.length > 0) {
          result.write('_');
        }
      }
      result.writeCharCode(c);
    }
    return result.toString();
  }

  static StringBuffer _generateClassHeader(DataClass c) {
    final result = new StringBuffer();
    if (c.documentationComment != null) {
      result.writeln(c.documentationComment);
    }
    result.writeln('@immutable');
    result.writeln('class ${c.name} {');
    return result;
  }

  static String _generateClassFooter(DataClass c) {
    return '}\n';
  }

  static StringBuffer _generateFinalFields(DataClass c) {
    final result = new StringBuffer();
    c.props.forEach((p) {
      if (p.documentationComment != null) {
        result.writeln(p.documentationComment);
      }
      result.write('final ${p.type} ${p.name};\n');
    });
    return result;
  }

  static StringBuffer _generateNamedConstructor(DataClass c) {
    final result = new StringBuffer();
    result.write('const ');
    result.write('${c.name}({');

    c.props.forEach((p) {
      if (!p.isNullable && p.assignmentString == null) {
        result.write('@required ');
      }
      result.write('this.${p.name}');
      if(p.assignmentString != null) {
        result.write(p.assignmentString);
      }
      result.write(', ');
    });

    result.writeln('});');
    return result;
  }

  static StringBuffer _generateOtherConstructors(DataClass c) {
    final result = new StringBuffer();
    c.constructors.forEach((c) {
      if (c.documentationComment != null) {
        result.writeln(c.documentationComment);
      }
      result.writeln(c.declaration);
      result.writeln('');
    });
    return result;
  }

  static StringBuffer _generateOperatorEquals(DataClass c) {
    final result = new StringBuffer();
    result.writeln('@override');
    result.writeln('bool operator ==(Object other) =>');
    result.writeln('identical(this, other) ||');
    result.writeln('other is ${c.name} &&');
    result.writeln('runtimeType == other.runtimeType &&');

    final params =
        c.props.map((p) => '${p.name} == other.${p.name}').join(' && ');
    result.write(params);

    result.writeln(';');
    return result;
  }

  static StringBuffer _generateHashCode(DataClass c) {
    final result = new StringBuffer();
    result.writeln('@override');
    result.write('int get hashCode => ');

    final params = c.props.map((p) => '${p.name}.hashCode').join(' ^ ');
    result.write(params);

    result.writeln(';');
    return result;
  }

  static StringBuffer _generateToString(DataClass c) {
    final result = new StringBuffer();
    result.writeln('@override');
    result.writeln('String toString() {');
    result.write('return \'${c.name}{');

    final params = c.props.map((p) => '${p.name}: \$${p.name}').join(', ');
    result.write(params);

    result.writeln('}\';');

    result.writeln('}');
    return result;
  }

  static StringBuffer _generateCopyWith(DataClass c) {
    final result = new StringBuffer();
    result.writeln('${c.name} copyWith({');

    c.props.forEach((p) {
      result.writeln('${p.type} ${p.name},');
    });

    result.writeln('}) {');

    result.writeln('return ${c.name}(');

    c.props.forEach((p) {
      result.writeln('${p.name}: ${p.name} ?? this.${p.name},');
    });

    result.writeln(');');

    result.writeln('}');
    return result;
  }
}
