import 'package:jsonc/jsonc.dart';

void main() {
  final json = jsonc.decode('''
{
  // one-line comment
  "foo": "bar",
  /*
   * multi-line block comment
   */
  "baz": "qux",
}
''');
  print(json); // {foo: bar, baz: qux}
}
