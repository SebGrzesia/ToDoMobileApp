import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/constants/task.dart';
import 'package:flutter_application_1/constants/taskmanager.dart';

class TodoScreen extends StatefulWidget {
  final String userName;

  TodoScreen({required this.userName});

  @override
  _TodoScreenState createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  TaskManager taskManager = TaskManager(tasks: [
    Task(
      name: 'Task 1',
      description: 'Description 1',
      isCompleted: false,
      createdAt: DateTime.now(),
    ),
    Task(
      name: 'Task 2',
      description: 'Description 2',
      isCompleted: true,
      createdAt: DateTime.now(),
    ),
  ]);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorGray,
      appBar: AppBar(
        backgroundColor: colorGray,
        title: Text('Welcome ${widget.userName}'),
        automaticallyImplyLeading: false,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: taskManager.tasks.length,
                itemBuilder: (context, index) {
                  Task task = taskManager.tasks[index];
                  return TaskTile(
                    task: task,
                    onDelete: () {
                      setState(() {
                        taskManager.deleteTask(task);
                      });
                    },
                    onToggleCompleted: () {
                      setState(() {
                        taskManager.toggleCompleted(task);
                      });
                    },
                  );
                },
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddTaskScreen(
                          onTaskSaved: (Task task) {
                            setState(() {
                              taskManager.addTask(task);
                            });
                          },
                        ),
                      ),
                    );
                  },
                  child: Text('Add Task'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class TaskTile extends StatelessWidget {
  final Task task;
  final VoidCallback onDelete;
  final VoidCallback onToggleCompleted;

  TaskTile({
    required this.task,
    required this.onDelete,
    required this.onToggleCompleted,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(task.name),
      subtitle: Text(task.description),
      trailing: Checkbox(
        value: task.isCompleted,
        onChanged: (value) {
          onToggleCompleted();
        },
      ),
      onLongPress: onDelete,
    );
  }
}

class AddTaskScreen extends StatefulWidget {
  final Function(Task) onTaskSaved;

  AddTaskScreen({required this.onTaskSaved});

  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  TextEditingController _taskNameController = TextEditingController();
  TextEditingController _taskDescriptionController = TextEditingController();
  bool _isButtonEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorGray,
        title: Text('Add Task'),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _taskNameController,
              onChanged: (value) {
                setState(() {
                  _isButtonEnabled = value.isNotEmpty;
                });
              },
              decoration: InputDecoration(labelText: 'Task Name'),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _taskDescriptionController,
              decoration: InputDecoration(labelText: 'Task Description'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isButtonEnabled ? _saveTask : null,
              child: Text('Save Task'),
            ),
          ],
        ),
      ),
    );
  }

  void _saveTask() {
    String taskName = _taskNameController.text.trim();
    String taskDescription = _taskDescriptionController.text.trim();

    widget.onTaskSaved(
      Task(
        name: taskName,
        description: taskDescription,
        isCompleted: false,
        createdAt: DateTime.now(),
      ),
    );

    Navigator.pop(context);
  }
}
