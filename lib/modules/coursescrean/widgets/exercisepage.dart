// // import 'dart:convert';
// //
// // import 'package:flutter/material.dart';
// //
// // import 'package:flutter/material.dart';
// // import 'package:flutter/services.dart';
// // import 'package:flutter/services.dart';
// //
// // class Exercise extends StatelessWidget {
// //   Future<Question> loadQuestion() async {
// //     String data = await rootBundle.loadString('assets/files/QuestionSample.json');
// //     Map<String, dynamic> jsonResult = json.decode(data);
// //     return Question.fromJson(jsonResult);
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return FutureBuilder<Question>(
// //       future: loadQuestion(),
// //       builder: (context, snapshot) {
// //         if (snapshot.connectionState == ConnectionState.waiting) {
// //           return Center(child: CircularProgressIndicator());
// //         } else if (snapshot.hasError) {
// //           return Center(child: Text('حدث خطأ: ${snapshot.error}'));
// //         } else if (!snapshot.hasData) {
// //           return Center(child: Text('لا توجد بيانات'));
// //         }
// //
// //         Question question = snapshot.data!;
// //         return Padding(
// //           padding: const EdgeInsets.all(16.0),
// //           child: Column(
// //             crossAxisAlignment: CrossAxisAlignment.start,
// //             children: [
// //               Text(
// //                 question.text,
// //                 style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
// //               ),
// //               SizedBox(height: 20),
// //               ...question.options.map(
// //                     (option) => OptionWidget(option: option),
// //               ),
// //             ],
// //           ),
// //         );
// //       },
// //     );
// //   }
// // }
// //
// // // كلاس Question و Option
// // class Question {
// //   final String text;
// //   final List<Option> options;
// //
// //   Question({required this.text, required this.options});
// //
// //   factory Question.fromJson(Map<String, dynamic> json) {
// //     var opts = json['ioParameters']['Answers  2'] as List;
// //     List<Option> optionsList = opts.map((o) => Option.fromJson(o)).toList();
// //     return Question(
// //       text: json['ioParameters']['_Question_'],
// //       options: optionsList,
// //     );
// //   }
// // }
// //
// // class Option {
// //   final String text;
// //   final bool isCorrect;
// //
// //   Option({required this.text, required this.isCorrect});
// //
// //   factory Option.fromJson(Map<String, dynamic> json) {
// //     return Option(
// //       text: json['_OptionText_'],
// //       isCorrect: json.containsKey('_Correct_') && json['_Correct_'] == true,
// //     );
// //   }
// // }
// //
// // // Widget الخيار
// // class OptionWidget extends StatefulWidget {
// //   final Option option;
// //   OptionWidget({required this.option});
// //
// //   @override
// //   _OptionWidgetState createState() => _OptionWidgetState();
// // }
// //
// // class _OptionWidgetState extends State<OptionWidget> {
// //   bool selected = false;
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return GestureDetector(
// //       onTap: () {
// //         setState(() {
// //           selected = true;
// //         });
// //         String message = widget.option.isCorrect ? 'صح ✅' : 'غلط ❌';
// //         ScaffoldMessenger.of(context)
// //             .showSnackBar(SnackBar(content: Text(message)));
// //       },
// //       child: Container(
// //         width: double.infinity,
// //         margin: EdgeInsets.symmetric(vertical: 8),
// //         padding: EdgeInsets.all(12),
// //         decoration: BoxDecoration(
// //           color: selected
// //               ? (widget.option.isCorrect ? Colors.green[200] : Colors.red[200])
// //               : Colors.grey[200],
// //           borderRadius: BorderRadius.circular(8),
// //         ),
// //         child: Text(widget.option.text, style: TextStyle(fontSize: 18)),
// //       ),
// //     );
// //   }
// // }
// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
//
// //////////////////////////////////////////////////////////////
// // import 'package:flutter/material.dart';
// // import 'package:webview_flutter/webview_flutter.dart';
// //
// // class ExercisePage extends StatefulWidget {
// //   final String exerciseUrl;
// //
// //   const ExercisePage({
// //     super.key,
// //     required this.exerciseUrl,
// //   });
// //
// //   @override
// //   State<ExercisePage> createState() => _ExercisePageState();
// // }
// //
// // class _ExercisePageState extends State<ExercisePage> {
// //   late final WebViewController controller;
// //   bool isLoading = true;
// //
// //   @override
// //   void initState() {
// //     super.initState();
// //
// //     controller = WebViewController()
// //       ..setJavaScriptMode(JavaScriptMode.unrestricted)
// //       ..setNavigationDelegate(
// //         NavigationDelegate(
// //           onPageStarted: (String url) {
// //             setState(() {
// //               isLoading = true;
// //             });
// //           },
// //           onPageFinished: (String url) {
// //             setState(() {
// //               isLoading = false;
// //             });
// //           },
// //         ),
// //       )
// //       ..loadRequest(Uri.parse(widget.exerciseUrl));
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Stack(
// //       children: [
// //         WebViewWidget(controller: controller),
// //         if (isLoading)
// //           const Center(
// //             child: CircularProgressIndicator(),
// //           ),
// //       ],
// //     );
// //   }
// // }
// /////////////////////////////////////
// //import 'dart:convert';
// //import 'package:flutter/material.dart';
// //import 'package:flutter/services.dart';
//
// // void main() {
// //   runApp(MyApp());
// // }
// //
// // class MyApp extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       debugShowCheckedModeBanner: false,
// //       home: QuestionsScreen(),
// //     );
// //   }
// // }
//
// /// ================= MODEL =================
// // class Question {
// //   final String question;
// //   final List<Option> options;
// //
// //   Question({required this.question, required this.options});
// //
// //   factory Question.fromJson(Map<String, dynamic> json) {
// //     return Question(
// //       question: json['question'],
// //       options: (json['options'] as List)
// //           .map((e) => Option.fromJson(e))
// //           .toList(),
// //     );
// //   }
// // }
// //
// // class Option {
// //   final String text;
// //   final bool isCorrect;
// //
// //   Option({required this.text, required this.isCorrect});
// //
// //   factory Option.fromJson(Map<String, dynamic> json) {
// //     return Option(
// //       text: json['text'],
// //       isCorrect: json['isCorrect'],
// //     );
// //   }
// // }
// //
// // /// ================= LOAD JSON =================
// // Future<List<Question>> loadQuestions() async {
// //   final data = await rootBundle.loadString('assets/files/QuestionSample.json');
// //   final jsonData = json.decode(data);
// //
// //   return (jsonData['questions'] as List)
// //       .map((e) => Question.fromJson(e))
// //       .toList();
// // }
// //
// // /// ================= UI =================
// // class Exercisetab extends StatefulWidget {
// //   @override
// //   State<Exercisetab> createState() => _QuestionsScreenState();
// // }
// //
// // class _QuestionsScreenState extends State<Exercisetab> {
// //   List<Question> questions = [];
// //   Map<int, int> selectedAnswers = {};     // الإجابات المختارة
// //   Map<int, bool> checkedQuestions = {};   // هل ضغط Check
// //   bool loading = true;
// //
// //   @override
// //   void initState() {
// //     super.initState();
// //     loadData();
// //   }
// //
// //   void loadData() async {
// //     questions = await loadQuestions();
// //     setState(() => loading = false);
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     if (loading) {
// //       return Scaffold(
// //         body: Center(child: CircularProgressIndicator()),
// //       );
// //     }
// //
// //     return Scaffold(
// //         appBar: AppBar(
// //           title: Text("MCQ Test"),
// //           centerTitle: true,
// //         ),
// //         body: ListView.builder(
// //         padding: EdgeInsets.all(12),
// //     itemCount: questions.length,
// //     itemBuilder: (context, qIndex) {
// //     final q = questions[qIndex];
// //
// //     return Container(
// //     margin: EdgeInsets.only(bottom: 15),
// //     padding: EdgeInsets.all(15),
// //     decoration: BoxDecoration(
// //     color: Colors.white,
// //     borderRadius: BorderRadius.circular(15),
// //     boxShadow: [
// //     BoxShadow(
// //     blurRadius: 5,
// //     color: Colors.grey.shade300,
// //     )
// //     ],
// //     ),
// //     child: Column(
// //     crossAxisAlignment: CrossAxisAlignment.start,
// //     children: [
// //     /// السؤال
// //     Text(
// //     "Q${qIndex + 1}: ${q.question}",
// //     style: TextStyle(
// //     fontSize: 18, fontWeight: FontWeight.bold),
// //     ),
// //
// //     SizedBox(height: 12),
// //
// //     /// الاختيارات
// //     ...List.generate(q.options.length, (oIndex) {
// //     final option = q.options[oIndex];
// //     final isSelected = selectedAnswers[qIndex] == oIndex;
// //     final isChecked = checkedQuestions[qIndex] == true;
// //     final isCorrect = option.isCorrect;
// //
// //     return Container(
// //     margin: EdgeInsets.symmetric(vertical: 5),
// //     decoration: BoxDecoration(
// //     color: isChecked && isSelected
// //     ? (isCorrect
// //     ? Colors.green.withOpacity(0.1): Colors.red.withOpacity(0.1))
// //         : Colors.white,
// //       border: Border.all(
// //         color: isChecked && isSelected
// //             ? (isCorrect ? Colors.green : Colors.red)
// //             : Colors.grey.shade300,
// //       ),
// //       borderRadius: BorderRadius.circular(10),
// //     ),
// //       child: RadioListTile<int>(
// //         title: Text(option.text),
// //         value: oIndex,
// //         groupValue: selectedAnswers[qIndex],
// //         onChanged: (val) {
// //           if (isChecked) return; // يمنع التعديل بعد Check
// //           setState(() {
// //             selectedAnswers[qIndex] =val!;
// //           });
// //         },
// //       ),
// //     );
// //     }),
// //
// //       SizedBox(height: 10),
// //
// //       /// زر Check
// //       ElevatedButton(
// //         onPressed: selectedAnswers[qIndex] == null
// //             ? null
// //             : () {
// //           setState(() {
// //             checkedQuestions[qIndex] = true;
// //           });
// //         },
// //         child: Text("Check"),
// //       ),
// //
// //       SizedBox(height: 10),
// //
// //       /// النتيجة بعد الضغط
// //       if (checkedQuestions[qIndex] == true)
// //         Builder(
// //           builder: (_) {
// //             final selectedIndex = selectedAnswers[qIndex];
// //             final isCorrect =
// //                 q.options[selectedIndex!].isCorrect;
// //
// //             if (isCorrect) {
// //               return Column(
// //                 crossAxisAlignment: CrossAxisAlignment.start,
// //                 children: [
// //                   Row(
// //                     children: [
// //                       Icon(Icons.star, color: Colors.amber),
// //                       SizedBox(width: 5),
// //                       Text(
// //                         "Correct!",
// //                         style: TextStyle(
// //                             color: Colors.green,
// //                             fontWeight: FontWeight.bold),
// //                       ),
// //                     ],
// //                   ),
// //                   SizedBox(height: 5),
// //                   LinearProgressIndicator(
// //                     value: 1,
// //                     backgroundColor: Colors.grey.shade300,
// //                     valueColor: AlwaysStoppedAnimation(
// //                         Colors.green),
// //                   ),
// //                 ],
// //               );
// //             } else {
// //               return Text(
// //                 "Wrong answer ❌",
// //                 style: TextStyle(
// //                     color: Colors.red,
// //                     fontWeight: FontWeight.bold),
// //               );
// //             }
// //           },
// //         ),
// //     ],
// //     ),
// //     );
// //     },
// //         ),
// //     );
// //   }
// //}
// /////////////////////////////////////
// class Question {
//   final String question;
//   final List<Option> options;
//
//   Question({required this.question, required this.options});
//
//   factory Question.fromJson(Map<String, dynamic> json) {
//     return Question(
//       question: json["ioParameters"]["_Question_"],
//       options: (json["ioParameters"]["Answers  2"] as List)
//           .map((e) => Option.fromJson(e))
//           .toList(),
//     );
//   }
// }
//
// class Option {
//   final String text;
//   final bool isCorrect;
//
//   Option({required this.text, this.isCorrect = false});
//
//   factory Option.fromJson(Map<String, dynamic> json) {
//     return Option(
//       text: json["_OptionText_"],
//       isCorrect: json["_Correct_"] ?? false,
//     );
//   }
// }
// // import 'dart:convert';
// // import 'package:flutter/services.dart';
//
// Future<List<Question>> loadQuestions() async {
//   final String data =
//   await rootBundle.loadString('assets/files/QuestionSample.json');
//
//   final Map<String, dynamic> jsonResult = json.decode(data);
//
//   return [
//     Question.fromJson(jsonResult),
//   ];
// }
// // import 'dart:convert';
// //
// // import 'package:flutter/material.dart';
// // import 'package:flutter/services.dart';
//
// class QuizPage extends StatefulWidget {
//   @override
//   State<QuizPage> createState() => _QuizPageState();
// }
//
// class _QuizPageState extends State<QuizPage> {
//   List<Question> questions = [];
//   Map<int, int?> selectedAnswers = {};
//   Map<int, bool> checked = {};
//   int score = 0;
//
//   @override
//   void initState() {
//     super.initState();
//     loadData();
//   }
//
//   void loadData() async {
//     questions = await loadQuestions();
//     setState(() {});
//   }
//
//   void checkAnswer(int qIndex) {
//     final q = questions[qIndex];
//     final selected = selectedAnswers[qIndex];
//
//     if (selected == null) return;
//
//     final isCorrect = q.options[selected].isCorrect;
//
//     setState(() {
//       checked[qIndex] = true;
//       if (isCorrect) score++;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Quiz")),
//       body: questions.isEmpty
//           ? Center(child: CircularProgressIndicator())
//           : Column(
//         children: [
//       Expanded(
//       child: ListView.builder(
//       itemCount: questions.length,
//         itemBuilder: (context, qIndex) {
//           final q = questions[qIndex];
//
//           return Card(
//             margin: EdgeInsets.all(10),
//             child: Padding(
//               padding: EdgeInsets.all(10),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     q.question,
//                     style: TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold),
//                   ),
//
//                   ...List.generate(q.options.length, (oIndex) {
//                     return RadioListTile<int>(
//                       value: oIndex,
//                       groupValue: selectedAnswers[qIndex],
//                       title: Text(q.options[oIndex].text),
//                       onChanged: checked[qIndex] == true
//                           ? null
//                           : (val) {
//                         setState(() {
//                           selectedAnswers[qIndex] = val;
//                         });
//                       },
//                     );
//                   }),
//
//                   SizedBox(height: 10),
//
//                   ElevatedButton(
//                     onPressed: checked[qIndex] == true
//                         ? null
//                         : () => checkAnswer(qIndex),
//                     child: Text("Check"),
//                   ),
//
//                   if (checked[qIndex] == true)
//                     Container(
//                       margin: EdgeInsets.only(top: 10),
//                       padding: EdgeInsets.all(10),
//                       decoration: BoxDecoration(
//                         color: Colors.green.withOpacity(0.2),
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                       child: Row(
//                         children: [
//                           Icon(Icons.star, color: Colors.green),
//                           SizedBox(width: 5),
//                           Text("Checked"),
//                         ],
//                       ),
//                     ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     ),
//           // progress bar
//           Padding(
//             padding: EdgeInsets.all(10),
//             child: LinearProgressIndicator(
//               value: questions.isEmpty
//                   ? 0
//                   : checked.length / questions.length,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

////////////////////////////





class Question {
  final String question;
  final List<Option> options;

  Question({required this.question, required this.options});

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      question: json['question'],
      options: (json['options'] as List)
          .map((e) => Option.fromJson(e))
          .toList(),
    );
  }
}

class Option {
  final String text;
  final bool isCorrect;

  Option({required this.text, required this.isCorrect});

  factory Option.fromJson(Map<String, dynamic> json) {
    return Option(
      text: json['text'],
      isCorrect: json['isCorrect'],
    );
  }
}
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'question.dart';

Future<List<Question>> loadQuestions() async {
  final String data =
  await rootBundle.loadString('assets/files/QuestionSample.json');

  final decoded = json.decode(data);

  return (decoded['questions'] as List)
      .map((e) => Question.fromJson(e))
      .toList();
}
// import 'package:flutter/material.dart';
// import 'question.dart';
// import 'load_questions.dart';

class QuizPage extends StatefulWidget {
  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Question> questions = [];

  Map<int, int?> selectedAnswers = {};
  Map<int, bool> checked = {};
  Map<int, bool> isCorrectMap = {};

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() async {
    questions = await loadQuestions();
    setState(() {});
  }

  void checkAnswer(int index) {
    final q = questions[index];
    final selected = selectedAnswers[index];

    if (selected == null) return;

    final correct = q.options[selected].isCorrect;

    setState(() {
      checked[index] = true;
      isCorrectMap[index] = correct;
    });
  }

  int get score =>
      isCorrectMap.values.where((e) => e == true).length;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: Text("Quiz App - Score: $score"),
    backgroundColor: Colors.blue,
    ),

    body: questions.isEmpty
    ? Center(child: CircularProgressIndicator())
        : Column(
    children: [
    Expanded(
    child: ListView.builder(
    itemCount: questions.length,
    itemBuilder: (context, index) {
    final q = questions[index];
    final done = checked[index] == true;
    final correct = isCorrectMap[index] == true;

    return Card(
    margin: EdgeInsets.all(10),
    child: Padding(
    padding: EdgeInsets.all(12),
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    Text(
    q.question,
    style: TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    ),
    ),

    SizedBox(height: 10),

    ...List.generate(q.options.length, (i) {
    return RadioListTile<int>(
    value: i,
    groupValue: selectedAnswers[index],
    title: Text(q.options[i].text),
    onChanged: done
    ? null
        : (val) {
    setState(() {
    selectedAnswers[index] = val;
    });
    },
    );
    }),

    ElevatedButton(
    onPressed: done
    ? null
        : () => checkAnswer(index),
    child: Text("Check"),
    ),

    if (done)
    Container(
    margin: EdgeInsets.only(top: 10),
    padding: EdgeInsets.all(10),
    decoration: BoxDecoration(
    color: correct
    ? Colors.green.withOpacity(0.2)
        : Colors.red.withOpacity(0.2),borderRadius: BorderRadius.circular(10),
    ),
      child: Row(
        children: [
          Icon(
            correct
                ? Icons.check_circle
                : Icons.cancel,
            color: correct
                ? Colors.green
                : Colors.red,
          ),
          SizedBox(width: 5),
          Text(
            correct ? "Correct" : "Wrong",
          ),
        ],
      ),
    ),
    ],
    ),
    ),
    );
    },
    ),
    ),

      // Progress Bar
      Padding(
        padding: EdgeInsets.all(10),
        child: LinearProgressIndicator(
          value: questions.isEmpty
              ? 0
              : checked.length / questions.length,
          color: Colors.green,
          backgroundColor: Colors.grey[300],
        ),
      ),
    ],
    ),
    );
  }
}