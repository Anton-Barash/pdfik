import 'dart:io';
import 'dart:typed_data';

import 'package:path/path.dart' as p;
import 'package:pdf_document/pdf_document.dart';

/// Name of the merged output file created inside the output directory.
const String kMergedFileName = 'merged_all.pdf';

/// Name of the output sub-directory created inside the source folder.
const String kOutputDirName = 'out';

/// A PDF file that could not be read.
class PdfReadFailure {
  const PdfReadFailure(this.path, this.error);

  /// Absolute path of the file that failed.
  final String path;

  /// The error thrown while reading the file.
  final Object error;
}

/// Outcome of merging every readable PDF found in a folder.
class PdfMergeResult {
  const PdfMergeResult({
    required this.outputPath,
    required this.outputBytes,
    required this.sourceFileCount,
    required this.mergedFileCount,
    required this.failures,
  });

  /// Absolute path of the written merged file.
  final String outputPath;

  /// Size of the merged file in bytes.
  final int outputBytes;

  /// Number of PDF files discovered before reading.
  final int sourceFileCount;

  /// Number of files that were read and merged.
  final int mergedFileCount;

  /// Files that could not be read and were skipped.
  final List<PdfReadFailure> failures;

  /// True when at least one file was merged.
  bool get hasOutput => mergedFileCount > 0;
}

/// Discovers PDF files in a folder and merges them in path order.
class PdfMergerService {
  const PdfMergerService();

  /// Returns every `.pdf` file under [folder], sorted by full path.
  ///
  /// The output directory written by a previous run is skipped so repeated
  /// runs do not merge their own result back into the output.
  List<String> discoverPdfFiles(String folder) {
    final Directory root = Directory(folder);
    final String outputDir = p.canonicalize(p.join(folder, kOutputDirName));
    final List<String> files = <String>[];

    for (final FileSystemEntity entity
        in root.listSync(recursive: true, followLinks: false)) {
      if (entity is! File) continue;
      if (p.extension(entity.path).toLowerCase() != '.pdf') continue;

      final String canonical = p.canonicalize(entity.path);
      if (p.isWithin(outputDir, canonical)) continue;

      files.add(canonical);
    }

    files.sort();
    return files;
  }

  /// Reads [filePaths] in order and merges them into `<folder>/out/merged_all.pdf`.
  ///
  /// [onRead] is called before each file is read, allowing the caller to
  /// report progress. Files that cannot be read are collected in
  /// [PdfMergeResult.failures] instead of aborting the whole run.
  Future<PdfMergeResult> merge(
    String folder,
    List<String> filePaths, {
    void Function(int index, int total, String path)? onRead,
  }) async {
    final List<Uint8List> inputs = <Uint8List>[];
    final List<PdfReadFailure> failures = <PdfReadFailure>[];

    for (int i = 0; i < filePaths.length; i++) {
      final String path = filePaths[i];
      onRead?.call(i + 1, filePaths.length, path);
      try {
        inputs.add(await File(path).readAsBytes());
      } catch (error) {
        failures.add(PdfReadFailure(path, error));
      }
    }

    final Directory outputDir = Directory(p.join(folder, kOutputDirName));
    final File outputFile = File(p.join(outputDir.path, kMergedFileName));

    if (inputs.isEmpty) {
      return PdfMergeResult(
        outputPath: outputFile.path,
        outputBytes: 0,
        sourceFileCount: filePaths.length,
        mergedFileCount: 0,
        failures: failures,
      );
    }

    final Uint8List mergedBytes = PdfMerger.merge(inputs);
    await outputDir.create(recursive: true);
    await outputFile.writeAsBytes(mergedBytes, flush: true);

    return PdfMergeResult(
      outputPath: outputFile.path,
      outputBytes: mergedBytes.length,
      sourceFileCount: filePaths.length,
      mergedFileCount: inputs.length,
      failures: failures,
    );
  }
}