# jsonc.dart

[![pub](https://img.shields.io/pub/v/jsonc.svg)](https://pub.dev/packages/jsonc)
[![license: BSD](https://img.shields.io/badge/license-BSD-yellow.svg)](https://opensource.org/licenses/BSD-3-Clause)
[![CI](https://github.com/ubuntu-flutter-community/jsonc.dart/actions/workflows/ci.yaml/badge.svg)](https://github.com/ubuntu-flutter-community/jsonc.dart/actions/workflows/ci.yaml)
[![codecov](https://codecov.io/gh/ubuntu-flutter-community/jsonc.dart/branch/main/graph/badge.svg?token=UPEXMCJDCN)](https://codecov.io/gh/ubuntu-flutter-community/jsonc.dart)

JSON with comments and trailing commas.

```dart
import 'package:jsonc/jsonc.dart';
```

```dart
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
```
