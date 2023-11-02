class QuizQuestion {
  const QuizQuestion(this.question, this.answers, this.correct);
  final String question;
  final List<String> answers;
  final String correct;
}

class Question {
  final String questionText;
  final String answer;
  final String correct;

  Question(this.questionText, this.answer, this.correct);
}
