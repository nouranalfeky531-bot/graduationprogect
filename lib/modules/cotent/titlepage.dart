import 'package:flutter/material.dart';
import 'package:graduation_progect/core/theme/app_colors.dart';
import 'package:graduation_progect/modules/video/videosurvices/videoprovider.dart';
import 'package:provider/provider.dart';

import '../exercise/exercise/file/viewmodels/questioonViewModel2.dart';
import '../exercise/exercise/file/views/ExerciseTab2.dart';
import '../pdf/models/Pdfresponse.dart';
import '../pdf/pdfprovider.dart';
import '../pdf/pdfview.dart';
import '../video/models/Videoresponse.dart';
import '../video/videoveiw.dart';
import 'content choice.dart';

class TitlePage extends StatelessWidget {
  const TitlePage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.borderColor,

      // appBar: AppBar(
      //   // title: Text("Content"),
      //   // backgroundColor: Colors.blue,
      // ),
      body: FutureBuilder<List<String>>(
        future: ContentChoice.getAllTitles(),
        builder: (context, snapshot) {

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No Courses Found"));
          }

          final titles = snapshot.data!;

          return Container(
            color: const Color(0xfff3f3f3),
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: titles.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 14),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                     color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 6,
                        offset: Offset(0, 3),
                      )
                    ],
                  ),
                  child: ListTile(
                    leading: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppColors.appBarColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(Icons.bookmark,color: AppColors.secondaryColor,),
                    ),
                    title: Text(
                      titles[index],
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    // subtitle: const Text("Course content"),
                    // trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () async {
                      try {
                        final title = titles[index];

                        var result = await ContentChoice.openContentByTitle(title);
                        print("Result type: ${result.runtimeType}"); // ← شوفي بيطبع إيه

                        if (!context.mounted) return;

                        context.read<VideoProvider>().setSelectedTitle(title);

                       if (result is Videoresponse) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => const Videoveiw()),
                          );
                        }
                       else if (result is Pdfresponse) {
                          context.read<PdfProvider>().setSelectedTitle(title); // ← دي المهمة
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => const PdfView()),
                          );
                        }
                        else{
                         final vm = context.read<QuestionViewModel>();

                         vm.setSelectedTitle(title);
                         await vm.loadQuestions();

                         print("Before Navigate");

                         Navigator.push(
                           context,
                           MaterialPageRoute(
                             builder: (_) => const Exercise(),
                           ),
                         );

                         print("After Navigate");

                        }


                      } catch (e) {
                        print("onTap error: $e"); // ← هنا هتشوفي المشكلة
                      }
                    },
                    //   onTap: () async {
                    //
                    //     var result = await ContentChoice.openContentByTitle(titles[index]);
                    //     if (!context.mounted) return;
                    //     context.read<VideoProvider>().setSelectedTitle(titles[index]);
                    //
                    //     if (result is Pdfresponse) {
                    //       // Navigator.push(
                    //       //   context,
                    //       //   // MaterialPageRoute(
                    //       //   //   // builder: (_) => PdfViewScreen(pdf: result),
                    //       //   // ),
                    //       // );
                    //     }
                    //
                    //     if (result is Videoresponse) {
                    //
                    //       Navigator.push(
                    //         context,
                    //         MaterialPageRoute(
                    //           builder: (_) => Videoveiw(),
                    //         ),
                    //       );
                    //     }
                    //   }
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
