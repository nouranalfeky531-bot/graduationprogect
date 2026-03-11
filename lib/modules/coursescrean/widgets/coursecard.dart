import 'package:flutter/material.dart';

import 'course.dart';
import 'coursedetails.dart';


class CourseCard extends StatelessWidget {
  final Course course;

  const CourseCard({ required this.course});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(12),
      child: ListTile(
        leading: const Icon(Icons.book),
        title: Text(course.title),
        subtitle: Text(course.description),
        trailing: const Icon(Icons.arrow_forward),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => CourseDetailsScreen(course: course),
            ),
          );
        },
      ),
    );
  }
}