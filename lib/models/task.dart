class Task {
  dynamic id;
  final int listId;
  final String title;
  final String description;
  int isDone;

  Task({
    this.id,
    required this.listId,
    required this.title,
    this.description = '',
    this.isDone = 0,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'listId': listId,
      'title': title,
      'description': description,
      'isDone': isDone
    };
  }
}
