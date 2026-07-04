// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:graduation_progect/modules/coursescrean/widgets/pdfpage.dart';
// import 'package:graduation_progect/modules/coursescrean/widgets/vediopage.dart';
//
// import '../../lesson/lessonpage.dart';
// import '../../pdf/widgets/pdfdrobdown.dart';
//
//
//
// class ContentPage extends StatefulWidget {
//
//
//   @override
//   State<ContentPage> createState() => _ContentPageState();
// }
//
// class _ContentPageState extends State<ContentPage> {
//
//   List lessons = [];
//
//   Future loadJson() async {
//
//     String data = await rootBundle.loadString('assets/LessonSample.json');
//     var jsonResult = json.decode(data);
//
//     setState(() {
//       lessons = jsonResult["ontology"][0]["children"];
//     });
//
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     loadJson();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//
//     return Scaffold(
//       // appBar: AppBar(title: const Text("Content")),
//
//       body: ListView.builder(
//         itemCount: lessons.length,
//
//         itemBuilder: (context,index){
//
//           var lesson = lessons[index];
//           var objects = lesson["aims"]["aimObjects"];
//
//           return Card(
//
//             margin: const EdgeInsets.all(10),
//
//             child:
//             ExpansionTile(
//
//               title: Text(
//                 lesson["name"],
//                 style: const TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold
//                 ),
//               ),
//
//               children: List.generate(objects.length, (i){
//
//                 var obj = objects[i];
//
//                 return ListTile(
//
//                   leading: Icon(
//                     obj["type"] == "pdf"
//                         ? Icons.picture_as_pdf
//                         : Icons.play_circle,
//                     color: Colors.blue,
//                   ),
//
//                   title: Text(obj["title"]),
//
//                   onTap: (){
//
//                     if(obj["type"] == "pdf"){
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => Scaffold(
//                             body: pdfTitleDropdown(),
//                           ),
//                         ),
//                       );
//
//                     }else{
//                       // TitleDropdown();
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => TitleDropdown(),
//                         ),
//                       );
//
//                     }
//
//                   },
//
//                 );
//
//               }),
//
//             ),
//
//           );
//
//         },
//
//       ),
//
//     );
//
//   }
//
// }
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../cotent/content choice.dart';
import '../../lesson/lessonpage.dart';
import '../../pdf/models/Pdfresponse.dart';
import '../../pdf/pdfprovider.dart';
import '../../pdf/pdfview.dart';
import '../../pdf/pdfviewmodel.dart';
import '../../pdf/widgets/pdfdrobdown.dart';
import '../../video/models/Videoresponse.dart';
import '../../video/videosurvices/videoprovider.dart';
import '../../video/videoveiw.dart';
import '../../video/videoviewmodel.dart';
import '../../video/widgets/dropdown.dart';
import 'package:provider/provider.dart';

import 'exersize.dart';

class ContentPage extends StatefulWidget {
  @override
  State<ContentPage> createState() => _ContentPageState();
}

class _ContentPageState extends State<ContentPage> {
  List lessons = [];
  List<String> _titles = [];
  String? _selectedTitle;
  bool _loading = true;

  Future loadJson() async {
    String data = await rootBundle.loadString('assets/LessonSample.json');
    var jsonResult = json.decode(data);
    setState(() {
      lessons = jsonResult["ontology"][0]["children"];
    });
  }

  Future<void> _loadTitles() async {
    final titles = await videoviewModel.getAllTitles();
    setState(() {
      _titles = titles;
      _loading = false;
    });
  }
  Future<void> _onTitleSelected(String title) async {
    try {
      final navigator = Navigator.of(context);
      final videoProvider = context.read<VideoProvider>();

      var result = await ContentChoice.openContentByTitle(title);

      videoProvider.setSelectedTitle(title);

      if (result is Videoresponse) {
        navigator.push(
          MaterialPageRoute(builder: (_) => const Videoveiw()),
        );
      }
    } catch (e) {
      print("onTap error: $e");
    }
  }
  List<String> _pdftitles = [];
  String? _pdfselectedTitle;
  bool _pdfloading = true;

  // @override
  // void initState() {
  //   super.initState();
  //   _loadTitles();
  // }

  Future<void> _loadpdfTitles() async {
    final titles = await PdfViewModel.getAllTitles();
    setState(() {
      _pdftitles = titles;
      _pdfloading = false;
    });
  }

  Future<void> _onPdfSelected(String title) async {
    try {
      final navigator = Navigator.of(context);
      final pdfProvider = context.read<PdfProvider>();
      var result = await ContentChoice.openContentByTitle(title);

      pdfProvider.setSelectedTitle(title);

      if (result is Pdfresponse) {
        navigator.push(
          MaterialPageRoute(builder: (_) => const PdfView()),
        );
      }
    } catch (e) {
      print("onTap error: $e");
    }
  }
  @override
  void initState() {
    super.initState();
    loadJson();
    _loadTitles();
    _loadpdfTitles();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
          children: [
            // SizedBox(height: 10,),
            Row(
              children: [
                Expanded(
                  child: Card(
                    child: CustomDropdown(
                      hint: 'chose your vedio',
                      value: _selectedTitle,
                      items: _titles,
                      onChanged: (value) {
                        if (value == null) return;
                        setState(() => _selectedTitle = value);
                        _onTitleSelected(value);
                      },
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: Card(
                    child: CustomDropdown(
                      hint: 'chose your pdf',
                      value: _pdfselectedTitle,
                      items: _pdftitles,
                      onChanged: (value) {
                        if (value == null) return;
                        setState(() => _pdfselectedTitle = value);
                        _onPdfSelected(value);
                      },
                    ),
                  ),
                ),
              ],
            ),
            Row(
children: [

],
            )
          ],
                  ),
                ),






      // body: ListView.builder(
      //   itemCount: lessons.length,
      //   itemBuilder: (context, index) {
      //     var lesson = lessons[index];
      //
      //     return Card(
      //       margin: const EdgeInsets.all(10),
      //       child: ExpansionTile(
      //         title: Text(
      //           lesson["name"],
      //           style: const TextStyle(
      //             fontSize: 18,
      //             fontWeight: FontWeight.bold,
      //           ),
      //         ),
      //         children: [
      //           Padding(
      //             padding: const EdgeInsets.symmetric(horizontal: 16),
      //             child: SizedBox(
      //               width: double.infinity,
      //               child: TitleDropdown(),
      //             ),
      //           ),
      //           Padding(
      //             padding: const EdgeInsets.symmetric(horizontal: 16),
      //             child: SizedBox(
      //               width: double.infinity,
      //               child: pdfTitleDropdown(),
      //             ),
      //           ),
      //         ],
      //       ),
      //     );
      //   },
      // ),
    );
  }
}