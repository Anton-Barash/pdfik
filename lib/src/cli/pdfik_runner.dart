import 'dart:io';

import '../l10n/app_language.dart';
import '../l10n/app_strings.dart';
import '../services/pdf_merger_service.dart';
import 'console_menu.dart';
import 'merge_flow.dart';

/// Environment variable that selects the default message language.
const String kLanguageEnvVar = 'PDFIK_LANG';

/// Exit code used for command-line usage errors.
const int kUsageExitCode = 64;

/// Entry point of the pdfik command-line application.
///
/// With a folder argument the merge runs directly (script-friendly). Without
/// arguments an interactive menu is shown to pick the language, the source
/// folder and the destination folder.
Future<int> runPdfik(List<String> arguments) async {
  final _Options options = _Options.parse(arguments);
  final AppLanguage language = _resolveLanguage(options.language);
  final AppStrings strings = AppStrings.of(language);

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

  const PdfMergerService service = PdfMergerService();

  // Non-interactive fast path: a source folder was passed as an argument.
  final String? folder = options.folder;
  if (folder != null) {
    stdout.writeln(strings.appTitle);
    final bool success = await runMerge(
      strings: strings,
      sourceFolder: folder,
      destinationFolder: defaultDestinationFolder(folder),
      service: service,
    );
    return success ? 0 : 1;
  }

  // Interactive menu.
  return ConsoleMenu(language: language, service: service).run();
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