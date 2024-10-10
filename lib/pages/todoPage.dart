import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo/components/todoList.dart';
import 'package:todo/data/database.dart';
import 'package:todo/pages/addTodoPage.dart';
import 'package:easy_localization/easy_localization.dart';

class Todopage extends StatefulWidget {
  const Todopage({super.key});

  @override
  _TodopageState createState() => _TodopageState();
}

class _TodopageState extends State<Todopage> {
  final _mybox = Hive.box('todoBox');
  TodoDatabase todoDatabase = TodoDatabase();

  @override
  void initState() {
    super.initState();
    if (_mybox.get("todoItems") == null) {
      todoDatabase.createInitialData();
    } else {
      todoDatabase.loadData();
    }
  }

  void _addNewTask() async {
    final bool? taskAdded = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const Addtodopage()),
    );
    if (taskAdded == true) {
      setState(() {
        todoDatabase.loadData();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.only(left: 25),
            child: IconButton(
              icon: const Icon(
                Icons.menu_book_rounded,
                color: Colors.blue,
              ),
              onPressed: () {
                // Implement menu functionality if needed
              },
            ),
          ),
          title: Center(
            child: Text(
              context.tr("go_task"),
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          bottom: TabBar(
            tabs: [
              Tab(text: context.tr('all')),
              Tab(text: context.tr('work')),
              Tab(text: context.tr('personal')),
              Tab(text: context.tr('family')),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildTodoList('All'),
            _buildTodoList('Work'),
            _buildTodoList('Personal'),
            _buildTodoList('Family'),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _addNewTask,
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  Widget _buildTodoList(String category) {
    List<Map<String, dynamic>> items;
    if (category == 'All') {
      items = List.from(todoDatabase.todoItems);
    } else {
      items = todoDatabase.todoItems
          .where((item) => item['category'] == category)
          .toList();
    }

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 25),
      child: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return Todolist(
            taskName: item['taskName'] ?? context.tr('untitled_task'),
            description: item['description'] ?? '',
            isCompleted: item['isCompleted'] ?? false,
            startTime: item['startTime'] as DateTime?,
            endTime: item['endTime'] as DateTime?,
            onCheck: (bool? value) {
              setState(() {
                item['isCompleted'] = value ?? false;
                todoDatabase.updateData();
              });
            },
            onDelete: () {
              setState(() {
                todoDatabase.todoItems.remove(item);
                todoDatabase.updateData();
              });
            },
            onTap: () {
              // TODO: Implement edit todo item functionality
            },
          );
        },
      ),
    );
  }
}
