// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bar.dart';

// **************************************************************************
// AutoDataGenerator
// **************************************************************************

@immutable
class Bar {
  final String fab;
  final Foo foo;
  final Map<String, List<double>> accuracies;

  const Bar({
    @required this.fab,
    @required this.foo,
    @required this.accuracies,
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
    return 'Bar{fab: ' +
        fab.toString() +
        ', foo: ' +
        foo.toString() +
        ', accuracies: ' +
        accuracies.toString() +
        '}';
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

  Bar.fromFirebaseMap(Map m)
      : fab = m['fab'],
        foo = Foo.fromFirebaseMap(m['foo']),
        accuracies = m['accuracies'];

  Map toFirebaseMap() =>
      {'fab': fab, 'foo': foo.toFirebaseMap(), 'accuracies': accuracies};
}
