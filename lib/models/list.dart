class ToDoList {
  dynamic id;
  String title;

  ToDoList({
    this.id,
    required this.title,
  });

  Map<String, dynamic> toMap() {
    return {'id': id, 'title': title};
  }

  @override
  String toString() => title;
}
