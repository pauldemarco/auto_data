# auto_data

Generate simple data classes for Dart.

A data class is an immutable class meant to hold data, similar to Kotlin's [data class](https://kotlinlang.org/docs/reference/data-classes.html).

## Example

Specify the data class using the `@data` annotation:

```dart
@data
class $Point {
  double x;
  double y;
}
```

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
  auto_data: ^0.0.2

dev_dependencies:
  build_runner: ^1.0.0
  auto_data_generator: ^0.0.2
```

Create your `point.dart` file with correct imports:

```dart
import 'package:meta/meta.dart';
import 'package:collection/collection.dart';
import 'package:auto_data/auto_data.dart';

part 'point.g.dart';

@data
class $Point {
  double x;
  double y;
}
```

Lastly, generate using build_runner:

    pub run build_runner build

or

    pub run build_runner watch

Use your generated `Point` class:

```dart
import 'point.dart';

final p1 = Point(x: 0, y: 1);
final p2 = Point(x: 0, y: 2);
assert(p1 != p2);
final p3 = p1.copyWith(y: 2);
assert(p2 == p3);
print(p3.toString());
```

## Advanced usage

```dart
import 'package:collection/collection.dart';
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

  /// Deep comparison of lists
  List<$Person> friends;

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

## Limitations

### Cannot set values to null with copyWith

Ex) Clearing a user's avatar image:

```dart
profile = profile.copyWith(imageUrl: null); // This won't have an effect since copyWith ignores null input parameters.
```

## References

1. [Issue: Statically tracked shared immutable objects](https://github.com/dart-lang/language/issues/125)
1. [Proposal: Shared immutable objects](https://github.com/dart-lang/language/blob/master/working/0125-static-immutability/feature-specification.md)