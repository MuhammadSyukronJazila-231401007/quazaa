import 'dart:math';
import '../models/question_model.dart';

class QuizData {
  static final Map<String, List<Map<String, dynamic>>> _allQuestions = {
    'HTML Crash Quiz': [
      {
        'question': 'Apa singkatan dari HTML?',
        'options': [
          'HyperText Markup Language',
          'Hyper Tool Markup Language',
          'Home Tool Markup Language',
          'Hyper Transfer Markup Language'
        ],
        'correctAnswerIndex': 0
      },
      {
        'question': 'Tag untuk membuat link adalah?',
        'options': ['<link>', '<a>', '<href>', '<url>'],
        'correctAnswerIndex': 1
      },
      {
        'question': 'HTML pertama kali dirilis tahun?',
        'options': ['1990', '1991', '1995', '2000'],
        'correctAnswerIndex': 1
      },
      // Tambahkan hingga 50 soal (dummy)
    ],
    'Flutter Quiz': [
      {
        'question': 'Siapa yang mengembangkan Flutter?',
        'options': ['Facebook', 'Google', 'Amazon', 'USU'],
        'correctAnswerIndex': 1
      },
      {
        'question': 'Bahasa utama yang digunakan Flutter?',
        'options': ['Kotlin', 'Swift', 'Dart', 'Python'],
        'correctAnswerIndex': 2
      },
      {
        'question': 'Widget digunakan untuk?',
        'options': ['Membuat UI', 'Menyimpan Data', 'Menjalankan Server'],
        'correctAnswerIndex': 0
      },
      // Tambahkan hingga 30 soal (dummy)
    ],
    // Tambah materi lain misal CSS, JavaScript, dsb.
  };

  static List<Question> getRandomQuestions(String quizName, int count) {
    final questions = _allQuestions[quizName]!;
    questions.shuffle(Random());
    return questions.take(count).map((q) => Question.fromJson(q)).toList();
  }
}
