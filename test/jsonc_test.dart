import 'package:jsonc/jsonc.dart';
import 'package:test/test.dart';

void main() {
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
