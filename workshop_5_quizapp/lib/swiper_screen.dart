import 'package:flutter/material.dart';
import 'package:workshop_5_quizapp/question_screen.dart';
import 'package:workshop_5_quizapp/start_screen.dart';

class SwiperScreen extends StatefulWidget {
  const SwiperScreen({Key? key}) : super(key: key);

  @override
  _SwiperScreenState createState() => _SwiperScreenState();
}

class _SwiperScreenState extends State<SwiperScreen> {
  var _activeScreenName = "start-screen";

  void changeScreen() {
    setState(() {
      _activeScreenName = "quiz-screen";
    });
  }

  // Callback functionlar
  // Sorular bittiğinde resultscreen açılmalıdır. Cevaplanan sorular listelenmelidir
  // (Liste widgetları)

  // ResultScreen oluşturulması
  // QuestionScreen'den soruların bittiğine dair callback alınması
  // ResultScreen'in gösterilmesi
  // EKSTRA : Verilen cevaplar hafızada tutulup şu soruya şu cevap verdiniz şeklinde ResultScreen'de listelenmesi
  @override
  Widget build(BuildContext context) {
    Widget activeScreen = StartScreen(changeScreen);

    if (_activeScreenName == "quiz-screen") {
      activeScreen = QuestionScreen();
    }

    return Container(child: activeScreen);
  }
}
