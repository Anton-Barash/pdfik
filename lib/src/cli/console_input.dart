import 'dart:io';

/// Reads a line from stdin, returning `null` at end of input.
String? readLineOrNull() => stdin.readLineSync();

/// Removes surrounding quotes (common when pasting a path from Explorer)
/// and trims whitespace.
String cleanPath(String? raw) {
  if (raw == null) return '';
  String value = raw.trim();
  if (value.length >= 2 && value.startsWith('"') && value.endsWith('"')) {
    value = value.substring(1, value.length - 1);
  }
  return value.trim();
}