import 'app_language.dart';
import 'strings_en.dart';
import 'strings_ru.dart';
import 'strings_zh.dart';

/// Localized text used by the pdfik command-line interface.
///
/// Every user-visible string lives here so the application never hard-codes
/// messages. Add a new language by extending [AppLanguage], creating a
/// subclass and registering it in [AppStrings.of].
abstract class AppStrings {
  const AppStrings();

  /// Returns the string bundle for [language].
  static AppStrings of(AppLanguage language) => switch (language) {
    AppLanguage.russian => const RussianStrings(),
    AppLanguage.chinese => const ChineseStrings(),
    AppLanguage.english => const EnglishStrings(),
  };

  /// Banner printed when the program starts.
  String get appTitle;

  /// Usage instructions shown for `--help`.
  String get helpText;

  /// Name of the currently active language, written in that language.
  String get languageName;

  // --- Interactive menu -----------------------------------------------------

  /// Heading of the main menu.
  String get menuTitle;

  /// Main menu entry: change the interface language.
  String get menuOptionLanguage;

  /// Main menu entry: select the source folder.
  String get menuOptionSource;

  /// Main menu entry: select the destination folder.
  String get menuOptionDestination;

  /// Main menu entry: start merging.
  String get menuOptionMerge;

  /// Main menu entry: quit.
  String get menuOptionExit;

  /// Prompt asking for a menu item number.
  String get menuPromptChoice;

  /// The entered menu item is unknown.
  String menuInvalidChoice(String value);

  /// Label for the current language in the menu status block.
  String get menuLabelLanguage;

  /// Label for the source folder in the menu status block.
  String get menuLabelSource;

  /// Label for the destination folder in the menu status block.
  String get menuLabelDestination;

  /// Shown when a folder has not been selected yet.
  String get menuNotSet;

  /// Heading of the language sub-menu.
  String get languageMenuTitle;

  /// Language sub-menu entry for Russian.
  String get languageOptionRussian;

  /// Language sub-menu entry for Chinese.
  String get languageOptionChinese;

  /// Language sub-menu entry for English.
  String get languageOptionEnglish;

  /// Sub-menu entry returning to the main menu.
  String get languageOptionBack;

  /// Confirmation that the language was switched.
  String infoLanguageChanged(String name);

  /// Prompt asking for the source folder path.
  String get promptSourceFolder;

  /// Prompt asking for the destination folder path.
  String get promptDestinationFolder;

  /// Confirmation that the source folder was selected.
  String infoSourceSelected(String path);

  /// Confirmation that the destination folder was selected.
  String infoDestinationSelected(String path);

  /// Merge was requested without a source folder.
  String get errorSourceNotSet;

  /// Merge was requested without a destination folder.
  String get errorDestinationNotSet;

  /// The destination folder could not be created.
  String errorDestinationCreate(String path, Object error);

  /// Prompt shown after an action so the user can read the output.
  String get pressEnterToContinue;

  /// Farewell message when leaving the menu.
  String get menuGoodbye;

  // --- Non-interactive CLI --------------------------------------------------

  /// The requested folder does not exist.
  String errorFolderNotFound(String path);

  /// No PDF files were discovered in the folder.
  String errorNoPdfFound(String folder);

  /// An unsupported command-line option was passed.
  String errorUnknownOption(String option);

  /// The `--lang` value is not a supported language.
  String errorUnknownLanguage(String value);

  /// Number of PDF files discovered in the folder.
  String infoFoundFiles(int count);

  /// Merge is about to start for [count] files.
  String infoMerging(int count);

  /// Progress line for one file being read.
  String progressFile(int index, int total, String path);

  /// A single PDF file could not be read.
  String errorReadFile(String path, Object error);

  /// No file could be read, so nothing can be merged.
  String get errorNoReadableFiles;

  /// The merge operation itself failed.
  String errorMergeFailed(Object error);

  /// The merge finished successfully.
  String get infoDone;

  /// Absolute path of the merged file.
  String infoResultPath(String path);

  /// Size of the merged file, formatted with [formatSize].
  String infoResultSize(int bytes);

  /// Some files were skipped while reading.
  String warningReadFailures(int count);

  /// Formats a byte count using locale-appropriate units.
  String formatSize(int bytes);
}