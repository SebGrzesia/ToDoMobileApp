class Task {
  String name;
  String description;
  bool isCompleted;
  DateTime createdAt;

  Task({
    required this.name,
    required this.description,
    required this.isCompleted,
    required this.createdAt,
  });

  Task.withDefaultDate({
    required this.name,
    required this.description,
    required this.isCompleted,
  }) : createdAt = DateTime.now();
}
