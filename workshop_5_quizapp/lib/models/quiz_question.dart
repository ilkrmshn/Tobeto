class QuizQuestion {
  final String question;
  final List<String> answers;
  final String correct;
  String yourAnswer;
  QuizQuestion(this.question, this.answers, this.correct, this.yourAnswer);
}

class Question {
  final String questionText;
  final List<String> answers;
  final String correct;
  String yourAnswer;

  Question(this.questionText, this.answers, this.correct, this.yourAnswer);
}
