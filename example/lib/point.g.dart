// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'point.dart';

// **************************************************************************
// AutoDataGenerator
// **************************************************************************

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
