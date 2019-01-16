// GENERATED CODE - DO NOT MODIFY BY HAND

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

class Bar {
  final String fab;
  final double faz;
  final Map<String, List<double>> accuracies;

  Bar({
    this.fab,
    this.faz,
    this.accuracies,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Bar &&
          runtimeType == other.runtimeType &&
          fab == other.fab &&
          faz == other.faz &&
          accuracies == other.accuracies;

  @override
  int get hashCode => fab.hashCode ^ faz.hashCode ^ accuracies.hashCode;

  @override
  String toString() {
    return 'Bar{fab: $fab, faz: $faz, accuracies: $accuracies}';
  }

  Bar copyWith({
    String fab,
    double faz,
    Map<String, List<double>> accuracies,
  }) {
    return Bar(
      fab: fab ?? this.fab,
      faz: faz ?? this.faz,
      accuracies: accuracies ?? this.accuracies,
    );
  }
}
