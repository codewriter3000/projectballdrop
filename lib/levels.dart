class Levels {
  int id;
  String text;

  Levels(this.id, this.text);

  Levels.fromJson(Map<String, dynamic> json) {
    id = json['id'];
  }
}