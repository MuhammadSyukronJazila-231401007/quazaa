import 'dart:math';
import '../models/question_model.dart';

class QuizData {
  // Data kuis
  static final Map<String, Map<String, dynamic>> _quizzes = {
    'HTML Crash Quiz': {
      'imagePath': 'assets/images/html.png',
      'category': 'Technology',
      'questionCount': 10, // jumlah soal per sesi quiz
      'questions': [
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
        // tambahkan sampai 30 soal kalau mau
      ],
    },
    'Flutter Quiz': {
      'imagePath': 'assets/images/flutter.png',
      'category': 'Technology',
      'questionCount': 15, // jumlah soal per sesi quiz
      'questions': [
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
      ],
    },
  };

  // Akses daftar semua kuis
  static Map<String, Map<String, dynamic>> get allQuizzes => _quizzes;

  // Ambil soal acak sejumlah 'questionCount'
  static List<Question> getRandomQuestions(String quizName) {
    final quiz = _quizzes[quizName]!;
    final count = quiz['questionCount'] as int;
    final questions = List<Map<String, dynamic>>.from(quiz['questions']);

    questions.shuffle(Random());
    return questions.take(count).map((q) => Question.fromJson(q)).toList();
  }
}
