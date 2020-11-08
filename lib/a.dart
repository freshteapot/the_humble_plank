void main() {
  final regexp = RegExp(".*\/challenge\/(.*)\.html");
  var text = """
goood

Join me in a plank challenge

https://learnalist.net/challenge/ecded.html doood
""";

  String input = "https://learnalist.net/challenge/abcd.html";
  input = text;
  String uuid = "";

  if (input.contains("https://")) {
    if (regexp.hasMatch(input)) {
      uuid = regexp.firstMatch(input).group(1);
    }
  }

  print(uuid);
  //var u = Uri.parse(input);

  //print(u.pathSegments.toString());
}
