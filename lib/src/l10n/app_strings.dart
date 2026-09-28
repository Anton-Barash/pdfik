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

  /// Interactive prompt asking for the folder path.
  String get promptFolderPath;

  /// The user submitted an empty path.
  String get errorPathNotProvided;

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