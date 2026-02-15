import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/assignment.dart';
import 'assignment_form_screen.dart';

class AssignmentScreen extends StatelessWidget {
  const AssignmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final box = Hive.box<Assignment>('assignments');

    return Scaffold(
      appBar: AppBar(title: const Text("Assignments")),
      body: ValueListenableBuilder(
        valueListenable: box.listenable(),
        builder: (context, Box<Assignment> box, _) {
          if (box.isEmpty) {
            return const Center(child: Text("No assignments added"));
          }

          return ListView.builder(
            itemCount: box.length,
            itemBuilder: (context, index) {
              final assignment = box.getAt(index)!;

              return Card(
                margin: const EdgeInsets.all(8),
                child: ListTile(
                  title: Text(assignment.title),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Course: ${assignment.course}"),
                      Text(
                        "Due: ${assignment.dueDate.toLocal()}".split(' ')[0],
                      ),
                      Text("Priority: ${assignment.priority}"),
                    ],
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () => box.deleteAt(index),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const AssignmentFormScreen(),
            ),
          );
        },
      ),
    );
  }
}

