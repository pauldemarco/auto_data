import 'package:meta/meta.dart';
import 'package:auto_data/auto_data.dart';

part 'point.g.dart';

@data
class $Point {
  double x;
  double y;

  $Point.origin()
    : x = 0,
      y = 0;
}
