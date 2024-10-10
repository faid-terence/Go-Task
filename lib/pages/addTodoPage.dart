import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo/components/myButton.dart';
import 'package:todo/components/myDatePicker.dart';
import 'package:todo/components/myDropDown.dart';
import 'package:todo/components/myTextField.dart';
import 'package:todo/data/database.dart';
import 'package:easy_localization/easy_localization.dart';

class AddTodoPage extends StatefulWidget {
  const AddTodoPage({Key? key}) : super(key: key);

  @override
  _AddTodoPageState createState() => _AddTodoPageState();
}

class _AddTodoPageState extends State<AddTodoPage> {
  final TextEditingController taskNameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  DateTime? selectedDate;
  String? selectedCategory;
  String? selectedPriority;

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
        selectedDate == null ||
        selectedPriority == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('please_fill_all_required_fields'.tr())),
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
      'priority': selectedPriority,
      'dateAdded': DateTime.now(),
    };

    todoDatabase.addTask(newTask);
    Navigator.of(context).pop(true);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pop(false);
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(false),
          ),
          title: Text("create_new_task".tr()),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              _buildSectionTitle("task_name".tr()),
              Mytextfield(
                controller: taskNameController,
                hintText: "task_name".tr(),
                icon: null,
                obscureText: false,
              ),
              const SizedBox(height: 20),
              _buildSectionTitle("task_description".tr()),
              Mytextfield(
                controller: descriptionController,
                hintText: "task_description".tr(),
                obscureText: false,
                height: 100,
              ),
              const SizedBox(height: 20),
              _buildSectionTitle("category".tr()),
              CustomDropdown(
                items: ["work".tr(), "personal".tr(), "family".tr()],
                hint: "select_category".tr(),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedCategory = newValue;
                  });
                },
              ),
              const SizedBox(height: 20),
              _buildSectionTitle("priority".tr()),
              CustomDropdown(
                items: ["low".tr(), "medium".tr(), "high".tr()],
                hint: "select_priority".tr(),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedPriority = newValue;
                  });
                },
              ),
              const SizedBox(height: 20),
              _buildSectionTitle("due_date".tr()),
              CustomDatePicker(
                selectedDate: selectedDate,
                onDateChanged: (DateTime newDate) {
                  setState(() {
                    selectedDate = newDate;
                  });
                },
                hint: "select_due_date".tr(),
              ),
              const SizedBox(height: 50),
              Center(
                child: Mybutton(
                  text: "create_task".tr(),
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
