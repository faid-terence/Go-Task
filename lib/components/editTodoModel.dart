import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:todo/components/myButton.dart';
import 'package:todo/components/myDatePicker.dart';
import 'package:todo/components/myDropDown.dart';
import 'package:todo/components/myTextField.dart';

class EditTodoModal extends StatefulWidget {
  final Map<String, dynamic> task;
  final Function(Map<String, dynamic>) onSave;

  const EditTodoModal({Key? key, required this.task, required this.onSave})
      : super(key: key);

  @override
  _EditTodoModalState createState() => _EditTodoModalState();
}

class _EditTodoModalState extends State<EditTodoModal> {
  late TextEditingController taskNameController;
  late TextEditingController descriptionController;
  late DateTime? selectedDate;
  late String? selectedCategory;

  @override
  void initState() {
    super.initState();
    taskNameController = TextEditingController(text: widget.task['taskName']);
    descriptionController =
        TextEditingController(text: widget.task['description']);
    selectedDate = widget.task['startTime'];
    selectedCategory = widget.task['category'];
  }

  void saveTask() {
    if (taskNameController.text.isEmpty ||
        selectedCategory == null ||
        selectedDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('please_fill_all_required_fields'.tr())),
      );
      return;
    }

    final updatedTask = {
      'taskName': taskNameController.text,
      'description': descriptionController.text,
      'category': selectedCategory,
      'startTime': selectedDate,
      'endTime': selectedDate?.add(const Duration(hours: 1)),
      'isCompleted': widget.task['isCompleted'],
    };

    widget.onSave(updatedTask);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("edit_task".tr(),
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
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
              items: [
                "work".tr(),
                "personal".tr(),
                "family".tr(),
              ],
              hint: "Select_category".tr(),
              value: selectedCategory,
              onChanged: (String? newValue) {
                setState(() {
                  selectedCategory = newValue;
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
              hint: "Select_due_date".tr(),
            ),
            const SizedBox(height: 30),
            Center(
              child: Mybutton(
                text: "save_changes".tr(),
                onPressed: saveTask,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }
}
