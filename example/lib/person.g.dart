// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoDataGenerator
// **************************************************************************

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
