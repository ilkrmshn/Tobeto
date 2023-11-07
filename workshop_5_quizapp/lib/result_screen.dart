import 'package:flutter/material.dart';
import 'package:workshop_5_quizapp/models/quiz_question.dart';
import 'package:workshop_5_quizapp/swiper_screen.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen(
      {required this.questions,
      required this.dCevap,
      required this.yCevap,
      super.key});
  final List<Question> questions;
  final int dCevap;
  final int yCevap;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Result Screen"),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SwiperScreen(),
                    ));
              },
              icon: const Icon(
                Icons.home,
                color: Colors.white,
              ),
            )
          ],
        ),
        body: questions.isNotEmpty
            ? Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Soru Sayısı : ${questions.length}",
                          style: const TextStyle(
                              fontSize: 18,
                              color: Colors.blue,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "Doğru cevap : $dCevap",
                          style: const TextStyle(
                              fontSize: 18,
                              color: Colors.green,
                              fontWeight: FontWeight.bold),
                        ),
                        Text("Yanlış cevap : $yCevap",
                            style: const TextStyle(
                                fontSize: 18,
                                color: Colors.red,
                                fontWeight: FontWeight.bold)),
                        Text("Puanınız : ${100 / questions.length * dCevap}",
                            style: const TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListView.separated(
                        separatorBuilder: (context, index) {
                          return const Divider(
                            thickness: 2,
                            color: Colors.blueAccent,
                          );
                        },
                        itemCount: questions.length,
                        itemBuilder: (context, index) {
                          var question = questions[index];
                          return ListTile(
                            iconColor: question.correct == question.yourAnswer
                                ? Colors.green
                                : Colors.red,
                            title: Text(question.questionText),
                            subtitle: Text(
                                "Doğru cevap: ${question.yourAnswer}. \nCevabınız: ${question.correct}."),
                            leading: question.correct == question.yourAnswer
                                ? const Icon(
                                    Icons.check_circle_outline,
                                  )
                                : const Icon(Icons.cancel_outlined),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              )
            : const Center());
  }
}
