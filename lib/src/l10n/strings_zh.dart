import 'app_strings.dart';

/// Chinese (Simplified) messages.
class ChineseStrings extends AppStrings {
  const ChineseStrings();

  @override
  String get appTitle => '=== PDF 文件合并 ===';

  @override
  String get helpText =>
      '用法: pdfik [--lang ru|zh|en] [文件夹]\n'
      '\n'
      '不带参数时打开交互式菜单：选择语言、源文件夹和目标文件夹。\n'
      '\n'
      '带参数时不显示菜单：将指定文件夹（含子文件夹）中的所有 PDF 文件\n'
      '合并为 out/merged_all.pdf。\n'
      '\n'
      '选项:\n'
      '  -l, --lang <代码>   消息语言: ru、zh 或 en\n'
      '  -h, --help          显示此帮助\n'
      '\n'
      '环境变量 PDFIK_LANG 设置默认语言。';

  @override
  String get languageName => '中文';

  // --- Interactive menu -----------------------------------------------------

  @override
  String get menuTitle => '菜单';

  @override
  String get menuOptionLanguage => '界面语言';

  @override
  String get menuOptionSource => '源文件夹';

  @override
  String get menuOptionDestination => '目标文件夹';

  @override
  String get menuOptionMerge => '合并 PDF';

  @override
  String get menuOptionExit => '退出';

  @override
  String get menuPromptChoice => '请选择项目: ';

  @override
  String menuInvalidChoice(String value) => '未知项目：$value';

  @override
  String get menuLabelLanguage => '语言';

  @override
  String get menuLabelSource => '源';

  @override
  String get menuLabelDestination => '目标';

  @override
  String get menuNotSet => '未设置';

  @override
  String get languageMenuTitle => '选择语言';

  @override
  String get languageOptionRussian => 'Русский';

  @override
  String get languageOptionChinese => '中文';

  @override
  String get languageOptionEnglish => 'English';

  @override
  String get languageOptionBack => '返回';

  @override
  String infoLanguageChanged(String name) => '语言已切换：$name';

  @override
  String get promptSourceFolder => '请输入包含 PDF 的源文件夹路径: ';

  @override
  String get promptDestinationFolder => '请输入保存结果的目标文件夹路径: ';

  @override
  String get folderPickerTitleSource => '选择包含 PDF 的文件夹';

  @override
  String get folderPickerTitleDestination => '选择保存结果的目标文件夹';

  @override
  String get infoFolderDialogOpening => '正在打开文件夹选择窗口...';

  @override
  String infoSourceSelected(String path) => '源文件夹：$path';

  @override
  String infoDestinationSelected(String path) => '目标文件夹：$path';

  @override
  String get errorSourceNotSet => '请先选择源文件夹（第 2 项）。';

  @override
  String get errorDestinationNotSet => '请先选择目标文件夹（第 3 项）。';

  @override
  String errorDestinationCreate(String path, Object error) =>
      '无法创建目标文件夹 $path：$error';

  @override
  String get pressEnterToContinue => '按 Enter 返回菜单...';

  @override
  String get menuGoodbye => '已退出。再见！';

  // --- Non-interactive CLI --------------------------------------------------

  @override
  String errorFolderNotFound(String path) => '错误：文件夹不存在：$path';

  @override
  String errorNoPdfFound(String folder) => '错误：文件夹中未找到 PDF 文件：$folder';

  @override
  String errorUnknownOption(String option) => '错误：未知参数：$option';

  @override
  String errorUnknownLanguage(String value) =>
      '错误：不支持的语言 "$value"。可用值：ru、zh、en。';

  @override
  String infoFoundFiles(int count) => '找到 PDF 文件数：$count';

  @override
  String infoMerging(int count) => '正在合并 $count 个文件...';

  @override
  String progressFile(int index, int total, String path) =>
      '[$index/$total] $path';

  @override
  String errorReadFile(String path, Object error) =>
      '读取文件出错 $path：$error';

  @override
  String get errorNoReadableFiles => '错误：未能读取任何 PDF 文件。';

  @override
  String errorMergeFailed(Object error) => '合并时出错：$error';

  @override
  String get infoDone => '完成。';

  @override
  String infoResultPath(String path) => '结果：$path';

  @override
  String infoResultSize(int bytes) => '大小：${formatSize(bytes)}';

  @override
  String warningReadFailures(int count) => '读取警告数：$count';

  @override
  String formatSize(int bytes) {
    const double kb = 1024;
    if (bytes < kb * kb) {
      return '${(bytes / kb).toStringAsFixed(1)} KB';
    }
    return '${(bytes / kb / kb).toStringAsFixed(1)} MB';
  }
}