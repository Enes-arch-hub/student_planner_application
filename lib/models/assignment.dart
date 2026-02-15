import 'package:hive/hive.dart';

part 'assignment.g.dart';

@HiveType(typeId: 0)
class Assignment extends HiveObject {
  @HiveField(0)
  String title;

  @HiveField(1)
  String course;

  @HiveField(2)
  DateTime dueDate;

  @HiveField(3)
  String priority;

  Assignment({
    required this.title,
    required this.course,
    required this.dueDate,
    required this.priority,
  });
}

