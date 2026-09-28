import 'dart:io';

import '../l10n/app_language.dart';
import '../l10n/app_strings.dart';
import '../services/pdf_merger_service.dart';

/// Environment variable that selects the default message language.
const String kLanguageEnvVar = 'PDFIK_LANG';

/// Exit code used for command-line usage errors.
const int kUsageExitCode = 64;

/// Entry point of the pdfik command-line application.
///
/// Parses [arguments], resolves the message language, merges the PDF files of
/// the selected folder and returns the process exit code.
Future<int> runPdfik(List<String> arguments) async {
  final _Options options = _Options.parse(arguments);
  final AppStrings strings = AppStrings.of(_resolveLanguage(options.language));

  if (options.help) {
    stdout.writeln(strings.helpText);
    return 0;
  }
  if (options.unknownLanguage != null) {
    stderr.writeln(strings.errorUnknownLanguage(options.unknownLanguage!));
    stderr.writeln(strings.helpText);
    return kUsageExitCode;
  }
  if (options.unknownOption != null) {
    stderr.writeln(strings.errorUnknownOption(options.unknownOption!));
    stderr.writeln(strings.helpText);
    return kUsageExitCode;
  }

  stdout.writeln(strings.appTitle);

  final String folder = options.folder ?? _promptForFolder(strings);
  if (folder.isEmpty) {
    stderr.writeln(strings.errorPathNotProvided);
    return 1;
  }
  if (!Directory(folder).existsSync()) {
    stderr.writeln(strings.errorFolderNotFound(folder));
    return 1;
  }

  const PdfMergerService service = PdfMergerService();
  final List<String> files = service.discoverPdfFiles(folder);
  if (files.isEmpty) {
    stderr.writeln(strings.errorNoPdfFound(folder));
    return 1;
  }

  stdout.writeln(strings.infoFoundFiles(files.length));
  stdout.writeln(strings.infoMerging(files.length));

  final PdfMergeResult result;
  try {
    result = await service.merge(
      folder,
      files,
      onRead: (index, total, path) =>
          stdout.writeln(strings.progressFile(index, total, path)),
    );
  } catch (error) {
    stderr.writeln(strings.errorMergeFailed(error));
    return 1;
  }

  for (final PdfReadFailure failure in result.failures) {
    stderr.writeln(strings.errorReadFile(failure.path, failure.error));
  }
  if (!result.hasOutput) {
    stderr.writeln(strings.errorNoReadableFiles);
    return 1;
  }

  stdout.writeln(strings.infoDone);
  stdout.writeln(strings.infoResultPath(result.outputPath));
  stdout.writeln(strings.infoResultSize(result.outputBytes));
  if (result.failures.isNotEmpty) {
    stdout.writeln(strings.warningReadFailures(result.failures.length));
  }
  return 0;
}

/// Resolves the message language from the CLI flag, the environment variable
/// and the operating-system locale, falling back to Russian.
AppLanguage _resolveLanguage(AppLanguage? explicit) {
  if (explicit != null) return explicit;

  final AppLanguage? fromEnv =
      AppLanguage.tryParse(Platform.environment[kLanguageEnvVar]);
  if (fromEnv != null) return fromEnv;

  final AppLanguage? fromSystem = AppLanguage.tryParse(Platform.localeName);
  if (fromSystem != null) return fromSystem;

  return AppLanguage.russian;
}

/// Asks the user for the folder path interactively.
String _promptForFolder(AppStrings strings) {
  stdout.write(strings.promptFolderPath);
  return _cleanPath(stdin.readLineSync());
}

/// Removes surrounding quotes (common when pasting a path from Explorer)
/// and trims whitespace.
String _cleanPath(String? raw) {
  if (raw == null) return '';
  String value = raw.trim();
  if (value.length >= 2 && value.startsWith('"') && value.endsWith('"')) {
    value = value.substring(1, value.length - 1);
  }
  return value.trim();
}

/// Parsed command-line arguments.
class _Options {
  const _Options({
    this.language,
    this.folder,
    this.help = false,
    this.unknownOption,
    this.unknownLanguage,
  });

  final AppLanguage? language;
  final String? folder;
  final bool help;
  final String? unknownOption;
  final String? unknownLanguage;

  static _Options parse(List<String> arguments) {
    AppLanguage? language;
    String? folder;
    bool help = false;
    String? unknownOption;
    String? unknownLanguage;

    for (int i = 0; i < arguments.length; i++) {
      final String argument = arguments[i];

      if (argument == '-h' || argument == '--help') {
        help = true;
      } else if (argument == '-l' || argument == '--lang') {
        if (i + 1 >= arguments.length) {
          unknownOption = argument;
        } else {
          final String value = arguments[++i];
          final AppLanguage? parsed = AppLanguage.tryParse(value);
          if (parsed == null) {
            unknownLanguage = value;
          } else {
            language = parsed;
          }
        }
      } else if (argument.startsWith('-')) {
        unknownOption ??= argument;
      } else {
        folder ??= argument;
      }
    }

    return _Options(
      language: language,
      folder: folder,
      help: help,
      unknownOption: unknownOption,
      unknownLanguage: unknownLanguage,
    );
  }
}