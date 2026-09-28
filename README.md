# pdfik

Консольное приложение на Dart: находит все PDF-файлы в папке (включая
подпапки), сортирует их по полному пути и объединяет в один файл
`merged_all.pdf`.

## Запуск (интерактивное меню)

```
dart pub get
dart run bin/main.dart
```

Без аргументов открывается текстовое меню:

```
--- Меню ---
  Язык: Русский
  Источник: не задано
  Назначение: не задано

  1. Язык интерфейса      # русский / 中文 / English
  2. Папка-источник       # откуда брать PDF
  3. Папка назначения     # куда положить результат
  4. Объединить PDF
  0. Выход
```

При выборе папки-источника папка назначения подставляется автоматически
как `<источник>/out`, но её можно изменить пунктом 3.

На Windows пункты 2 и 3 открывают системное окно выбора папки
(PowerShell + WinForms); на других платформах путь вводится вручную.

## Запуск без меню (для скриптов)

```
dart run bin/main.dart [--lang ru|zh|en] "C:\путь\к\папке"
```

Результат всегда пишется в `<папка>/out/merged_all.pdf`.

## Язык сообщений (русский, китайский, английский)

Язык выбирается пунктом меню «Язык интерфейса» либо в порядке приоритета:
флаг `--lang`, переменная окружения `PDFIK_LANG`, системная локаль,
иначе русский.

## Установка как команда `pdfik`

```
dart pub global activate --source path .
pdfik
```

## Сборка Windows .exe

```
dart compile exe bin/main.dart -o build/pdfik.exe
```

Готовый `.exe` также собирается в CI: workflow
`.github/workflows/windows-build.yml` (артефакт `pdfik-windows-x64`).

---

# pdfik (English)

A Dart console tool that merges every PDF file in a folder (recursively) into
`merged_all.pdf`.

```
dart pub get
dart run bin/main.dart                       # interactive menu
dart run bin/main.dart --lang en "C:\folder" # non-interactive
```

With no arguments an interactive menu opens: interface language (ru / zh / en),
source folder and destination folder. On Windows items 2 and 3 open a native
folder dialog; on other platforms the path is typed manually.

---

# pdfik (中文)

Dart 控制台工具：将文件夹（含子文件夹）中的所有 PDF 文件合并为一个文件
`merged_all.pdf`。

```
dart pub get
dart run bin/main.dart                       # 交互式菜单
dart run bin/main.dart --lang zh "C:\文件夹"  # 无菜单模式
```

不带参数时打开交互式菜单：界面语言（ru / zh / en）、源文件夹、目标文件夹。
在 Windows 上第 2、3 项会打开系统文件夹选择窗口；其他平台手动输入路径。

## Требования / Requirements

- Dart SDK 3.11+
- Зависимости / Dependencies: `path`, `pdf_document`