// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'foo.dart';

// **************************************************************************
// AutoDataGenerator
// **************************************************************************

@immutable
class Foo {
  final String bar;
  final double baz;
  final List<int> counters;

  Foo({
    @required this.bar,
    @required this.baz,
    @required List<int> counters,
  }) : counters = (counters != null) ? List.unmodifiable(counters) : null;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Foo &&
          runtimeType == other.runtimeType &&
          bar == other.bar &&
          baz == other.baz &&
          const ListEquality().equals(counters, other.counters);

  @override
  int get hashCode => bar.hashCode ^ baz.hashCode ^ counters.hashCode;

  @override
  String toString() {
    return 'Foo{bar: ' +
        bar.toString() +
        ', baz: ' +
        baz.toString() +
        ', counters: ' +
        counters.toString() +
        '}';
  }

  Foo copyWith({
    String bar,
    double baz,
    List<int> counters,
  }) {
    return Foo(
      bar: bar ?? this.bar,
      baz: baz ?? this.baz,
      counters: (counters != null)
          ? (counters == this.counters) ? counters.sublist(0) : counters
          : this.counters,
    );
  }

  Foo.fromFirebaseMap(Map m)
      : bar = m['bar'],
        baz = m['baz'],
        counters = (m['counters'] as Map).values.map((m) => m).toList();

  Map toFirebaseMap() => {
        'bar': bar,
        'baz': baz,
        'counters': Map.fromIterable(counters,
            key: (m) => m.hashCode, value: (m) => counters)
      };
}
