import 'package:flutter/material.dart';
import 'package:todo/components/todoList.dart';

class Todopage extends StatefulWidget {
  const Todopage({Key? key}) : super(key: key);

  @override
  _TodopageState createState() => _TodopageState();
}

class _TodopageState extends State<Todopage> {
  List<Map<String, dynamic>> todoItems = [
    {
      'taskName': 'UI Design',
      'isCompleted': false,
      'startTime': DateTime(2023, 1, 1, 9, 0),
      'endTime': DateTime(2023, 1, 1, 11, 0),
    },
    {
      'taskName': 'Team Meeting',
      'isCompleted': false,
      'startTime': DateTime(2023, 1, 1, 13, 0),
      'endTime': DateTime(2023, 1, 1, 14, 30),
    },
    {
      'taskName': 'Project Planning',
      'isCompleted': true,
      'startTime': DateTime(2023, 1, 1, 15, 0),
      'endTime': DateTime(2023, 1, 1, 16, 0),
    },
  ];
  var selectedValue = 0;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(
              Icons.menu_book_rounded,
              color: Colors.blue,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: const Text(
            "Go Task",
            style: TextStyle(),
          ),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'All'),
              Tab(text: 'Completed'),
              Tab(text: 'In Progress'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildTodoList(todoItems),
            _buildTodoList(
                todoItems.where((item) => item['isCompleted']).toList()),
            _buildTodoList(
                todoItems.where((item) => !item['isCompleted']).toList()),
          ],
        ),
      ),
    );
  }

  Widget _buildTodoList(List<Map<String, dynamic>> items) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return Todolist(
          taskName: item['taskName'],
          isCompleted: item['isCompleted'],
          startTime: item['startTime'],
          endTime: item['endTime'],
          onCheck: (bool? value) {
            setState(() {
              item['isCompleted'] = value ?? false;
            });
          },
          onTap: () {
            // TODO: Implement edit todo item functionality
          },
        );
      },
    );
  }
}
