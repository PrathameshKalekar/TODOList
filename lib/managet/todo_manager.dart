class TODOManager {
  String id;
  String text;
  bool isDone;
  TODOManager({required this.id, required this.text, this.isDone = false});

  static List<TODOManager> TODOList() {
    return [];
  }
}
