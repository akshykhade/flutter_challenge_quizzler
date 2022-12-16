import 'package:flutter/material.dart';
import 'package:quizzler/questionBank.dart';

void main() => runApp(Quizzler());

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  QuestionBank questionBank = QuestionBank();

  void checkAnswer(bool userClick) {
    if (questionBank.getCurrent().answer == userClick) {
      questionBank.addCorrect();
    } else {
      questionBank.addIncorrect();
    }
    setState(() {
      questionBank.next();
    });
    if (questionBank.completed) {
      showAlertDialog(context);
    }
  }

  Widget buildButton(bool userInput) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.all(15.0),
        child: MaterialButton(
          textColor: Colors.white,
          color: userInput ? Colors.green : Colors.red,
          child: Text(
            userInput ? 'True' : 'False',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.0,
            ),
          ),
          onPressed: () {
            checkAnswer(userInput);
          },
        ),
      ),
    );
  }

  showAlertDialog(BuildContext context) {
    var score = questionBank.getScore();
    AlertDialog alert = AlertDialog(
      title: Text("Quizz completed!!!"),
      content: Text("you have completed the quizz with score - $score"),
      actions: [
        TextButton(
          child: Text("OK & Reset"),
          onPressed: () {
            setState(() {
              questionBank.reset();
            });
            Navigator.pop(context);
          },
        ),
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (b) => alert,
      barrierDismissible: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                questionBank.getCurrent().question,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        buildButton(true),
        buildButton(false),
        Row(
          children: questionBank.results,
        )
      ],
    );
  }
}
