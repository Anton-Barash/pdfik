import 'dart:io';

import 'package:path/path.dart' as p;

import '../l10n/app_strings.dart';
import '../services/pdf_merger_service.dart';

/// Discovers and merges every PDF of [sourceFolder] into [destinationFolder].
///
/// Prints localized progress and errors. Returns `true` when at least one file
/// was merged. Shared by the interactive menu and the non-interactive CLI.
Future<bool> runMerge({
  required AppStrings strings,
  required String sourceFolder,
  required String destinationFolder,
  PdfMergerService service = const PdfMergerService(),
}) async {
  if (!Directory(sourceFolder).existsSync()) {
    stderr.writeln(strings.errorFolderNotFound(sourceFolder));
    return false;
  }

  try {
    await Directory(destinationFolder).create(recursive: true);
  } catch (error) {
    stderr.writeln(strings.errorDestinationCreate(destinationFolder, error));
    return false;
  }

  final List<String> files = service.discoverPdfFiles(
    sourceFolder,
    excludeDirectory: destinationFolder,
    excludeFile: p.join(destinationFolder, kMergedFileName),
  );

  if (files.isEmpty) {
    stderr.writeln(strings.errorNoPdfFound(sourceFolder));
    return false;
  }

  stdout.writeln(strings.infoFoundFiles(files.length));
  stdout.writeln(strings.infoMerging(files.length));

  final PdfMergeResult result;
  try {
    result = await service.merge(
      filePaths: files,
      outputDirectory: destinationFolder,
      onRead: (index, total, path) =>
          stdout.writeln(strings.progressFile(index, total, path)),
    );
  } catch (error) {
    stderr.writeln(strings.errorMergeFailed(error));
    return false;
  }

  for (final PdfReadFailure failure in result.failures) {
    stderr.writeln(strings.errorReadFile(failure.path, failure.error));
  }
  if (!result.hasOutput) {
    stderr.writeln(strings.errorNoReadableFiles);
    return false;
  }

  stdout.writeln(strings.infoDone);
  stdout.writeln(strings.infoResultPath(result.outputPath));
  stdout.writeln(strings.infoResultSize(result.outputBytes));
  if (result.failures.isNotEmpty) {
    stdout.writeln(strings.warningReadFailures(result.failures.length));
  }
  return true;
}