import 'package:auto_data/auto_data.dart';

@data
class Foo {
  String bar;
  double baz;
  List<int> counters;
}

@data
class Bar {
  String fab;
  double faz;
  Map<String, List<double>> accuracies;
}
