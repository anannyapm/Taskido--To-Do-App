extension TitleCase on String {
  String toTitleCase() {
    return toLowerCase().replaceAllMapped(RegExp(r'[A-Z]{2,}(?=[A-Z][a-z]+[0-9]*|\b)|[A-Z]?[a-z]+[0-9]*|[A-Z]|[0-9]+'),
        (Match match) {
      
      return "${match[0]![0].toUpperCase()}${match[0]!.substring(1).toLowerCase()}";
    }).replaceAll(RegExp(r'(_|-)+'), ' ');
  }
}