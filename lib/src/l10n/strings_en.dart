import 'app_strings.dart';

/// English messages.
class EnglishStrings extends AppStrings {
  const EnglishStrings();

  @override
  String get appTitle => '=== PDF Merger ===';

  @override
  String get helpText =>
      'Usage: pdfik [--lang ru|zh|en] [folder]\n'
      '\n'
      'Merges every PDF file in the given folder (including subfolders)\n'
      'into a single file out/merged_all.pdf.\n'
      '\n'
      'Options:\n'
      '  -l, --lang <code>   Message language: ru, zh, or en\n'
      '  -h, --help          Show this help\n'
      '\n'
      'When no folder is given, the path is requested interactively.\n'
      'The PDFIK_LANG environment variable sets the default language.';

  @override
  String get promptFolderPath => 'Enter the path to the PDF folder: ';

  @override
  String get errorPathNotProvided => 'No path provided. Exiting.';

  @override
  String errorFolderNotFound(String path) => 'Error: folder not found: $path';

  @override
  String errorNoPdfFound(String folder) =>
      'Error: no PDF files found in folder: $folder';

  @override
  String errorUnknownOption(String option) =>
      'Error: unknown option: $option';

  @override
  String errorUnknownLanguage(String value) =>
      'Error: unsupported language "$value". Available: ru, zh, en.';

  @override
  String infoFoundFiles(int count) => 'PDF files found: $count';

  @override
  String infoMerging(int count) => 'Merging $count files...';

  @override
  String progressFile(int index, int total, String path) =>
      '[$index/$total] $path';

  @override
  String errorReadFile(String path, Object error) =>
      'Failed to read file $path: $error';

  @override
  String get errorNoReadableFiles => 'Error: no PDF file could be read.';

  @override
  String errorMergeFailed(Object error) => 'Merge failed: $error';

  @override
  String get infoDone => 'Done.';

  @override
  String infoResultPath(String path) => 'Result: $path';

  @override
  String infoResultSize(int bytes) => 'Size: ${formatSize(bytes)}';

  @override
  String warningReadFailures(int count) => 'Read warnings: $count';

  @override
  String formatSize(int bytes) {
    const double kb = 1024;
    if (bytes < kb * kb) {
      return '${(bytes / kb).toStringAsFixed(1)} KB';
    }
    return '${(bytes / kb / kb).toStringAsFixed(1)} MB';
  }
}