/// pdfik - a small command-line tool that merges PDF files in a folder.
library;

export 'src/cli/console_menu.dart' show ConsoleMenu;
export 'src/cli/folder_picker.dart' show FolderPicker;
export 'src/cli/merge_flow.dart' show runMerge;
export 'src/cli/pdfik_runner.dart' show runPdfik;
export 'src/l10n/app_language.dart' show AppLanguage;
export 'src/l10n/app_strings.dart' show AppStrings;
export 'src/services/pdf_merger_service.dart'
    show
        PdfMergerService,
        PdfMergeResult,
        PdfReadFailure,
        defaultDestinationFolder,
        kMergedFileName,
        kOutputDirName;