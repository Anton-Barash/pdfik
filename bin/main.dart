import 'dart:io';

import 'package:pdfik/pdfik.dart';

Future<void> main(List<String> arguments) async {
  exitCode = await runPdfik(arguments);
}