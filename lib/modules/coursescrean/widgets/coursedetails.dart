import 'package:flutter/material.dart';

import 'package:graduation_progect/modules/coursescrean/widgets/questionScreen.dart';
import 'content.dart';
import 'course.dart';
import 'courseprogress.dart';
import 'exercisepage.dart';
import 'glosarytab.dart';
import 'lessontile.dart';
class CourseDetailsScreen extends StatelessWidget {
  final Course course;
  const CourseDetailsScreen({ required this.course});
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.amber,
            title: Text(course.title),
            bottom: const TabBar(
              indicatorColor: Colors.black,
              unselectedLabelColor: Colors.black,
              tabs: [
                // Tab(text: "Video",),
                Tab(text: "Glossary"),
                Tab(text:"content"),
                Tab(text:"exercise"),
                Tab(text: "Exercise",)
              ],
            ),
          ),
          body:  TabBarView(
            //     children: [
            //       ListView.builder(itemCount:course.lessons.length,itemBuilder:(context,index){
            //         return LessonTile(lesson:course.lessons[index]);
            //
            // }
            //       ),
            //
            //       // Center(child: Text("Lessons will be here")),
            //       Center(child: GlossaryTab(glossary: course.glossary,),
            //
              children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: CourseProgress(lessons: course.lessons),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: course.lessons.length,
                        itemBuilder: (context, index) {
                          return LessonTile(
                            lesson: course.lessons[index],
                          );
                        },
                      ),
                    ),
                  ],
                ),
                GlossaryTab(glossary: course.glossary),
               // PdfScreen(),
                ContentPage(),
                QuestionTab(),
                Exercise(),
              ]
          ),
        )
    );
  }}