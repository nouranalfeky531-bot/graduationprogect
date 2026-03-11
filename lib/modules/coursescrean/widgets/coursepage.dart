import 'package:flutter/material.dart';

import 'lesson.dart';
import 'lessonpage.dart';

class CoursePage extends StatelessWidget {
  CoursePage();
  final List<Lesson> lessons = [
    // Lesson(
    //
    //   type: "video",
    //   path: "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4",
    // ),
    // Lesson(
    //
    //   // type: "pdf",
    //   // path: "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4",
    // ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Lessons")),
      body: ListView.builder(
        itemCount: lessons.length,
        itemBuilder: (context, index) {
          final lesson = lessons[index];
          return ListTile(
            title: Text(lesson.title),
            trailing: const Icon(Icons.arrow_forward),
            onTap: () {
              // Navigator.push(
              //   context,
              // //   Mater LessonPage(
              // //     //   title: lesson.title,
              // //     //   type: lesson.type,
              // //     //   // url: lesson.path,
              // //     // ),
              // //   ),ialPageRoute(
              // // // builder: (_) =>
              // );
            },
          );
        },
      ),
    );
  }
}