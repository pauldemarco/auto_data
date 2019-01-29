// Copyright 2019, Paul DeMarco.
// All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

part of auto_data_generator;

Builder autoData(BuilderOptions _) =>
    new SharedPartBuilder([new AutoDataGenerator()], 'auto_data');

class DataClass {
  final String name;
  final List<DataClassProperty> props;
  final List<DataClassConstructor> constructors;
  final List<FieldElement> fieldElements;
  final List<ConstructorElement> constElements;
  final String documentationComment;

  DataClass(
    this.name,
    this.props,
    this.constructors,
    this.fieldElements,
    this.constElements, {
    this.documentationComment,
  });
}

class DataClassConstructor {
  final String declaration;
  final String documentationComment;

  DataClassConstructor(this.declaration, [this.documentationComment]);
}

class DataClassProperty {
  final String name;
  final String type;
  final bool isNullable;
  final bool isEnum;
  final String assignmentString;
  final String documentationComment;

  DataClassProperty(
    this.name,
    this.type,
    this.isNullable,
    this.isEnum, [
    this.assignmentString,
    this.documentationComment,
  ]);
}

class AutoDataGenerator extends Generator {
  const AutoDataGenerator();

  @override
  Future<String> generate(LibraryReader library, BuildStep buildStep) async {
    final classes = List<DataClass>();
    library.annotatedWith(TypeChecker.fromRuntime(Data)).forEach((e) {
      final visitor = DataElementVisitor(library);
      e.element.visitChildren(visitor);
      final c = DataClass(
        e.element.name.substring(1),
        visitor.props,
        visitor.constructors,
        visitor.fieldElements,
        visitor.constElements,
        documentationComment: e.element.documentationComment,
      );
      classes.add(c);
    });

    final result = FileGenerator.generate(classes);

    if (result.length > 0) {
      return result.toString().replaceAll('\$', '');
    }

    return null;
  }
}

class DataElementVisitor<T> extends SimpleElementVisitor<T> {
  final List<DataClassProperty> props = [];
  final List<DataClassConstructor> constructors = [];
  final List<FieldElement> fieldElements = [];
  final List<ConstructorElement> constElements = [];

  final LibraryReader library;

  DataElementVisitor(this.library);

  @override
  T visitFieldElement(FieldElement element) {
    props.add(_parseFieldElement(element));
    fieldElements.add(element);
  }

  @override
  T visitConstructorElement(ConstructorElement element) {
    final declaration = element.computeNode();
    if (declaration != null) {
      var s = element.computeNode().toSource();
      s = s.startsWith('\$') ? s.substring(1) : s;
      constructors.add(DataClassConstructor(s, element.documentationComment));
      constElements.add(element);
    }
  }

  DataClassProperty _parseFieldElement(FieldElement field) {
    final element = library.findType(field.type.name);
    final name = field.name;
    var type = field.type.displayName;
    final comment = field.documentationComment;
    final isNullable = field.metadata.any((a) => a.toSource() == '@nullable');
    final isEnum = element?.isEnum ?? false;
    var assignmentString = field.computeNode().toSource();
    assignmentString = assignmentString.substring(name.length);
    if (assignmentString.length <= 0) {
      assignmentString = null;
    }
    return DataClassProperty(
        name, type, isNullable, isEnum, assignmentString, comment);
  }
}
