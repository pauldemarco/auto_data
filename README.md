# auto_data

Generate simple data classes for dart.

## Example

Specify the data class using the `@data` annotation:

```dart
import 'package:meta/meta.dart';
import 'package:auto_data/auto_data.dart';

part 'point.g.dart';

@data
class $Point {
  double x;
  double y;
}
```

Generate using build_runner:

    pub run build_runner build

or

    pub run build_runner watch

Enjoy your generated named constructor, ==/hashCode, toString, and copyWith:

```dart
// GENERATED CODE - DO NOT MODIFY BY HAND
@immutable
class Point {
  final double x;
  final double y;

  const Point({
    @required this.x,
    @required this.y,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Point &&
          runtimeType == other.runtimeType &&
          x == other.x &&
          y == other.y;

  @override
  int get hashCode => x.hashCode ^ y.hashCode;

  @override
  String toString() {
    return 'Point{x: $x, y: $y}';
  }

  Point copyWith({
    double x,
    double y,
  }) {
    return Point(
      x: x ?? this.x,
      y: y ?? this.y,
    );
  }
}
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

## Advanced usage

```dart
import 'package:meta/meta.dart';
import 'package:auto_data/auto_data.dart';
import 'foo.dart';

part 'person.g.dart';

/// All comments are copied to generated code
@data
class $Person {
  /// This field gets a default value
  String name = 'Paul';

  /// This field is not required
  @nullable
  double weight;

  /// Age of the person
  int age;

  /// Depend on another generated class
  $Foo foo;

  /// Custom constructors are copied over
  $Person.genius()
  : name = 'Albert',
    age = 140;
}
```


## Todo's

- [ ] Optional constructor types (named, private, const, etc)
- [x] Custom constructors should be copied over ([Issue #1](https://github.com/pauldemarco/auto_data/issues/1))
- [x] Default values by assigning during declaration: `String name = 'Paul';`
- [x] Add @nullable annotation for fields that are not required
- [ ] Deep immutability for Map
- [ ] Deep immutability for List
- [ ] Serialization toMap/fromMap
- [ ] Serialization toJson/fromJson

## References

1. [Issue: Statically tracked shared immutable objects](https://github.com/dart-lang/language/issues/125)
1. [Proposal: Shared immutable objects](https://github.com/dart-lang/language/blob/master/working/0125-static-immutability/feature-specification.md)