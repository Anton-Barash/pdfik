/// Languages supported by the pdfik command-line interface.
enum AppLanguage {
  /// Russian (`ru`).
  russian('ru'),

  /// Chinese (`zh`).
  chinese('zh'),

  /// English (`en`).
  english('en');

  const AppLanguage(this.code);

  /// Primary BCP-47 language subtag, e.g. `ru`, `zh`, `en`.
  final String code;

  /// Parses a language tag such as `ru`, `ru-RU` or `zh_CN`.
  ///
  /// Returns `null` when [value] is empty or not a supported language.
  static AppLanguage? tryParse(String? value) {
    if (value == null) return null;
    final String normalized = value.trim().toLowerCase();
    if (normalized.isEmpty) return null;
    final String subtag = normalized.split(RegExp('[-_]')).first;
    for (final AppLanguage language in AppLanguage.values) {
      if (language.code == subtag) return language;
    }
    return null;
  }
}