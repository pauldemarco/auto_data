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
    result.writeln('class ${c.name} {');
    return result;
  }

  static String _generateClassFooter(DataClass c) {
    return '}\n';
  }

  static StringBuffer _generateFinalFields(DataClass c) {
    StringBuffer result = new StringBuffer();
    c.props.forEach((name, type) {
      result.write('final $type $name;\n');
    });
    return result;
  }

  static StringBuffer _generateConstructor(DataClass c) {
    StringBuffer result = new StringBuffer();
    result.write('const ');
    result.write('${c.name}({');

    final params = c.props.keys.map((name) => 'this.$name, ').join('');
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

    final params = c.props.keys.map((p) => '$p == other.$p').join(' && ');
    result.write(params);

    result.writeln(';');
    return result;
  }

  static StringBuffer _generateHashCode(DataClass c) {
    StringBuffer result = new StringBuffer();
    result.writeln('@override');
    result.write('int get hashCode => ');

    final params = c.props.keys.map((p) => '$p.hashCode').join(' ^ ');
    result.write(params);

    result.writeln(';');
    return result;
  }

  static StringBuffer _generateToString(DataClass c) {
    StringBuffer result = new StringBuffer();
    result.writeln('@override');
    result.writeln('String toString() {');
    result.write('return \'${c.name}{');

    final params = c.props.keys.map((p) => '$p: \$$p').join(', ');
    result.write(params);

    result.writeln('}\';');

    result.writeln('}');
    return result;
  }

  static StringBuffer _generateCopyWith(DataClass c) {
    StringBuffer result = new StringBuffer();
    result.writeln('${c.name} copyWith({');

    c.props.forEach((name, type) {
      result.writeln('$type $name,');
    });

    result.writeln('}) {');

    result.writeln('return ${c.name}(');

    c.props.forEach((name, type) {
      result.writeln('$name: $name ?? this.$name,');
    });

    result.writeln(');');

    result.writeln('}');
    return result;
  }
}
