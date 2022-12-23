import 'package:jsonc/jsonc.dart';
import 'package:test/test.dart';

void main() {
  test('plus sign', () {
    expect(jsoncDecode('+5'), 5);
    expect(jsoncDecode('+42'), 42);
    expect(jsoncDecode('+3e0'), 3);
    expect(jsoncDecode('+3.14'), 3.14);
  });

  test('hex number', () {
    expect(jsoncDecode('0x5'), 0x5);
    expect(jsoncDecode('0X5'), 0x5);
    expect(jsoncDecode('0x42'), 0x42);
    expect(jsoncDecode('0X42'), 0x42);

    expect(jsoncDecode('{"x": 0x5}'), {'x': 0x5});
    expect(jsoncDecode('{"x": 0X5}'), {'x': 0x5});
    expect(jsoncDecode('{"x": 0x42}'), {'x': 0x42});
    expect(jsoncDecode('{"x": 0X42}'), {'x': 0x42});
  });

  test('line comment', () {
    expect(jsoncDecode('// comment\n{ "foo": true }'), {'foo': true});
    expect(jsoncDecode('{\n// comment\n"foo": true }'), {'foo': true});
    expect(jsoncDecode('{ "foo": // comment\ntrue }'), {'foo': true});
    expect(jsoncDecode('{ "foo": true // comment\n}'), {'foo': true});
    expect(jsoncDecode('{ "foo": true } // comment'), {'foo': true});
  });

  test('block comment', () {
    expect(jsoncDecode('/*comment*/ { "foo": true }'), {'foo': true});
    expect(jsoncDecode('{ /*comment*/ "foo": true }'), {'foo': true});
    expect(jsoncDecode('{ "foo": /*comment*/ true }'), {'foo': true});
    expect(jsoncDecode('{ "foo": true /*comment*/ }'), {'foo': true});
    expect(jsoncDecode('{ "foo": true } /*comment*/'), {'foo': true});
  });

  test('trailing comma', () {
    expect(jsoncDecode('{ "hello": [], }'), {'hello': []});
    expect(jsoncDecode('{ "hello": [] }'), {'hello': []});
    expect(jsoncDecode('{ "hello": [], "world": {}, }'),
        {'hello': [], 'world': {}});
    expect(jsoncDecode('{ "hello": [], "world": {} }'),
        {'hello': [], 'world': {}});
    expect(jsoncDecode('[ 1, 2, ]'), [1, 2]);
    expect(jsoncDecode('[ 1, 2 ]'), [1, 2]);
    expect(jsoncDecode('[1,2,]'), [1, 2]);
    expect(jsoncDecode('["", ]'), ['']);
    expect(jsoncDecode('{"": "",}'), {'': ''});
  });

  test('vscode', () {
    expect(jsoncDecode('''
{
  // Use IntelliSense to learn about possible attributes.
  // Hover to view descriptions of existing attributes.
  // For more information, visit: https://go.microsoft.com/fwlink/?linkid=830387
  "version": "0.2.0",
  "configurations": [
    {
      "name": "jsonc.dart",
      "request": "launch",
      "type": "dart",
      "program": "example/main.dart",
      "args": [
        "--enable-asserts",
      ],
    }
  ]
}'''), {
      'version': '0.2.0',
      'configurations': [
        {
          'name': 'jsonc.dart',
          'request': 'launch',
          'type': 'dart',
          'program': 'example/main.dart',
          'args': [
            '--enable-asserts',
          ],
        }
      ]
    });
  });
}
