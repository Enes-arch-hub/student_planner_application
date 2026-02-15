import 'package:flutter/material.dart';
import 'assignment_screen.dart';
import 'exam_screen.dart';
import 'timetable_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Student Planner Dashboard")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            ElevatedButton(
              child: const Text("Assignments"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const AssignmentScreen()),
                );
              },
            ),
            ElevatedButton(
              child: const Text("Exams"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ExamScreen()),
                );
              },
            ),
            ElevatedButton(
              child: const Text("Timetable"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const TimetableScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
