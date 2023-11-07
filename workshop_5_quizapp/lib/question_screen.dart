import 'package:flutter/material.dart';
import 'package:workshop_5_quizapp/data/quesitons.dart';
import 'package:workshop_5_quizapp/result_screen.dart';

class QuestionScreen extends StatefulWidget {
  const QuestionScreen({Key? key}) : super(key: key);

  @override
  _QuestionScreenState createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  int i = 0;
  int dogruCevap = 0, yanlisCevap = 0;

  void changeQuestion() {
    if (i < questions.length - 1) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Sending Message"),
      ));
      setState(() {
        i++;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(questions[i].questionText,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                  )),
            ),
            ...questions[i].answers.map((answer) {
              return ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.green,
                  shadowColor: Colors.greenAccent,
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32.0)),
                  minimumSize: const Size(150, 40), //////// HERE
                ),
                onPressed: () {
                  questions[i].yourAnswer = answer;
                  if (answer == questions[i].correct) {
                    dogruCevap++;
                  } else {
                    yanlisCevap++;
                  }

                  setState(() {
                    if (i == questions.length - 1) {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ResultScreen(
                                questions: questions,
                                dCevap: dogruCevap,
                                yCevap: yanlisCevap),
                          ));
                    } else {
                      i++;
                    }
                  });
                },
                child: Text(
                  answer,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
