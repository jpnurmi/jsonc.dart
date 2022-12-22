// Copyright (c) 2012, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:jsonc/jsonc.dart';
import 'package:test/test.dart';

void main() {
  test('parse', () {
    // Scalars.
    expect(jsonc.decode(' 5 '), equals(5));
    expect(jsonc.decode(' -42 '), equals(-42));
    expect(jsonc.decode(' 3e0 '), equals(3));
    expect(jsonc.decode(' 3.14 '), equals(3.14));
    expect(jsonc.decode(' 1.0E-06 '), equals(1.0E-06));
    expect(jsonc.decode("0"), equals(0));
    expect(jsonc.decode("1"), equals(1));
    expect(jsonc.decode("0.1"), equals(0.1));
    expect(jsonc.decode("1.1"), equals(1.1));
    expect(jsonc.decode("1.100000"), equals(1.1));
    expect(jsonc.decode("1.111111"), equals(1.111111));
    expect(jsonc.decode("-0"), equals(-0));
    expect(jsonc.decode("-1"), equals(-1));
    expect(jsonc.decode("-0.1"), equals(-0.1));
    expect(jsonc.decode("-1.1"), equals(-1.1));
    expect(jsonc.decode("-1.100000"), equals(-1.1));
    expect(jsonc.decode("-1.111111"), equals(-1.111111));
    expect(jsonc.decode("1.1e1"), equals(11));
    expect(jsonc.decode("1.1e+1"), equals(11));
    expect(jsonc.decode("1.1e-1"), equals(0.11));
    expect(jsonc.decode("1.1E1"), equals(11));
    expect(jsonc.decode("1.1E+1"), equals(11));
    expect(jsonc.decode("1.1E-1"), equals(0.11));
    expect(jsonc.decode(" 1E0"), equals(1E0));
    expect(jsonc.decode(" 1E+0"), equals(1E+0));
    expect(jsonc.decode(" 1E-0"), equals(1E-0));
    expect(jsonc.decode(" 1E00"), equals(1E00));
    expect(jsonc.decode(" 1E+00"), equals(1E+00));
    expect(jsonc.decode(" 1E-00"), equals(1E-00));
    expect(jsonc.decode(" 1E+10"), equals(1E+10));
    expect(jsonc.decode(" 1E+010"), equals(1E+010));
    expect(jsonc.decode(" 1E+0010"), equals(1E+0010));
    expect(jsonc.decode(" 1E10"), equals(1E10));
    expect(jsonc.decode(" 1E010"), equals(1E010));
    expect(jsonc.decode(" 1E0010"), equals(1E0010));
    expect(jsonc.decode(" 1E-10"), equals(1E-10));
    expect(jsonc.decode(" 1E-0010"), equals(1E-0010));
    expect(jsonc.decode(" 1e0"), equals(1E0));
    expect(jsonc.decode(" 1e+0"), equals(1E+0));
    expect(jsonc.decode(" 1e-0"), equals(1E-0));
    expect(jsonc.decode(" 1e00"), equals(1E00));
    expect(jsonc.decode(" 1e+00"), equals(1E+00));
    expect(jsonc.decode(" 1e-00"), equals(1E-00));
    expect(jsonc.decode(" 1e+10"), equals(1E+10));
    expect(jsonc.decode(" 1e+010"), equals(1E+010));
    expect(jsonc.decode(" 1e+0010"), equals(1E+0010));
    expect(jsonc.decode(" 1e10"), equals(1E10));
    expect(jsonc.decode(" 1e010"), equals(1E010));
    expect(jsonc.decode(" 1e0010"), equals(1E0010));
    expect(jsonc.decode(" 1e-10"), equals(1E-10));
    expect(jsonc.decode(" 1e-0010"), equals(1E-0010));
    expect(jsonc.decode(' true '), equals(true));
    expect(jsonc.decode(' false'), equals(false));
    expect(jsonc.decode(' null '), equals(null));
    expect(jsonc.decode('\n\rnull\t'), equals(null));
    expect(jsonc.decode(' "hi there\\" bob" '), equals('hi there" bob'));
    expect(jsonc.decode(' "" '), equals(''));

    // Lists.
    expect(jsonc.decode(' [] '), equals([]));
    expect(jsonc.decode(' ["entry"] '), equals(["entry"]));
    expect(jsonc.decode(' [true, false] '), equals([true, false]));
    expect(jsonc.decode(' [ 1 , 2 , 3 ] '), equals([1, 2, 3]));

    // Maps.
    expect(jsonc.decode(' {} '), equals({}));
    expect(jsonc.decode(' {"key": "value" } '), equals({"key": "value"}));
    expect(jsonc.decode(' {"key1": 1, "key2": 2} '),
        equals({"key1": 1, "key2": 2}));
    expect(jsonc.decode(' { "key1" : 1 } '), equals({"key1": 1}));
  });

  test('parse invalid', () {
    void testString(String s) {
      expect(() => jsonc.decode(s), throwsFormatException);
    }

    // Scalars
    testString("");
    testString("-");
    testString("-.");
    testString("3.a");
    testString("{ key: value }");
    testString("tru");
    testString("1E--6");
    testString("1E-+6");
    testString("1E+-6");
    testString("1E++6");
    testString("1E6.6");
    testString("1E-6.6");
    testString("1E+6.6");

    // JavaScript number literals not valid in JSON.
    testString('[01]');
    testString('[.1]');
    testString('[1.]');
    testString('[1.e1]');
    testString('[-.1]');
    testString('[-1.]');

    // Plain invalid number literals.
    testString('-');
    testString('--1');
    testString('-1e');
    testString('1e--1]');
    testString('1e+-1');
    testString('1e-+1');
    testString('1e++1');

    // Lists
    testString('[, ]');
    testString('["", "]');
    testString('["" ""]');

    // Maps
    testString('{"" ""}');
  });
}
