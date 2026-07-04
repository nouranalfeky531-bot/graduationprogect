import 'dart:convert';
import 'package:flutter/services.dart';

import '../models/questionModel2.dart';



class QuestionRepository {

  static Future<List<QuestionModel>> getQuestions(String title) async {
    final data =
    await rootBundle.loadString('assets/files/question.json');

    final jsonResult = json.decode(data);

    return (jsonResult['questions'] as List)
        .map((e) => QuestionModel.fromJson(e))
        .where((q) => q.title == title)
        .toList();
  }
}