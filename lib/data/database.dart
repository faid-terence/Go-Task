import 'package:hive_flutter/hive_flutter.dart';

class TodoDatabase {
  List<Map<String, dynamic>> todoItems = [];

  final _mybox = Hive.box('todoBox');

  // run this method if this is the first time the app is opened
  void createInitialData() {
    todoItems = [
      {
        'taskName': 'UI Design',
        'isCompleted': false,
        'startTime': DateTime(2023, 1, 1, 9, 0),
        'endTime': DateTime(2023, 1, 1, 11, 0),
        'category': 'Personal',
      },
      {
        'taskName': 'Team Meeting',
        'isCompleted': false,
        'startTime': DateTime(2023, 1, 1, 13, 0),
        'endTime': DateTime(2023, 1, 1, 14, 30),
        'category': 'Work',
      },
      {
        'taskName': 'Family Dinner',
        'isCompleted': false,
        'startTime': DateTime(2023, 1, 1, 18, 0),
        'endTime': DateTime(2023, 1, 1, 20, 0),
        'category': 'Family',
      },
    ];
  }

  // load data from Database
  void loadData() {
    var loadedData = _mybox.get('todoItems');
    if (loadedData != null && loadedData is List) {
      todoItems =
          loadedData.map((item) => Map<String, dynamic>.from(item)).toList();
    } else {
      createInitialData();
    }
  }

  // update data in the Database
  void updateData() {
    _mybox.put('todoItems', todoItems);
  }
}
