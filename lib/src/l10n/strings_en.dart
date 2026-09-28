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
      'With no arguments an interactive menu opens: choose the language,\n'
      'the source folder and the destination folder.\n'
      '\n'
      'With arguments the menu is skipped: every PDF file in the given folder\n'
      '(including subfolders) is merged into out/merged_all.pdf.\n'
      '\n'
      'Options:\n'
      '  -l, --lang <code>   Message language: ru, zh, or en\n'
      '  -h, --help          Show this help\n'
      '\n'
      'The PDFIK_LANG environment variable sets the default language.';

  @override
  String get languageName => 'English';

  // --- Interactive menu -----------------------------------------------------

  @override
  String get menuTitle => 'Menu';

  @override
  String get menuOptionLanguage => 'Interface language';

  @override
  String get menuOptionSource => 'Source folder';

  @override
  String get menuOptionDestination => 'Destination folder';

  @override
  String get menuOptionMerge => 'Merge PDFs';

  @override
  String get menuOptionExit => 'Exit';

  @override
  String get menuPromptChoice => 'Select an item: ';

  @override
  String menuInvalidChoice(String value) => 'Unknown item: $value';

  @override
  String get menuLabelLanguage => 'Language';

  @override
  String get menuLabelSource => 'Source';

  @override
  String get menuLabelDestination => 'Destination';

  @override
  String get menuNotSet => 'not set';

  @override
  String get languageMenuTitle => 'Choose language';

  @override
  String get languageOptionRussian => 'Русский';

  @override
  String get languageOptionChinese => '中文';

  @override
  String get languageOptionEnglish => 'English';

  @override
  String get languageOptionBack => 'Back';

  @override
  String infoLanguageChanged(String name) => 'Language changed: $name';

  @override
  String get promptSourceFolder => 'Path to the folder with PDF files: ';

  @override
  String get promptDestinationFolder => 'Path to the folder for the result: ';

  @override
  String get folderPickerTitleSource => 'Select the folder with PDF files';

  @override
  String get folderPickerTitleDestination => 'Select the folder for the result';

  @override
  String get infoFolderDialogOpening =>
      'Opening the folder selection window...';

  @override
  String infoSourceSelected(String path) => 'Source: $path';

  @override
  String infoDestinationSelected(String path) => 'Destination: $path';

  @override
  String get errorSourceNotSet => 'Select the source folder first (item 2).';

  @override
  String get errorDestinationNotSet =>
      'Select the destination folder first (item 3).';

  @override
  String errorDestinationCreate(String path, Object error) =>
      'Could not create destination folder $path: $error';

  @override
  String get pressEnterToContinue => 'Press Enter to return to the menu...';

  @override
  String get menuGoodbye => 'Exiting. Goodbye!';

  // --- Non-interactive CLI --------------------------------------------------

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