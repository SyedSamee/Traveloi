extension StringExtention on String {
  String separateFirstLocation() {
    return split(",").first.substring(1, split(",").first.length);
  }

  String get firstLetterCapital {
    return substring(0, 1).toUpperCase() + substring(1, length);
  }

  String get listMarksRemover {
    return substring(1, length - 1);
  }
}
