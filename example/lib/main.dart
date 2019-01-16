import 'package:example/foo.dart';
import 'bar.dart';

void main() {
  final foo = new Foo();
  final bar = new Bar(foo: foo);
}
