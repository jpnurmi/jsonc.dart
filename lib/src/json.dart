// Based on dart-lang/sdk/lib/convert/json.dart
//
// Copyright (c) 2013, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';

import 'convert.dart';

/// An instance of the default implementation of the [JsoncCodec].
///
/// This instance provides a convenient access to the most common JSON
/// use cases.
///
/// Examples:
/// ```dart
/// var encoded = jsonc.encode([1, 2, { "a": null }]);
/// var decoded = jsonc.decode('["foo", { "bar": 499 }]');
/// ```
/// The top-level [jsoncEncode] and [jsoncDecode] functions may be used instead
/// if a local variable shadows the [jsonc] constant.
const JsoncCodec jsonc = JsoncCodec();

/// Converts [object] to a JSON string.
String jsoncEncode(Object? object,
        {Object? Function(Object? nonEncodable)? toEncodable}) =>
    jsonc.encode(object, toEncodable: toEncodable);

/// Parses the JSON string with comments and returns the resulting JSON object.
dynamic jsoncDecode(String source,
        {Object? Function(Object? key, Object? value)? reviver}) =>
    jsonc.decode(source, reviver: reviver);

/// A [JsoncCodec] encodes JSON objects to strings and decodes JSON strings with
/// comments to JSON objects.
///
/// Examples:
/// ```dart
/// var encoded = jsonc.encode([1, 2, { "a": null }]);
/// var decoded = jsonc.decode('["foo", { "bar": 499 }]');
/// ```
class JsoncCodec extends JsonCodec {
  final Object? Function(Object? key, Object? value)? _reviver;

  const JsoncCodec({super.reviver, super.toEncodable}) : _reviver = reviver;

  const JsoncCodec.withReviver(
      dynamic Function(Object? key, Object? value) reviver)
      : this(reviver: reviver);

  @override
  dynamic decode(String source,
      {Object? Function(Object? key, Object? value)? reviver}) {
    reviver ??= _reviver;
    if (reviver == null) return decoder.convert(source);
    return JsoncDecoder(reviver).convert(source);
  }

  @override
  JsonDecoder get decoder {
    if (_reviver == null) return const JsoncDecoder();
    return JsoncDecoder(_reviver);
  }
}

/// Parses JSON strings with comments and builds the corresponding objects.
///
/// See also [JsonDecoder].
class JsoncDecoder extends JsonDecoder {
  final Object? Function(Object? key, Object? value)? _reviver;

  const JsoncDecoder([super.reviver]) : _reviver = reviver;

  @override
  dynamic convert(String input) => parseJsonc(input, _reviver);

  @override
  StringConversionSink startChunkedConversion(Sink<Object?> sink) {
    throw UnsupportedError('JsoncDecoder does not support chunked conversion');
  }
}
