extension StringExtention on String {
  String separateFirstLocation() {
    return this.split(",").first.substring(1, this.split(",").first.length);
  }

  String get firstLetterCapital {
    return "${this.substring(0, 1).toUpperCase() + this.substring(1, this.length)}";
  }

  String get listMarksRemover {
    return "${this.substring(1, this.length - 1)}";
  }
}
