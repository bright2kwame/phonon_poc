class Utilities {
  //MARK: make the respository text plural
  static String pluralise(double score) {
    int valueToInt = score.toInt();
    if (score == 1.0) {
      return "$valueToInt repository";
    }
    return "$valueToInt repositories";
  }
}
