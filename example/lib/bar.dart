import 'package:meta/meta.dart';
import 'package:auto_data/auto_data.dart';
import 'dart:convert';
import 'foo.dart';

part 'bar.g.dart';

@data
class $Bar {
  String fab;
  $Foo foo;
  Map<String, List<double>> accuracies;
}
