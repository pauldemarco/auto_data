// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bar.dart';

// **************************************************************************
// AutoDataGenerator
// **************************************************************************

class Bar {
  final String fab;
  final Foo foo;
  final Map<String, List<double>> accuracies;

  Bar({
    this.fab,
    this.foo,
    this.accuracies,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Bar &&
          runtimeType == other.runtimeType &&
          fab == other.fab &&
          foo == other.foo &&
          accuracies == other.accuracies;

  @override
  int get hashCode => fab.hashCode ^ foo.hashCode ^ accuracies.hashCode;

  @override
  String toString() {
    return 'Bar{fab: $fab, foo: $foo, accuracies: $accuracies}';
  }

  Bar copyWith({
    String fab,
    Foo foo,
    Map<String, List<double>> accuracies,
  }) {
    return Bar(
      fab: fab ?? this.fab,
      foo: foo ?? this.foo,
      accuracies: accuracies ?? this.accuracies,
    );
  }
}
