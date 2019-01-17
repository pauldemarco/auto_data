import 'package:meta/meta.dart';
import 'package:auto_data/auto_data.dart';

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

  /// Custom constructors are copied over
  $Person.genius()
  : name = 'Albert',
    weight = null, // Issue #1
    age = 140;
}
