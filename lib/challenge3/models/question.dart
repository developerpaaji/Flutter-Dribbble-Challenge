import 'dart:math';

class Question {
  final String title;
  final List<String> incorrectAnswers;
  final String correctAnswer;
  Question({this.title, this.incorrectAnswers, this.correctAnswer});
  Question.fromJson(Map json)
      : title = json["question"],
        incorrectAnswers = List<String>.from(json["incorrect_answers"]),
        correctAnswer = json["correct_answer"];
  List<String> get options {
    List<String> options = [];
    options.addAll(incorrectAnswers.take(2));
    options.insert(2, correctAnswer);
    return options;
  }
}
