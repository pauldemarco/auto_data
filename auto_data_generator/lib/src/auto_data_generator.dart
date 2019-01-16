// Copyright 2019, Paul DeMarco.
// All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

part of auto_data_generator;

Builder autoData(BuilderOptions _) =>
    new SharedPartBuilder([new AutoDataGenerator()], 'auto_data');

class DataClass {
  final String name;
  final List<DataClassProperty> props;
  final String documentationComment;

  DataClass(this.name, this.props, [this.documentationComment]);
}

class DataClassProperty {
  final String name;
  final String type;
  final String documentationComment;

  DataClassProperty(this.name, this.type, [this.documentationComment]);
}

class AutoDataGenerator extends Generator {
  const AutoDataGenerator();

  @override
  Future<String> generate(LibraryReader library, BuildStep buildStep) async {
    final classes = List<DataClass>();
    library.annotatedWith(TypeChecker.fromRuntime(Data)).forEach((e) {
      final visitor = DataElementVisitor();
      e.element.visitChildren(visitor);
      final c = DataClass(e.element.name.substring(1), visitor.props,
          e.element.documentationComment);
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
  List<DataClassProperty> props = [];

  @override
  T visitFieldElement(FieldElement field) {
    final name = field.name;
    var type = field.type.displayName;
    type = type.startsWith('\$') ? type.substring(1) : type;
    final comment = field.documentationComment;
    final prop = DataClassProperty(name, type, comment);
    props.add(prop);
  }
}
