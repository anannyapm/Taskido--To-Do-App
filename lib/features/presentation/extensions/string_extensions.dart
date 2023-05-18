extension TitleCase on String {
  String toTitleCase() {

    final List<String> splitStr = split(' ');
    for (int i = 0; i < splitStr.length; i++) {
      splitStr[i] =
          '${splitStr[i][0].toUpperCase()}${splitStr[i].substring(1)}';
    }
    final output = splitStr.join(' ');
    return output;
   
  }
}

extension ExtendedString on String {
  // The string without any whitespace.
  String removeAllWhitespace() {
    // Remove all white space.
    return replaceAll(RegExp(r"\s+"), "");
  }
}