import 'package:meta/meta.dart';
import 'package:auto_data/auto_data.dart';
import 'package:collection/collection.dart';

part 'foo.g.dart';

@data
class $Foo {
  String bar;
  double baz;
  List<int> counters;
}
