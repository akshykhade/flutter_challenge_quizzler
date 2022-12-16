import 'package:flutter/material.dart';

class QuestionBank {
  List<Question> questions = [
    Question('You can lead a cow down stairs but not up stairs.', false),
    Question('Approximately one quarter of human bones are in the feet.', true),
    Question('A slug\'s blood is green.', true)
  ];
  List<Icon> results = [];
  int currentIndex = 0;
  bool completed = false;
  int getScore() {
    var correctAns =
        results.where((element) => element.icon == Icons.check).length;
    return correctAns;
  }

  Question getCurrent() {
    return questions[currentIndex];
  }

  void next() {
    if (currentIndex < questions.length - 1) {
      currentIndex++;
    } else {
      completed = true;
    }
  }

  void reset() {
    currentIndex = 0;
    results.clear();
    completed = false;
  }

  void addCorrect() {
    results.add(Icon(
      Icons.check,
      color: Colors.green,
    ));
  }

  void addIncorrect() {
    results.add(Icon(
      Icons.close,
      color: Colors.red,
    ));
  }
}

class Question {
  String question = "";
  bool answer;
  Question(this.question, this.answer);
}
