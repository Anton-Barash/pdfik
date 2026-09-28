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
      'Объединяет все PDF-файлы из указанной папки (включая подпапки)\n'
      'в один файл out/merged_all.pdf.\n'
      '\n'
      'Параметры:\n'
      '  -l, --lang <код>   Язык сообщений: ru, zh или en\n'
      '  -h, --help         Показать эту справку\n'
      '\n'
      'Если папка не указана, путь будет запрошен интерактивно.\n'
      'Переменная окружения PDFIK_LANG задаёт язык по умолчанию.';

  @override
  String get promptFolderPath => 'Введите путь к папке с PDF: ';

  @override
  String get errorPathNotProvided => 'Путь не указан. Завершение работы.';

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