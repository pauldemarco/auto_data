// Copyright 2019, Paul DeMarco.
// All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

part of auto_data_generator;

@Deprecated('Using build_runner to traverse elements')
class FileParser {
  static final _regexCode = r'(?:@data\nclass )[{a-zA-Z\n; <>,]*(?:})';
  static final _regex =
      RegExp(_regexCode, multiLine: true, caseSensitive: true);

  Map<String, DataClass> parse(String code) {
    Map<String, DataClass> result = {};
    final matches = _regex.allMatches(code);
    for (Match m in matches) {
      final contents = m.group(0);
      try {
        final c = ClassBodyParser.parse(contents);
        result[c.name] = c;
      } catch (e) {
        print('Failed to parse data class: $contents, error: $e');
      }
    }
    return result;
  }
}

@Deprecated('Using build_runner to traverse elements')
class ClassBodyParser {
  static final _regexCode =
      r'(?:@data\nclass )(\w+)(?: ?{\n)([a-zA-Z \n<,>;]*)(?=})';
  static final _regex =
      RegExp(_regexCode, multiLine: true, caseSensitive: true);

  static DataClass parse(String code) {
    final m = _regex.firstMatch(code);
    final className = m.group(1);
    final classBody = m.group(2);
//    print('ClassName: $className, ClassBody: $classBody');
    try {
      final props = PropertyLineParser.parse(classBody);
      final c = DataClass(className, props);
      return c;
    } catch (e) {
      print('Failed to parse data class: $code, error: $e');
    }
    throw Error();
  }
}

@Deprecated('Using build_runner to traverse elements')
class PropertyLineParser {
  static final _regexCode = r'(?: *)(?:([a-zA-Z<,> ]*) (\w*))(?=;)';
  static final _regex =
      RegExp(_regexCode, multiLine: true, caseSensitive: true);

  static Map<String, String> parse(String code) {
    Map<String, String> result = {};
    final matches = _regex.allMatches(code);
    for (Match m in matches) {
      final name = m.group(2);
      final type = m.group(1);
      result[name] = type;
    }
    if (result.isEmpty) {
      throw Exception('No properties in the data class.');
    }
    return result;
  }
}
