# auto_data

Generates simple data classes for dart.

## Example

Specify the data class using the `@data` annotation:

```dart
import 'package:auto_data/auto_data.dart';

@data
class Person {
  String name;
  double weight;
  int age;
}
```

Generate using build_runner:

    pub run build_runner build

or

    pub run build_runner watch

Generated code has named constructor, ==/hashCode, toString, and copyWith:

```dart
class Person {
  final String name;
  final double weight;
  final int age;

  Person({
    this.name,
    this.weight,
    this.age,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Person &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          weight == other.weight &&
          age == other.age;

  @override
  int get hashCode => name.hashCode ^ weight.hashCode ^ age.hashCode;

  @override
  String toString() {
    return 'Person{name: $name, weight: $weight, age: $age}';
  }

  Person copyWith({
    String name,
    double weight,
    int age,
  }) {
    return Person(
      name: name ?? this.name,
      weight: weight ?? this.weight,
      age: age ?? this.age,
    );
  }
}
```

Make sure to import the generated file (*\*.g.dart*):
```dart
import 'package:example/person.g.dart';

var person = Person(name: 'Paul', weight: 160, age: 29);
var brother = person.copyWith(name: 'Joey', age:30);
```

## Requirements

Add the following to your pubspec.yaml:

```yaml
dependencies:
  auto_data:
    path: ../auto_data

dev_dependencies:
  build_runner: ^1.0.0
  auto_data_generator:
    path: ../auto_data_generator
```
