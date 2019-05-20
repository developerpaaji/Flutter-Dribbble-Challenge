import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:payment/challenge3/models/question.dart';

String url="https://opentdb.com/api.php?amount=10&category=9&difficulty=easy&type=multiple";

Future<List<Question>> getQuestions()async{
  http.Response response=await http.get(url);
  var json=jsonDecode(response.body);
  List<Question> questions=List<Question>.from(json["results"].map((item)=>Question.fromJson(item)));
  return questions;
}

Question getQuestion() {
  return Question(
    title: "What was the name of the Ethiopian Wolf before they knew it was related to wolves?",
    incorrectAnswers: ["Amharic Fox","Simien Jackel",],
    correctAnswer:"Ethiopian Coyote" 
  );
}
