// Copyright 2019, Paul DeMarco.
// All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

part of auto_data_generator;

Builder autoData(BuilderOptions _) =>
    new LibraryBuilder(new AutoDataGenerator());

class DataClass {
  final String name;
  final Map<String, String> props;

  DataClass(this.name, this.props);

  @override
  String toString() {
    return 'DataClass{name: $name, props: $props}';
  }
}

class AutoDataGenerator extends Generator {
  const AutoDataGenerator();

  @override
  Future<String> generate(LibraryReader library, BuildStep buildStep) async {
    final classes = List<DataClass>();
    library.annotatedWith(TypeChecker.fromRuntime(Data)).forEach((e) {
      print('Handling class: ${e.element.name}');
      final visitor = DataElementVisitor();
      e.element.visitChildren(visitor);
      final c = DataClass(e.element.name, visitor.props);
      classes.add(c);
    });

    final result = FileGenerator.generate(classes);

    if (result.length > 0) {
      return result.toString();
    }

    return null;
  }
}

class DataElementVisitor<T> extends SimpleElementVisitor<T> {
  Map<String, String> props = {};

  @override
  T visitFieldElement(FieldElement field) {
    props[field.name] = field.type.displayName;
  }
}
