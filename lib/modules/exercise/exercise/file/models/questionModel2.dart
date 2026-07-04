class QuestionModel {

  final String title;
  final String question;
  final String url;

  QuestionModel({
    required this.title,
    required this.question,
    required this.url,
  });

  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    return QuestionModel(
      title: json['title'],
      question: json['question'],
      url: json['url'],
    );
  }
}