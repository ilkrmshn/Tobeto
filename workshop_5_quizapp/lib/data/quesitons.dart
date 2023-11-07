import 'package:workshop_5_quizapp/models/quiz_question.dart';

List<Question> questions = [
  Question("Aşağıdakilerden hangisi flutterda state'i update eder?",
      ["setState", "constructor", "class", "statelesswidget"], "setState", ""),
  Question("Aşağıdakilerden hangisi 3*15 'e eşittir?", ["45", "24", "25", "60"],
      "45", ""),
  Question("Aşağıdakilerden hangisi 45/0 'a eşittir?",
      ["45", "0", "1", "Tanımsız"], "Tanımsız", ""),
  Question("Aşağıdakilerden hangisi 24+21 'e eşittir?",
      ["60", "45", "30", "55"], "45", ""),
  Question("Aşağıdakilerden hangisi 54-14 'e eşittir?",
      ["10", "68", "30", "40"], "40", ""),
];
