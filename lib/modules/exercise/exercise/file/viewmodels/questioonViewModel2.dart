import 'package:flutter/material.dart';

import '../data/questionRepository2.dart';
import '../models/questionModel2.dart';



class QuestionViewModel extends ChangeNotifier {

  final QuestionRepository repository;

  QuestionViewModel(this.repository);
  String? selectedTitle;

  List<QuestionModel> questions = [];
  bool isLoading = false;
  void setSelectedTitle(String title) {
    selectedTitle = title;
    notifyListeners();
  }

  Future<void> loadQuestions() async {
    print("Title = $selectedTitle");

    isLoading = true;
    notifyListeners();

    questions = await QuestionRepository.getQuestions(selectedTitle!);

    print("Questions Count = ${questions.length}");

    isLoading = false;
    notifyListeners();
  }
}