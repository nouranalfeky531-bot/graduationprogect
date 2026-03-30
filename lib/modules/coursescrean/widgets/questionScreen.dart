
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// ===============================
/// Model: Question
/// ===============================
/// الاختيارات
//import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// ===============================
/// Model: Question
/// ===============================
class Question {
  final String title;
  final String questionText;
  final List<Option> options;

  Question({
    required this.title,
    required this.questionText,
    required this.options,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    final ioParameters = json['ioParameters'];
    final answers = ioParameters['Answers  2'] as List;

    return Question(
      title: json['title'] ?? '',
      questionText: ioParameters['_Question_'] ?? '',
      options: answers.map((e) => Option.fromJson(e)).toList(),
    );
  }
}

/// ===============================
/// Model: Option
/// ===============================
class Option {
  final String text;
  final bool isCorrect;

  Option({
    required this.text,
    required this.isCorrect,
  });

  factory Option.fromJson(Map<String, dynamic> json) {
    return Option(
      text: json['_OptionText_'] ?? '',
      isCorrect: json['_Correct_'] ?? false,
    );
  }
}

/// ===============================
/// TAB Widget
/// ===============================
class QuestionTab extends StatefulWidget {
  const QuestionTab();

  @override
  State<QuestionTab> createState() => _QuestionTabState();
}

class _QuestionTabState extends State<QuestionTab> {
  Question? question;
  int? selectedIndex;
  bool answered = false;

  @override
  void initState() {
    super.initState();
    loadQuestion();
  }

  Future<void> loadQuestion() async {
    final String jsonString =
    await rootBundle.loadString('assets/files/QuestionSample.json');

    final Map<String, dynamic> jsonData = json.decode(jsonString);

    setState(() {
      question = Question.fromJson(jsonData);
    });
  }

  void checkAnswer() {
    if (selectedIndex == null) return;

    setState(() {
      answered = true;
    });

    bool isCorrect = question!.options[selectedIndex!].isCorrect;

    showDialog(
      context: context,
      builder: (_) =>
          AlertDialog(
            title: Text(isCorrect ? "Correct ✅" : "Wrong ❌"),
            content: Text(
              isCorrect
                  ? "إجابتك صحيحة 🎉"
                  : "إجابتك خاطئة\n\nالإجابة الصحيحة هي: ${question!
                  .options
                  .firstWhere((o) => o.isCorrect)
                  .text}",
              textAlign: TextAlign.center,
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("OK"),
              )
            ],
          ),
    );
  }

  Color getOptionColor(int index) {
    if (!answered) return Colors.white;

    final option = question!.options[index];

    if (option.isCorrect) {
      return Colors.green.shade100;
    } else if (selectedIndex == index && !option.isCorrect) {
      return Colors.red.shade100;
    } else {
      return Colors.white;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (question == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              /// عنوان السؤال
              Text(
                question!.title,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 20),

              /// السؤال
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Text(
                  question!.questionText,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                  textDirection: TextDirection.rtl,
                ),
              ),

              const SizedBox(height: 25),

            ]
        )
    );
  }
}