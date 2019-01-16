// Copyright 2019, Paul DeMarco.
// All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

part of auto_data_generator;

class FileGenerator {
  static StringBuffer generate(List<DataClass> classes) {
    StringBuffer buffer = new StringBuffer();
    classes.forEach((dataClass) {
      buffer.write(_generateClassHeader(dataClass));
      buffer.writeln(_generateFinalFields(dataClass));
      buffer.writeln(_generateConstructor(dataClass));
      buffer.writeln(_generateOperatorEquals(dataClass));
      buffer.writeln(_generateHashCode(dataClass));
      buffer.writeln(_generateToString(dataClass));
      buffer.writeln(_generateCopyWith(dataClass));
      buffer.write(_generateClassFooter(dataClass));
    });
    return buffer;
  }

  static String camelToSnakeCase(String name) {
    StringBuffer result = new StringBuffer();
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
    StringBuffer result = new StringBuffer();
    if (c.documentationComment != null) {
      result.writeln(c.documentationComment);
    }
    result.writeln('class ${c.name} {');
    return result;
  }

  static String _generateClassFooter(DataClass c) {
    return '}\n';
  }

  static StringBuffer _generateFinalFields(DataClass c) {
    StringBuffer result = new StringBuffer();
    c.props.forEach((p) {
      if (p.documentationComment != null) {
        result.writeln(p.documentationComment);
      }
      result.write('final ${p.type} ${p.name};\n');
    });
    return result;
  }

  static StringBuffer _generateConstructor(DataClass c) {
    StringBuffer result = new StringBuffer();
    result.write('const ');
    result.write('${c.name}({');

    final params = c.props.map((p) => 'this.${p.name}, ').join('');
    result.write(params);

    result.writeln('});');
    return result;
  }

  static StringBuffer _generateOperatorEquals(DataClass c) {
    StringBuffer result = new StringBuffer();
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
    StringBuffer result = new StringBuffer();
    result.writeln('@override');
    result.write('int get hashCode => ');

    final params = c.props.map((p) => '${p.name}.hashCode').join(' ^ ');
    result.write(params);

    result.writeln(';');
    return result;
  }

  static StringBuffer _generateToString(DataClass c) {
    StringBuffer result = new StringBuffer();
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
    StringBuffer result = new StringBuffer();
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
