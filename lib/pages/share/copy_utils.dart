class CopySentence {
  late List<String> arr = [];
  late String title = '';
  late Map<int, bool> copyIndexes = {};

  // 拆分句子
  CopySentence(String text) {
    List<String> arr =
        text.split(RegExp(r'\d+\s+')).map((s) => s.trim()).toList();
    if (arr.isEmpty) {
      return;
    }
    if (arr.length == 1) {
      return;
    }
    List<String> t = arr[0].split('. ');
    arr[0] = t[1];
    Map<int, bool> copyIndex = {};
    arr.asMap().forEach((i, s) {
      copyIndex[i] = false;
    });
    this.arr = arr;
    title = t[0];
    copyIndexes = copyIndex;
  }

  // 复制句子
  String copySentence() {
    List<String> copyArr = arr;
    String copyTitle = title;
    Map<int, bool> copyIndex = copyIndexes;
    String str = "";
    copyArr.asMap().forEach((i, s) {
      if (i == 0 && copyIndex[i]!) {
        str += ":1 $s";
      }
      if (i != 0 && copyIndex[i]!) {
        if (str == "") {
          str += ":${i + 1} $s";
        } else {
          if (copyIndex[i - 1]!) {
            str += "${i + 1} $s";
          } else {
            str += "...${i + 1} $s";
          }
        }
      }
    });
    str = (copyTitle + str).trim();
    return str;
  }
}

bool canCopySentence(String text) {
  return RegExp(r'\d+\s+').hasMatch(text);
}
