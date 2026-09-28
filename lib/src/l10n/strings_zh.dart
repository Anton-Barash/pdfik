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
      '将指定文件夹（含子文件夹）中的所有 PDF 文件合并为一个文件\n'
      'out/merged_all.pdf。\n'
      '\n'
      '选项:\n'
      '  -l, --lang <代码>   消息语言: ru、zh 或 en\n'
      '  -h, --help          显示此帮助\n'
      '\n'
      '如果未指定文件夹，将以交互方式询问路径。\n'
      '环境变量 PDFIK_LANG 设置默认语言。';

  @override
  String get promptFolderPath => '请输入包含 PDF 的文件夹路径: ';

  @override
  String get errorPathNotProvided => '未提供路径，程序结束。';

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