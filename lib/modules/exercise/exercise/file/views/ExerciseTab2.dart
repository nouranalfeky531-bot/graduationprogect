// import 'package:flutter/material.dart';
// import 'package:http/http.dart';
// import 'package:interactive_e_book_system/viewmodels/questioonViewModel2.dart';
// import 'package:interactive_e_book_system/views/questionPage2.dart';
// import 'package:interactive_e_book_system/views/webViewpage2.dart';
// import 'package:provider/provider.dart';
//
// class Exercise extends StatefulWidget {
//   @override
//   State<Exercise> createState() => _ExerciseTabState();
// }
//
// class _ExerciseTabState extends State<Exercise> {
//
//   @override
//   void initState() {
//     super.initState();
//     context.read<QuestionViewModel>().loadQuestions();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//
//     return Consumer<QuestionViewModel>(
//       builder: (context, vm, child) {
//
//         return ListView.builder(
//           itemCount: vm.questions.length,
//           itemBuilder: (context, index) {
//
//             final q = vm.questions[index];
//
//             return ListTile(
//               title: Text(q.title),
//               trailing: Icon(Icons.arrow_forward),
//
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (_) =>
//                         //WebViewPage(url:q.url)
// //WebViewPage(url: q.url)
//                         QuestionPage(title: q.title,question: q.question,url: q.url,)
//                         //QuestionPage(question: q),
//                   ),
//                 );
//               },
//             );
//           },
//         );
//       },
//     );
//   }
// }
//
//
//
//
//
//
//
//
//


import 'package:flutter/material.dart';
import 'package:graduation_progect/modules/exercise/exercise/file/views/question_webview.dart';
import 'package:provider/provider.dart';


import '../viewmodels/questioonViewModel2.dart';

class Exercise extends StatefulWidget {
  const Exercise({super.key});

  @override
  State<Exercise> createState() => _ExerciseState();
}

class _ExerciseState extends State<Exercise> {


  @override
  Widget build(BuildContext context) {
    return Consumer<QuestionViewModel>(
      builder: (context, vm, child) {
        print("Exercise Build");
        print("Questions Length = ${vm.questions.length}");

        if (vm.isLoading) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        if (vm.questions.isEmpty) {
          return const Scaffold(
            body: Center(
              child: Text(
                "No Questions Found",
                style: TextStyle(fontSize: 20),
              ),
            ),
          );
        }

        return Scaffold(
          appBar: AppBar(
            title: const Text("Questions"),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: ListView.builder(
              itemCount: vm.questions.length,
              itemBuilder: (context, index) {
                final q = vm.questions[index];

                print("Question Title = ${q.title}");
                print("Question Text = ${q.question}");

                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    title: Text(
                      q.title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    subtitle: Text(
                      q.question,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black87,
                      ),
                    ),
                    trailing: const Icon(Icons.open_in_new),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => QuestionWebView(
                            url: q.url,
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
































