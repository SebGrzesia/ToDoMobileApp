import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/constants/task.dart';
import 'package:flutter_application_1/constants/taskmanager.dart';

class AddTaskScreen extends StatefulWidget {
  final Function(Task) onTaskSaved;
  final TaskManager taskManager;

  AddTaskScreen({required this.onTaskSaved, required this.taskManager});

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
    DateTime currentDate = DateTime.now();

    Task newTask = Task(
      name: taskName,
      description: taskDescription,
      isCompleted: false,
      createdAt: currentDate,
    );

    widget.taskManager.addTask(newTask);
    widget.onTaskSaved(newTask);

    Navigator.pop(context);
  }
}
