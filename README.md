# pdfik

Консольное приложение на Dart: находит все PDF-файлы в папке (включая
подпапки), сортирует их по полному пути и объединяет в один файл
`out/merged_all.pdf` внутри исходной папки.

## Запуск

```
dart pub get
dart run bin/main.dart "C:\путь\к\папке"
```

Если папка не указана, путь запрашивается интерактивно.

## Язык сообщений (русский, китайский, английский)

```
dart run bin/main.dart --lang ru "C:\путь\к\папке"   # русский
dart run bin/main.dart --lang zh "C:\путь\к\папке"   # 中文
dart run bin/main.dart --lang en "C:\путь\к\папке"   # English
```

Язык определяется в порядке: флаг `--lang`, переменная окружения
`PDFIK_LANG`, системная локаль, иначе русский.

## Установка как команда `pdfik`

```
dart pub global activate --source path .
pdfik --help
```

---

# pdfik (English)

A Dart console tool that merges every PDF file in a folder (recursively) into
`out/merged_all.pdf`.

```
dart pub get
dart run bin/main.dart [--lang ru|zh|en] "C:\path\to\folder"
```

---

# pdfik (中文)

Dart 控制台工具：将文件夹（含子文件夹）中的所有 PDF 文件合并为一个文件
`out/merged_all.pdf`。

```
dart pub get
dart run bin/main.dart [--lang ru|zh|en] "C:\路径\文件夹"
```

## Требования / Requirements

- Dart SDK 3.11+
- Зависимости / Dependencies: `path`, `pdf_document`