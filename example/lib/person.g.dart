// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'person.dart';

// **************************************************************************
// AutoDataGenerator
// **************************************************************************

/// All comments are copied to generated code
@immutable
class Person {
  /// This field gets a default value
  final String name;

  /// This field is not required
  final double weight;

  /// Age of the person
  final int age;

  const Person({
    this.name = 'Paul',
    this.weight,
    @required this.age,
  });

  /// Custom constructors are copied over
  Person.genius()
      : name = 'Albert',
        weight = null,
        age = 140;

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
    return 'Person{name: ' +
        name.toString() +
        ', weight: ' +
        weight.toString() +
        ', age: ' +
        age.toString() +
        '}';
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

  Person.fromFirebaseMap(Map m)
      : name = m['name'],
        weight = m['weight'],
        age = m['age'];

  Map toFirebaseMap() => {'name': name, 'weight': weight, 'age': age};
}
