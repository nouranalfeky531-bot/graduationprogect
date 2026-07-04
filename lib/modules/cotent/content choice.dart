import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../exercise/exercise/file/data/questionRepository2.dart';
import '../exercise/exercise/file/viewmodels/questioonViewModel2.dart';
import '../exercise/exercise/file/views/ExerciseTab2.dart';
import '../pdf/pdfviewmodel.dart';
import '../video/videoviewmodel.dart';

//class contenthoice{
//   static const List<String> fileNames = [
//     "assets/files/PDFSample3.json",
//     "assets/files/PDFSample2.json",
//     "assets/files/PDFSample.json",
//     "assets/files/SmartObjectSample.json",
//     "assets/files/SmartObjectSample-1.json",
//
//   ];
//
//   static Future<List<String>> getAllTitles() async {
//     List<String> titles = [];
//
//     for (final path in fileNames) {
//       try {
//         final String raw = await rootBundle.loadString(path);
//         final Map<String, dynamic> json = jsonDecode(raw);
//         if (json.containsKey('title')) {
//           titles.add(json['title']);
//         }
//       } catch (e) {
//         print('Error: $e');
//       }
//     }
//
//     return titles;
//   }

// class ContentChoice {
//   static const List<String> fileNames = [
//     "assets/files/TestVideo.json",
//     "assets/files/PDFSample3.json",
//     "assets/files/PDFSample2.json",
//     "assets/files/PDFSample.json",
//   "assets/files/ٍٍSmartObjectSample.json",
//     "assets/files/SmartObjectSample-1.json",
//   ];
//
//   static Future<List<String>> getAllTitles() async {
//     List<String> titles = [];
//
//     for (final path in fileNames) {
//       try {
//         final String raw = await rootBundle.loadString(path);
//         final Map<String, dynamic> json = jsonDecode(raw);
//
//         if (json.containsKey('title')) {
//           titles.add(json['title']);
//         }
//       } catch (e) {
//         print("Error loading $path : $e");
//       }
//     }
//
//     return titles;
//   }
//
//
//   static Future<dynamic> openContentByTitle(String title) async {
//     for (final filepath in fileNames) {
//       try {
//         String jsonString = await rootBundle.loadString(filepath);
//         var jsonData = json.decode(jsonString);
//
//         if (jsonData['title'] == title) {
//           String type = jsonData['contentType'];
//
//           if (type == "application/pdf") {
//             return await PdfViewModel.loadPdfDetails(title);
//           }
//
//           if (jsonData["contentType"]=="video/mp4") {
//             return await videoviewModel.loadvediodetails(title);
//           }
//         }
//       } catch (e) {
//         print("Error reading $filepath: $e");
//       }
//     }
//
//     throw Exception("Content not found");
//   }
//
// //type.toString().startsWith("video")
// }

// import 'dart:convert';
//
// import 'package:flutter/services.dart';
//
// import '../pdf/pdfviewmodel.dart';
// import '../video/videoviewmodel.dart';

//class contenthoice{
//   static const List<String> fileNames = [
//     "assets/files/PDFSample3.json",
//     "assets/files/PDFSample2.json",
//     "assets/files/PDFSample.json",
//     "assets/files/SmartObjectSample.json",
//     "assets/files/SmartObjectSample-1.json",
//
//   ];
//
//   static Future<List<String>> getAllTitles() async {
//     List<String> titles = [];
//
//     for (final path in fileNames) {
//       try {
//         final String raw = await rootBundle.loadString(path);
//         final Map<String, dynamic> json = jsonDecode(raw);
//         if (json.containsKey('title')) {
//           titles.add(json['title']);
//         }
//       } catch (e) {.
//         print('Error: $e');
//       }
//     }
//
//     return titles;
//   }

class ContentChoice {
  static const List<String> fileNames = [
    "assets/files/question.json",
    "assets/files/TestVideo.json",
    "assets/files/PDFSample3.json",
    "assets/files/PDFSample2.json",
    "assets/files/PDFSample.json",
    "assets/files/ٍٍSmartObjectSample.json",
    "assets/files/SmartObjectSample-1.json",
  ];

  static Future<List<String>> getAllTitles() async {
    List<String> titles = [];

    for (final path in fileNames) {
      try {
        final String raw = await rootBundle.loadString(path);
        final Map<String, dynamic> json = jsonDecode(raw);

        if (json.containsKey('title')) {
          titles.add(json['title']);
        }

        if (json.containsKey('questions')) {
          for (var question in json['questions']) {
            if (question.containsKey('title')) {
              titles.add(question['title']);
            }
          }
        }

      } catch (e) {
        print("Error loading $path : $e");
      }
    }

    return titles;
  }

  static Future<dynamic> openContentByTitle(String title) async {
    for (final filepath in fileNames) {
      try {
        String jsonString = await rootBundle.loadString(filepath);
        var jsonData = json.decode(jsonString);

        // PDF / Video
        if (jsonData['title'] == title) {
          String type = jsonData['contentType'];

          if (type == "application/pdf") {
            return await PdfViewModel.loadPdfDetails(title);
          } else if (type == "video/mp4") {
            return await videoviewModel.loadvediodetails(title);
          }
        }

        // Questions
        if (jsonData.containsKey('questions')) {
          for (var q in jsonData['questions']) {
            print("Question title = ${q['title']}");

            if (q['title'].toString().trim() ==
                title.toString().trim()) {
              print("Found question");

              return await QuestionRepository.getQuestions(title);
            }
          }
        }
      } catch (e) {
        print("Error reading $filepath: $e");
      }
    }

    throw Exception("Content not found");
  }

  //type.toString().startsWith("video")
}
