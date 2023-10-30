class Todo {
  final String id;
  final String title;
  final String userId;
  final DateTime time;
  final bool isDone;

  Todo( {
    required this.id,
    required this.title,
    required this.userId,
    required this.time,
    this.isDone = false,
  });
}
