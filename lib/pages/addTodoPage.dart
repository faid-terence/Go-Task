import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo/components/myButton.dart';
import 'package:todo/components/myDatePicker.dart';
import 'package:todo/components/myDropDown.dart';
import 'package:todo/components/myTextField.dart';
import 'package:todo/data/database.dart';

class Addtodopage extends StatefulWidget {
  const Addtodopage({Key? key}) : super(key: key);

  @override
  _AddtodopageState createState() => _AddtodopageState();
}

class _AddtodopageState extends State<Addtodopage> {
  final TextEditingController taskNameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  DateTime? selectedDate;
  String? selectedCategory;

  final _mybox = Hive.box('todoBox');
  late TodoDatabase todoDatabase;

  @override
  void initState() {
    super.initState();
    todoDatabase = TodoDatabase();
    todoDatabase.loadData();
  }

  void createTask() {
    if (taskNameController.text.isEmpty ||
        selectedCategory == null ||
        selectedDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all required fields')),
      );
      return;
    }

    final newTask = {
      'taskName': taskNameController.text,
      'description': descriptionController.text,
      'category': selectedCategory,
      'startTime': selectedDate,
      'endTime': selectedDate?.add(const Duration(hours: 1)),
      'isCompleted': false,
    };

    setState(() {
      todoDatabase.todoItems.add(newTask);
      todoDatabase.updateData();
    });

    Navigator.of(context).pop(true); // Return true to indicate a task was added
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context)
            .pop(false); // Return false to indicate no task was added
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(false),
          ),
          title: const Text("Create New Task"),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              _buildSectionTitle("Task Name"),
              Mytextfield(
                controller: taskNameController,
                hintText: "Task Name",
                icon: null,
                obscureText: false,
              ),
              const SizedBox(height: 20),
              _buildSectionTitle("Task Description"),
              Mytextfield(
                controller: descriptionController,
                hintText: "Enter description",
                obscureText: false,
                height: 100,
              ),
              const SizedBox(height: 20),
              _buildSectionTitle("Category"),
              CustomDropdown(
                items: const ['Personal', 'Work', 'Family'],
                hint: "Select a category",
                onChanged: (String? newValue) {
                  setState(() {
                    selectedCategory = newValue;
                  });
                },
              ),
              const SizedBox(height: 20),
              _buildSectionTitle("Due Date"),
              CustomDatePicker(
                selectedDate: selectedDate,
                onDateChanged: (DateTime newDate) {
                  setState(() {
                    selectedDate = newDate;
                  });
                },
                hint: "Select due date",
              ),
              const SizedBox(height: 50),
              Center(
                child: Mybutton(
                  text: "Create Task",
                  onPressed: createTask,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
      child: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }
}
