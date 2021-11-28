class ToDoList {
  var id;
  final String title;

  ToDoList({
    this.id,
    required this.title,
  });

  Map<String, dynamic> toMap() {
    return {'id': id, 'title': title};
  }
}
