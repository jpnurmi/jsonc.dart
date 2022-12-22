// Copyright (c) 2011, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:test/test.dart';
import 'package:jsonc/jsonc.dart';

void main() {
  test('parsing', () {
    // Scalars.
    expect(jsonc.decode(' 5 '), 5);
    expect(jsonc.decode(' -42 '), equals(-42));
    expect(jsonc.decode(' 3e0 '), equals(3));
    expect(jsonc.decode(' 3.14 '), equals(3.14));
    expect(jsonc.decode('true '), isTrue);
    expect(jsonc.decode(' false'), isFalse);
    expect(jsonc.decode(' null '), isNull);
    expect(jsonc.decode('\n\rnull\t'), isNull);
    expect(jsonc.decode(' "hi there\\" bob" '), equals('hi there" bob'));
    expect(jsonc.decode(' "" '), equals(''));

    // // Lists.
    expect(jsonc.decode(' [] '), equals([]));
    expect(jsonc.decode('[ ]'), equals([]));
    expect(jsonc.decode(' [3, -4.5, true, "hi", false] '),
        equals([3, -4.5, true, 'hi', false]));
    // // Nulls are tricky.
    expect(jsonc.decode('[null]'), equals([null]));
    expect(jsonc.decode(' [3, -4.5, null, true, "hi", false] '),
        equals([3, -4.5, null, true, 'hi', false]));
    expect(
        jsonc.decode('[[null]]'),
        equals([
          [null]
        ]));
    expect(
        jsonc.decode(' [ [3], [], [null], ["hi", true]] '),
        equals([
          [3],
          [],
          [null],
          ['hi', true]
        ]));

    // // Maps.
    expect(jsonc.decode(' {} '), equals({}));
    expect(jsonc.decode('{ }'), equals({}));

    expect(
        jsonc.decode(
            ' {"x":3, "y": -4.5,  "z" : "hi","u" : true, "v": false } '),
        equals({"x": 3, "y": -4.5, "z": "hi", "u": true, "v": false}));

    expect(jsonc.decode(' {"x":3, "y": -4.5,  "z" : "hi" } '),
        equals({"x": 3, "y": -4.5, "z": "hi"}));

    expect(jsonc.decode(' {"y": -4.5,  "z" : "hi" ,"x":3 } '),
        equals({"y": -4.5, "z": "hi", "x": 3}));

    expect(jsonc.decode('{ " hi bob " :3, "": 4.5}'),
        equals({" hi bob ": 3, "": 4.5}));

    expect(jsonc.decode(' { "x" : { } } '), equals({'x': {}}));
    expect(jsonc.decode('{"x":{}}'), equals({'x': {}}));

    // // Nulls are tricky.
    expect(jsonc.decode('{"w":null}'), equals({'w': null}));

    expect(
        jsonc.decode('{"x":{"w":null}}'),
        equals({
          "x": {"w": null}
        }));

    expect(
        jsonc.decode(' {"x":3, "y": -4.5,  "z" : "hi",'
            '"w":null, "u" : true, "v": false } '),
        equals(
            {"x": 3, "y": -4.5, "z": "hi", "w": null, "u": true, "v": false}));

    expect(
        jsonc.decode('{"x": {"a":3, "b": -4.5}, "y":[{}], '
            '"z":"hi","w":{"c":null,"d":true}, "v":null}'),
        equals({
          "x": {"a": 3, "b": -4.5},
          "y": [{}],
          "z": "hi",
          "w": {"c": null, "d": true},
          "v": null
        }));
  });
}
