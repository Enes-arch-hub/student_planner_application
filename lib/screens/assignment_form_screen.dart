import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../models/assignment.dart';

class AssignmentFormScreen extends StatefulWidget {
  const AssignmentFormScreen({super.key});

  @override
  State<AssignmentFormScreen> createState() => _AssignmentFormScreenState();
}

class _AssignmentFormScreenState extends State<AssignmentFormScreen> {
  final titleController = TextEditingController();
  final courseController = TextEditingController();

  DateTime? selectedDate;
  String priority = "Medium";

  void saveAssignment() {
    if (titleController.text.isEmpty ||
        courseController.text.isEmpty ||
        selectedDate == null) {
      return;
    }

    final box = Hive.box<Assignment>('assignments');

    final assignment = Assignment(
      title: titleController.text,
      course: courseController.text,
      dueDate: selectedDate!,
      priority: priority,
    );

    box.add(assignment);
    Navigator.pop(context);
  }

  Future<void> pickDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (date != null) {
      setState(() => selectedDate = date);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Assignment")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: "Title"),
            ),
            TextField(
              controller: courseController,
              decoration: const InputDecoration(labelText: "Course"),
            ),

            const SizedBox(height: 15),

            ListTile(
              title: Text(
                selectedDate == null
                    ? "Pick Due Date"
                    : "Due: ${selectedDate!.toLocal()}".split(' ')[0],
              ),
              trailing: const Icon(Icons.calendar_today),
              onTap: pickDate,
            ),

            const SizedBox(height: 15),

            DropdownButtonFormField<String>(
              value: priority,
              items: ["Low", "Medium", "High"]
                  .map(
                    (e) => DropdownMenuItem(
                      value: e,
                      child: Text(e),
                    ),
                  )
                  .toList(),
              onChanged: (value) => setState(() => priority = value!),
              decoration: const InputDecoration(labelText: "Priority"),
            ),

            const SizedBox(height: 25),

            ElevatedButton(
              onPressed: saveAssignment,
              child: const Text("Save"),
            ),
          ],
        ),
      ),
    );
  }
}
