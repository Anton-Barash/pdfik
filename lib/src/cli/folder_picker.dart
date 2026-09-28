import 'dart:io';

/// Opens a native folder-selection dialog.
///
/// Windows is supported through Windows PowerShell and the WinForms
/// `FolderBrowserDialog`, so the tool keeps working without extra packages.
/// On other platforms [isSupported] is `false` and callers fall back to a
/// manual path prompt.
class FolderPicker {
  const FolderPicker();

  /// Whether a native dialog can be shown on this platform.
  bool get isSupported => Platform.isWindows;

  /// Shows the dialog and returns the chosen path.
  ///
  /// Returns `null` when the user cancels, when the platform is unsupported,
  /// or when PowerShell is unavailable. The title and the starting folder are
  /// passed through environment variables so no value is interpolated into the
  /// script itself.
  Future<String?> pick({String? title, String? initialDirectory}) async {
    if (!isSupported) return null;

    const String script = r'''
Add-Type -AssemblyName System.Windows.Forms | Out-Null
$dialog = New-Object System.Windows.Forms.FolderBrowserDialog
$dialog.ShowNewFolderButton = $true
if ($env:PDFIK_PICKER_TITLE) { $dialog.Description = $env:PDFIK_PICKER_TITLE }
if ($env:PDFIK_PICKER_INITIAL -and (Test-Path -LiteralPath $env:PDFIK_PICKER_INITIAL)) { $dialog.SelectedPath = $env:PDFIK_PICKER_INITIAL }
$result = $dialog.ShowDialog()
if ($result -eq [System.Windows.Forms.DialogResult]::OK) { [Console]::Out.Write($dialog.SelectedPath) }
''';

    try {
      final ProcessResult result = await Process.run(
        'powershell',
        <String>['-NoProfile', '-STA', '-Command', script],
        environment: <String, String>{
          'PDFIK_PICKER_TITLE': title ?? '',
          'PDFIK_PICKER_INITIAL': initialDirectory ?? '',
        },
      );
      if (result.exitCode != 0) return null;

      final String output = '${result.stdout}'.trim();
      return output.isEmpty ? null : output;
    } on ProcessException {
      return null;
    }
  }
}