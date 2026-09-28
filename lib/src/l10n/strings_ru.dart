import 'app_strings.dart';

/// Russian messages.
class RussianStrings extends AppStrings {
  const RussianStrings();

  @override
  String get appTitle => '=== Объединение PDF-файлов ===';

  @override
  String get helpText =>
      'Использование: pdfik [--lang ru|zh|en] [папка]\n'
      '\n'
      'Без аргументов открывается интерактивное меню: выбор языка,\n'
      'папки-источника и папки назначения.\n'
      '\n'
      'С аргументами программа работает без меню: объединяет все PDF-файлы\n'
      'из указанной папки (включая подпапки) в out/merged_all.pdf.\n'
      '\n'
      'Параметры:\n'
      '  -l, --lang <код>   Язык сообщений: ru, zh или en\n'
      '  -h, --help         Показать эту справку\n'
      '\n'
      'Переменная окружения PDFIK_LANG задаёт язык по умолчанию.';

  @override
  String get languageName => 'Русский';

  // --- Interactive menu -----------------------------------------------------

  @override
  String get menuTitle => 'Меню';

  @override
  String get menuOptionLanguage => 'Язык интерфейса';

  @override
  String get menuOptionSource => 'Папка-источник';

  @override
  String get menuOptionDestination => 'Папка назначения';

  @override
  String get menuOptionMerge => 'Объединить PDF';

  @override
  String get menuOptionExit => 'Выход';

  @override
  String get menuPromptChoice => 'Выберите пункт: ';

  @override
  String menuInvalidChoice(String value) => 'Неизвестный пункт: $value';

  @override
  String get menuLabelLanguage => 'Язык';

  @override
  String get menuLabelSource => 'Источник';

  @override
  String get menuLabelDestination => 'Назначение';

  @override
  String get menuNotSet => 'не задано';

  @override
  String get languageMenuTitle => 'Выбор языка';

  @override
  String get languageOptionRussian => 'Русский';

  @override
  String get languageOptionChinese => '中文';

  @override
  String get languageOptionEnglish => 'English';

  @override
  String get languageOptionBack => 'Назад';

  @override
  String infoLanguageChanged(String name) => 'Язык изменён: $name';

  @override
  String get promptSourceFolder => 'Путь к папке с PDF-файлами: ';

  @override
  String get promptDestinationFolder => 'Путь к папке для результата: ';

  @override
  String get folderPickerTitleSource => 'Выберите папку с PDF-файлами';

  @override
  String get folderPickerTitleDestination => 'Выберите папку для результата';

  @override
  String get infoFolderDialogOpening => 'Открывается окно выбора папки...';

  @override
  String infoSourceSelected(String path) => 'Источник: $path';

  @override
  String infoDestinationSelected(String path) => 'Назначение: $path';

  @override
  String get errorSourceNotSet =>
      'Сначала выберите папку-источник (пункт 2).';

  @override
  String get errorDestinationNotSet =>
      'Сначала выберите папку назначения (пункт 3).';

  @override
  String errorDestinationCreate(String path, Object error) =>
      'Не удалось создать папку назначения $path: $error';

  @override
  String get pressEnterToContinue => 'Нажмите Enter для возврата в меню...';

  @override
  String get menuGoodbye => 'Выход. До свидания!';

  // --- Non-interactive CLI --------------------------------------------------

  @override
  String errorFolderNotFound(String path) =>
      'Ошибка: папка не существует: $path';

  @override
  String errorNoPdfFound(String folder) =>
      'Ошибка: PDF-файлы не найдены в папке: $folder';

  @override
  String errorUnknownOption(String option) =>
      'Ошибка: неизвестный параметр: $option';

  @override
  String errorUnknownLanguage(String value) =>
      'Ошибка: неподдерживаемый язык "$value". Доступны: ru, zh, en.';

  @override
  String infoFoundFiles(int count) => 'Найдено PDF-файлов: $count';

  @override
  String infoMerging(int count) => 'Объединение $count файлов...';

  @override
  String progressFile(int index, int total, String path) =>
      '[$index/$total] $path';

  @override
  String errorReadFile(String path, Object error) =>
      'Ошибка чтения файла $path: $error';

  @override
  String get errorNoReadableFiles =>
      'Ошибка: не удалось прочитать ни один PDF-файл.';

  @override
  String errorMergeFailed(Object error) => 'Ошибка при объединении: $error';

  @override
  String get infoDone => 'Готово.';

  @override
  String infoResultPath(String path) => 'Результат: $path';

  @override
  String infoResultSize(int bytes) => 'Размер: ${formatSize(bytes)}';

  @override
  String warningReadFailures(int count) =>
      'Предупреждений при чтении: $count';

  @override
  String formatSize(int bytes) {
    const double kb = 1024;
    if (bytes < kb * kb) {
      return '${(bytes / kb).toStringAsFixed(1)} КБ';
    }
    return '${(bytes / kb / kb).toStringAsFixed(1)} МБ';
  }
}