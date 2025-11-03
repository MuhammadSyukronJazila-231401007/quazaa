import 'package:flutter/foundation.dart';

class QuizResultProvider extends ChangeNotifier {
  int _correctAnswers = 0;
  int _totalQuestions = 0;

  int get correctAnswers => _correctAnswers;
  int get totalQuestions => _totalQuestions;

  double get scoreRatio =>
      _totalQuestions == 0 ? 0 : _correctAnswers / _totalQuestions;

  void setResult(int correct, int total) {
    _correctAnswers = correct;
    _totalQuestions = total;
    notifyListeners();
  }

  void reset() {
    _correctAnswers = 0;
    _totalQuestions = 0;
    notifyListeners();
  }
}
