import 'glossary.dart';
import 'lesson.dart';

class Course {
  final String title;
  final String description;
  final String image;
  final List<Lesson>lessons;
  final List<Glossary>glossary;
  Course({
    required this.title,
    required this.description,
    required this.image,
    required this.lessons,
    required this.glossary,
  });
}