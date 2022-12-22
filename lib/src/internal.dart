// Based on dart-lang/sdk/lib/internal/internal.dart
//
// Copyright (c) 2012, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// ignore_for_file: constant_identifier_names

// Powers of 10 up to 10^22 are representable as doubles.
// Powers of 10 above that are only approximate due to lack of precision.
// Used by double-parsing.
const POWERS_OF_TEN = [
  1.0, // 0
  10.0,
  100.0,
  1000.0,
  10000.0,
  100000.0, // 5
  1000000.0,
  10000000.0,
  100000000.0,
  1000000000.0,
  10000000000.0, // 10
  100000000000.0,
  1000000000000.0,
  10000000000000.0,
  100000000000000.0,
  1000000000000000.0, // 15
  10000000000000000.0,
  100000000000000000.0,
  1000000000000000000.0,
  10000000000000000000.0,
  100000000000000000000.0, // 20
  1000000000000000000000.0,
  10000000000000000000000.0,
];
