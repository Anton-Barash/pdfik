import 'dart:io';

import '../l10n/app_language.dart';
import '../l10n/app_strings.dart';
import '../services/pdf_merger_service.dart';
import 'console_input.dart';
import 'folder_picker.dart';
import 'merge_flow.dart';

/// Interactive text menu: language, source folder, destination folder, merge.
class ConsoleMenu {
  ConsoleMenu({
    required AppLanguage language,
    PdfMergerService service = const PdfMergerService(),
    FolderPicker picker = const FolderPicker(),
  })  : _strings = AppStrings.of(language),
        _service = service,
        _picker = picker;

  AppStrings _strings;
  final PdfMergerService _service;
  final FolderPicker _picker;

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
          await _selectSourceFolder();
          break;
        case '3':
          await _selectDestinationFolder();
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

  Future<void> _selectSourceFolder() async {
    final String? path = await _askFolder(
      prompt: _strings.promptSourceFolder,
      title: _strings.folderPickerTitleSource,
      initialDirectory: _sourceFolder ?? _destinationFolder,
    );
    if (path == null || path.isEmpty) return;

    if (!Directory(path).existsSync()) {
      stdout.writeln(_strings.errorFolderNotFound(path));
      return;
    }

    _sourceFolder = path;
    stdout.writeln(_strings.infoSourceSelected(path));

    // Suggest a destination the first time a source folder is chosen.
    _destinationFolder ??= defaultDestinationFolder(path);
  }

  Future<void> _selectDestinationFolder() async {
    final String? path = await _askFolder(
      prompt: _strings.promptDestinationFolder,
      title: _strings.folderPickerTitleDestination,
      initialDirectory: _destinationFolder ?? _sourceFolder,
    );
    if (path == null || path.isEmpty) return;

    _destinationFolder = path;
    stdout.writeln(_strings.infoDestinationSelected(path));
  }

  /// Shows the native dialog when available, otherwise asks for a typed path.
  ///
  /// Returns `null` when the user cancels the dialog or enters nothing.
  Future<String?> _askFolder({
    required String prompt,
    required String title,
    String? initialDirectory,
  }) async {
    if (_picker.isSupported) {
      stdout.writeln(_strings.infoFolderDialogOpening);
      final String? picked = await _picker.pick(
        title: title,
        initialDirectory: initialDirectory,
      );
      return picked;
    }

    stdout.write(prompt);
    return cleanPath(readLineOrNull());
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