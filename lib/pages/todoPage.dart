import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo/components/editTodoModel.dart';
import 'package:todo/components/todoList.dart';
import 'package:todo/data/database.dart';
import 'package:todo/pages/addTodoPage.dart';
import 'package:easy_localization/easy_localization.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({Key? key}) : super(key: key);

  @override
  _TodoPageState createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  final _mybox = Hive.box('todoBox');
  late TodoDatabase todoDatabase;
  String currentSortOption = 'dateAdded';

  @override
  void initState() {
    super.initState();
    todoDatabase = TodoDatabase();
    if (_mybox.get("todoItems") == null) {
      todoDatabase.createInitialData();
    } else {
      todoDatabase.loadData();
    }
  }

  void _addNewTask() async {
    final bool? taskAdded = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddTodoPage()),
    );
    if (taskAdded == true) {
      setState(() {
        todoDatabase.loadData();
      });
    }
  }

  void _editTask(Map<String, dynamic> task, int index) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: EditTodoModal(
          task: task,
          onSave: (updatedTask) {
            setState(() {
              todoDatabase.updateTask(index, updatedTask);
            });
          },
        ),
      ),
    );
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
              "go_task".tr(),
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          actions: [
            PopupMenuButton<String>(
              onSelected: (String result) {
                setState(() {
                  currentSortOption = result;
                });
              },
              itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                PopupMenuItem<String>(
                  value: 'priority',
                  child: Text('sort_by_priority'.tr()),
                ),
                PopupMenuItem<String>(
                  value: 'dateAdded',
                  child: Text('sort_by_date_added'.tr()),
                ),
                PopupMenuItem<String>(
                  value: 'deadline',
                  child: Text('sort_by_deadline'.tr()),
                ),
              ],
            ),
          ],
          bottom: TabBar(
            tabs: [
              Tab(text: 'all'.tr()),
              Tab(text: 'work'.tr()),
              Tab(text: 'personal'.tr()),
              Tab(text: 'family'.tr()),
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
    List<Map<String, dynamic>> items =
        todoDatabase.getSortedTasks(currentSortOption);
    if (category != 'All') {
      items = items.where((item) => item['category'] == category).toList();
    }

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 25),
      child: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return Todolist(
            taskName: item['taskName'] ?? 'untitled_task'.tr(),
            description: item['description'] ?? '',
            isCompleted: item['isCompleted'] ?? false,
            startTime: item['startTime'] as DateTime?,
            endTime: item['endTime'] as DateTime?,
            priority: item['priority'] ?? 'medium',
            onCheck: (bool? value) {
              setState(() {
                item['isCompleted'] = value ?? false;
                todoDatabase.updateData();
              });
            },
            onDelete: () {
              setState(() {
                todoDatabase.deleteTask(todoDatabase.todoItems.indexOf(item));
              });
            },
            onEdit: () {
              _editTask(item, todoDatabase.todoItems.indexOf(item));
            },
            onTap: () {
              // This is now handled internally in the Todolist widget
            },
          );
        },
      ),
    );
  }
}
