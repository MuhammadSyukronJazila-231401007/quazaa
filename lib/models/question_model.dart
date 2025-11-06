class Question {
  final String question;
  final List<String> options;
  final int correctAnswerIndex;
  final String? image;

  Question({
    required this.question,
    required this.options,
    required this.correctAnswerIndex,
    this.image,
  });

  factory Question.fromJson(Map<String, dynamic> json) => Question(
    question: json['question'] as String,
    options: List<String>.from(json['options'] as List),
    correctAnswerIndex: json['correctAnswerIndex'] as int,
    image: json['image'] as String?,
  );
}
