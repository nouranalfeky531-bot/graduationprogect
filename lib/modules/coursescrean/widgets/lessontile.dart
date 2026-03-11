import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';


import 'lesson.dart';
import 'lessonScreen.dart';

class LessonTile extends StatefulWidget {
  final Lesson lesson;

  const LessonTile({ required this.lesson});

  @override
  State<LessonTile> createState() => _LessonTileState();
}

class _LessonTileState extends State<LessonTile> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        widget.lesson.isCompleted ? Icons.check_circle : Icons.play_circle,
        color: widget.lesson.isCompleted ? Colors.green : Colors.blue,
      ),
      title: Text(widget.lesson.title),
      subtitle: Text(widget.lesson.duration),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: () {



        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => LessonScreen(lesson: widget.lesson),
          ),
        );
      },

    );
  }
}