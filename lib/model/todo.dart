class ToDo {
  String id;
  String toDoText;
  bool isDone;

  ToDo({
    required this.id,
    required this.toDoText,
    this.isDone = false,
  });

  static List<ToDo> todoList() {
    return [
      ToDo(id: '01', toDoText: 'Morning Exercise', isDone: true),
      ToDo(id: '02', toDoText: 'Homework'),
    ];
  }
}
