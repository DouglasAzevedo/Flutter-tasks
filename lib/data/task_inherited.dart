import 'package:first_app/components/task.dart';
import 'package:flutter/material.dart';

class TaskInherited extends InheritedWidget {
  TaskInherited({super.key, required super.child});

  final List<Task> taskList = [];

  void newTask(String name, String photo, int difficulty) {
    taskList
        .add(Task(description: name, urlImage: photo, difficulty: difficulty));
  }

  void deleteTask(int index) {
    taskList.removeAt(index);
  }

  static TaskInherited? of(BuildContext context) {
    final TaskInherited? result =
        context.dependOnInheritedWidgetOfExactType<TaskInherited>();
    assert(result != null, 'No TaskInherited found in context');
    return result;
  }

  @override
  bool updateShouldNotify(TaskInherited oldWidget) {
    return oldWidget.taskList.length != taskList.length;
  }
}
