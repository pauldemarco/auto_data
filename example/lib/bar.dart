import 'package:auto_data/auto_data.dart';
import 'foo.dart';

part 'bar.g.dart';

@data
class $Bar {
  String fab;
  $Foo foo;
  Map<String, List<double>> accuracies;
}
