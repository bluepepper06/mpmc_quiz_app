import 'package:flutter/material.dart';
import 'package:quiz_app/widgets/next_button.dart';

import '../constants.dart';
import '../models/question_models.dart';
import '../widgets/option_card.dart';
import '../widgets/questions_widget.dart';
import '../widgets/result_box.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List<Question> _questions;
  int index = 0;
  int score = 0;
  bool isAnswered = false;
  bool isPressed = false;
  bool isAlreadySelected = false;

  @override
  void initState() {
    super.initState();
    _questions = [
      Question(
        id: '10',
        title: 'What is 2 + 2 ?',
        options: {'5': false, '30': false, '4': true, '10': false},
      ),
      Question(
        id: '11',
        title: 'What is 3 + 3 ?',
        options: {'5': false, '6': true, '4': false, '10': false},
      ),
      Question(
        id: '12',
        title: 'What is 4 + 4 ?',
        options: {'5': false, '30': false, '4': false, '8': true},
      ),
    ];
  }

  void checkAnswerAndUpdate(bool value) {
    if (!isAnswered) {
      setState(() {
        isAnswered = true;
        if (value == true) {
          score++;
        }
      });
    }
  }

  void nextQuestion() {
    setState(() {
      if (index == _questions.length - 1) {
        showDialog(
          context: context,
          builder: (ctx) => ResultBox(
            result: score,
            questionLength: _questions.length,
            onPressed: startOver,
          ),
        );
      } else {
        index++;
        isAnswered = false;
      }
    });
  }

  //creating a function to start over
  void startOver() {
    setState(() {
      index = 0;
      score = 0;
      isPressed = false;
      isAlreadySelected = false;
    });
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        title: Text('Quiz App'),
        backgroundColor: background,
        shadowColor: Colors.transparent,
        actions: [
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Text(
              'Score: $score',
              style: const TextStyle(fontSize: 18.0),
            ),
          ),
        ],
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          children: [
            QuestionWidget(
              indexAction: index,
              question: _questions[index].title,
              totalQuestions: _questions.length,
              style: const TextStyle(
                fontSize: 24.0,
                color: neutral,
              ),
            ),
            const Divider(color: neutral),
            const SizedBox(height: 25.0),
            for (int i = 0; i < _questions[index].options.length; i++)
              GestureDetector(
                onTap: () => checkAnswerAndUpdate(
                    _questions[index].options.values.toList()[i]),
                child: OptionCard(
                  option: _questions[index].options.keys.toList()[i],
                  color: isAnswered
                      ? _questions[index].options.values.toList()[i] == true
                          ? correct
                          : incorrect
                      : neutral,
                ),
              ),
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: NextButton(
          nextQuestion: nextQuestion,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
