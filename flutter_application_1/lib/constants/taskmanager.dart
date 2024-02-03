import 'package:flutter_application_1/constants/task.dart';

class TaskManager {
  List<Task> tasks;

  TaskManager({required this.tasks});

  void markAsCompleted(Task task) {
    task.isCompleted = true;
  }

  void deleteTask(Task task) {
    tasks.remove(task);
  }

  void toggleCompleted(Task task) {
    task.isCompleted = !task.isCompleted;
  }

  void addTask(Task task) {
    tasks.add(task);
  }
}
