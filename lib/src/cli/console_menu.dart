import 'dart:io';

import '../l10n/app_language.dart';
import '../l10n/app_strings.dart';
import '../services/pdf_merger_service.dart';
import 'console_input.dart';
import 'merge_flow.dart';

/// Interactive text menu: language, source folder, destination folder, merge.
class ConsoleMenu {
  ConsoleMenu({
    required AppLanguage language,
    PdfMergerService service = const PdfMergerService(),
  })  : _strings = AppStrings.of(language),
        _service = service;

  AppStrings _strings;
  final PdfMergerService _service;

  String? _sourceFolder;
  String? _destinationFolder;

  /// Runs the menu loop until the user exits or stdin reaches end of input.
  Future<int> run() async {
    while (true) {
      _printMenu();

      final String? input = readLineOrNull();
      if (input == null) {
        stdout.writeln(_strings.menuGoodbye);
        return 0;
      }

      switch (input.trim()) {
        case '':
          break;
        case '1':
          _selectLanguage();
          break;
        case '2':
          _selectSourceFolder();
          break;
        case '3':
          _selectDestinationFolder();
          break;
        case '4':
          await _merge();
          break;
        case '0':
          stdout.writeln(_strings.menuGoodbye);
          return 0;
        default:
          stdout.writeln(_strings.menuInvalidChoice(input.trim()));
      }
    }
  }

  void _printMenu() {
    stdout.writeln();
    stdout.writeln(_strings.appTitle);
    stdout.writeln('--- ${_strings.menuTitle} ---');
    stdout.writeln(
      '  ${_strings.menuLabelLanguage}: ${_strings.languageName}',
    );
    stdout.writeln(
      '  ${_strings.menuLabelSource}: '
      '${_sourceFolder ?? _strings.menuNotSet}',
    );
    stdout.writeln(
      '  ${_strings.menuLabelDestination}: '
      '${_destinationFolder ?? _strings.menuNotSet}',
    );
    stdout.writeln();
    stdout.writeln('  1. ${_strings.menuOptionLanguage}');
    stdout.writeln('  2. ${_strings.menuOptionSource}');
    stdout.writeln('  3. ${_strings.menuOptionDestination}');
    stdout.writeln('  4. ${_strings.menuOptionMerge}');
    stdout.writeln('  0. ${_strings.menuOptionExit}');
    stdout.write(_strings.menuPromptChoice);
  }

  void _selectLanguage() {
    while (true) {
      stdout.writeln();
      stdout.writeln('--- ${_strings.languageMenuTitle} ---');
      stdout.writeln('  1. ${_strings.languageOptionRussian}');
      stdout.writeln('  2. ${_strings.languageOptionChinese}');
      stdout.writeln('  3. ${_strings.languageOptionEnglish}');
      stdout.writeln('  0. ${_strings.languageOptionBack}');
      stdout.write(_strings.menuPromptChoice);

      final String? input = readLineOrNull();
      if (input == null) return;

      final String choice = input.trim();
      if (choice == '0' || choice.isEmpty) return;

      final AppLanguage? selected = switch (choice) {
        '1' => AppLanguage.russian,
        '2' => AppLanguage.chinese,
        '3' => AppLanguage.english,
        _ => null,
      };

      if (selected == null) {
        stdout.writeln(_strings.menuInvalidChoice(choice));
        continue;
      }

      _strings = AppStrings.of(selected);
      stdout.writeln(_strings.infoLanguageChanged(_strings.languageName));
      return;
    }
  }

  void _selectSourceFolder() {
    stdout.write(_strings.promptSourceFolder);

    final String path = cleanPath(readLineOrNull());
    if (path.isEmpty) return;

    if (!Directory(path).existsSync()) {
      stdout.writeln(_strings.errorFolderNotFound(path));
      return;
    }

    _sourceFolder = path;
    stdout.writeln(_strings.infoSourceSelected(path));

    // Suggest a destination the first time a source folder is chosen.
    _destinationFolder ??= defaultDestinationFolder(path);
  }

  void _selectDestinationFolder() {
    stdout.write(_strings.promptDestinationFolder);

    final String path = cleanPath(readLineOrNull());
    if (path.isEmpty) return;

    _destinationFolder = path;
    stdout.writeln(_strings.infoDestinationSelected(path));
  }

  Future<void> _merge() async {
    final String? source = _sourceFolder;
    final String? destination = _destinationFolder;

    if (source == null) {
      stdout.writeln(_strings.errorSourceNotSet);
      _pause();
      return;
    }
    if (destination == null) {
      stdout.writeln(_strings.errorDestinationNotSet);
      _pause();
      return;
    }

    await runMerge(
      strings: _strings,
      sourceFolder: source,
      destinationFolder: destination,
      service: _service,
    );
    _pause();
  }

  void _pause() {
    stdout.write(_strings.pressEnterToContinue);
    readLineOrNull();
  }
}