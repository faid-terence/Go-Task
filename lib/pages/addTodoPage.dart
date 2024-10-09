import 'package:flutter/material.dart';
import 'package:todo/components/myButton.dart';
import 'package:todo/components/myDatePicker.dart';
import 'package:todo/components/myDropDown.dart';
import 'package:todo/components/myTextField.dart';

class Addtodopage extends StatelessWidget {
  Addtodopage({super.key});

  final TextEditingController taskNameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  DateTime? selectedDate;
  String? selectedCategory;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pop();
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(),
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
                items: const ['Personal', 'Work', 'Meeting', 'Study'],
                hint: "Select a category",
                onChanged: (String? newValue) {
                  print(newValue);
                },
              ),
              const SizedBox(height: 20),
              _buildSectionTitle("Due Date"),
              CustomDatePicker(
                selectedDate: selectedDate,
                onDateChanged: (DateTime newDate) {
                  print(newDate);
                },
                hint: "Select due date",
              ),
              const SizedBox(height: 50),
              Center(
                child: Mybutton(
                    text: "Create Task",
                    onPressed: () {
                      // Add your task creation logic here
                      Navigator.of(context)
                          .pop(); // Return to the previous screen after creating the task
                    }),
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
