import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/services.dart';

class Exercise extends StatelessWidget {
  Future<Question> loadQuestion() async {
    String data = await rootBundle.loadString('assets/files/QuestionSample.json');
    Map<String, dynamic> jsonResult = json.decode(data);
    return Question.fromJson(jsonResult);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Question>(
      future: loadQuestion(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('حدث خطأ: ${snapshot.error}'));
        } else if (!snapshot.hasData) {
          return Center(child: Text('لا توجد بيانات'));
        }

        Question question = snapshot.data!;
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                question.text,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              ...question.options.map(
                    (option) => OptionWidget(option: option),
              ),
            ],
          ),
        );
      },
    );
  }
}

// كلاس Question و Option
class Question {
  final String text;
  final List<Option> options;

  Question({required this.text, required this.options});

  factory Question.fromJson(Map<String, dynamic> json) {
    var opts = json['ioParameters']['Answers  2'] as List;
    List<Option> optionsList = opts.map((o) => Option.fromJson(o)).toList();
    return Question(
      text: json['ioParameters']['_Question_'],
      options: optionsList,
    );
  }
}

class Option {
  final String text;
  final bool isCorrect;

  Option({required this.text, required this.isCorrect});

  factory Option.fromJson(Map<String, dynamic> json) {
    return Option(
      text: json['_OptionText_'],
      isCorrect: json.containsKey('_Correct_') && json['_Correct_'] == true,
    );
  }
}

// Widget الخيار
class OptionWidget extends StatefulWidget {
  final Option option;
  OptionWidget({required this.option});

  @override
  _OptionWidgetState createState() => _OptionWidgetState();
}

class _OptionWidgetState extends State<OptionWidget> {
  bool selected = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selected = true;
        });
        String message = widget.option.isCorrect ? 'صح ✅' : 'غلط ❌';
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(message)));
      },
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.symmetric(vertical: 8),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: selected
              ? (widget.option.isCorrect ? Colors.green[200] : Colors.red[200])
              : Colors.grey[200],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(widget.option.text, style: TextStyle(fontSize: 18)),
      ),
    );
  }
}