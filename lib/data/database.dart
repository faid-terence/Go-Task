import 'package:hive_flutter/hive_flutter.dart';

class TodoDatabase {
  List<Map<String, dynamic>> todoItems = [];
  final _mybox = Hive.box('todoBox');

  void createInitialData() {
    todoItems = [
      {
        'taskName': 'UI Design',
        'isCompleted': false,
        'description': 'Design the UI for the new app',
        'startTime': DateTime(2023, 1, 1, 9, 0),
        'endTime': DateTime(2023, 1, 1, 11, 0),
        'category': 'Personal',
        'priority': 'Medium',
        'dateAdded': DateTime(2023, 1, 1),
      },
      {
        'taskName': 'Team Meeting',
        'isCompleted': false,
        'description': 'Meeting with the team to discuss the new project',
        'startTime': DateTime(2023, 1, 1, 13, 0),
        'endTime': DateTime(2023, 1, 1, 14, 30),
        'category': 'Work',
        'priority': 'High',
        'dateAdded': DateTime(2023, 1, 1),
      },
      {
        'taskName': 'Family Dinner',
        'isCompleted': false,
        'description': 'Dinner with the family at the new restaurant',
        'startTime': DateTime(2023, 1, 1, 18, 0),
        'endTime': DateTime(2023, 1, 1, 20, 0),
        'category': 'Family',
        'priority': 'Low',
        'dateAdded': DateTime(2023, 1, 1),
      },
    ];
  }

  void loadData() {
    var loadedData = _mybox.get('todoItems');
    if (loadedData != null && loadedData is List) {
      todoItems =
          loadedData.map((item) => Map<String, dynamic>.from(item)).toList();
    } else {
      createInitialData();
    }
  }

  void updateData() {
    _mybox.put('todoItems', todoItems);
  }

  void addTask(Map<String, dynamic> task) {
    if (task['dateAdded'] == null) {
      task['dateAdded'] = DateTime.now();
    }
    todoItems.add(task);
    updateData();
  }

  void updateTask(int index, Map<String, dynamic> updatedTask) {
    if (index >= 0 && index < todoItems.length) {
      todoItems[index] = updatedTask;
      updateData();
    }
  }

  void deleteTask(int index) {
    if (index >= 0 && index < todoItems.length) {
      todoItems.removeAt(index);
      updateData();
    }
  }

  List<Map<String, dynamic>> getSortedTasks(String sortBy) {
    List<Map<String, dynamic>> sortedList = List.from(todoItems);
    switch (sortBy) {
      case 'priority':
        sortedList.sort((a, b) {
          final priorityOrder = {'High': 0, 'Medium': 1, 'Low': 2};
          final aPriority = priorityOrder[a['priority']] ?? 3;
          final bPriority = priorityOrder[b['priority']] ?? 3;
          return aPriority.compareTo(bPriority);
        });
        break;
      case 'dateAdded':
        sortedList.sort((a, b) {
          final aDate = a['dateAdded'] as DateTime?;
          final bDate = b['dateAdded'] as DateTime?;
          if (aDate == null && bDate == null) return 0;
          if (aDate == null) return 1;
          if (bDate == null) return -1;
          return bDate.compareTo(aDate);
        });
        break;
      case 'deadline':
        sortedList.sort((a, b) {
          final aDeadline = a['endTime'] as DateTime?;
          final bDeadline = b['endTime'] as DateTime?;
          if (aDeadline == null && bDeadline == null) return 0;
          if (aDeadline == null) return 1;
          if (bDeadline == null) return -1;
          return aDeadline.compareTo(bDeadline);
        });
        break;
    }
    return sortedList;
  }
}
