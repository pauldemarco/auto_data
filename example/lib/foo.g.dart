// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'foo.dart';

// **************************************************************************
// AutoDataGenerator
// **************************************************************************

class Foo {
  final String bar;
  final double baz;
  final List<int> counters;

  Foo({
    this.bar,
    this.baz,
    this.counters,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Foo &&
          runtimeType == other.runtimeType &&
          bar == other.bar &&
          baz == other.baz &&
          counters == other.counters;

  @override
  int get hashCode => bar.hashCode ^ baz.hashCode ^ counters.hashCode;

  @override
  String toString() {
    return 'Foo{bar: $bar, baz: $baz, counters: $counters}';
  }

  Foo copyWith({
    String bar,
    double baz,
    List<int> counters,
  }) {
    return Foo(
      bar: bar ?? this.bar,
      baz: baz ?? this.baz,
      counters: counters ?? this.counters,
    );
  }
}
