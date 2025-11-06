import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:quazaa/providers/quiz_result_provider.dart';
import 'package:quazaa/providers/user_provider.dart';
import 'package:quazaa/widgets/custom_button.dart';
import '../data/quiz_data.dart';
import '../models/question_model.dart';

class QuizScreen extends StatefulWidget {
  final String quizName;
  final int totalQuestions;

  const QuizScreen({
    super.key,
    required this.quizName,
    required this.totalQuestions,
  });

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  late List<Question> questions;
  int currentIndex = 0;
  int? selectedIndex;
  int correctAnswers = 0;

  bool isAnswered = false;
  bool answerIsCorrect = false;
  Timer? _advanceTimer;
  bool _isAdvancing = false;

  @override
  void initState() {
    super.initState();
    questions = QuizData.getRandomQuestions(widget.quizName);
  }

  @override
  void dispose() {
    _advanceTimer?.cancel();
    super.dispose();
  }

  void _onOptionTap(int index) {
    if (isAnswered || _isAdvancing) return;
    setState(() => selectedIndex = index);
  }

  void nextQuestion() {
    final q = questions[currentIndex];

    if (selectedIndex == null && !isAnswered) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: const Color(0xFFF0ECE6),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: const Text(
            'Pilih Jawaban Dulu!',
            style: TextStyle(
              fontFamily: 'Rubik',
              fontWeight: FontWeight.w700,
              color: Color(0xFF001833),
            ),
          ),
          content: const Text(
            'Kamu harus memilih salah satu jawaban sebelum lanjut ke soal berikutnya.',
            style: TextStyle(
              fontFamily: 'Rubik',
              fontWeight: FontWeight.w400,
              color: Color(0xFF001833),
            ),
          ),
          actions: [
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: const Color(0xFF001833),
                foregroundColor: Color(0xFFF0ECE6),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
      return;
    }

    if (!isAnswered) {
      setState(() {
        isAnswered = true;
        answerIsCorrect = (selectedIndex == q.correctAnswerIndex);
        if (answerIsCorrect) correctAnswers++;
      });

      _advanceTimer?.cancel();
      _advanceTimer = Timer(const Duration(milliseconds: 1200), () {
        if (!mounted) return;
        _advanceToNext();
      });
    } else {
      _advanceTimer?.cancel();
      _advanceToNext();
    }
  }

  void _advanceToNext() {
  if (_isAdvancing) return;
  _isAdvancing = true;

  if (currentIndex < questions.length - 1) {
    setState(() {
      currentIndex++;
      selectedIndex = null;
      isAnswered = false;
      answerIsCorrect = false;
    });
    Future.delayed(const Duration(milliseconds: 120), () {
      _isAdvancing = false;
    });
  } else {
    final resultProvider = Provider.of<QuizResultProvider>(context, listen: false);
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    resultProvider.setResult(correctAnswers, widget.totalQuestions);

    // Tambah poin & tandai quiz selesai
    userProvider.addPoints(correctAnswers);
    userProvider.markQuizComplete(widget.quizName);

    // Navigasi ke halaman result
    context.goNamed("result");
  }

}


  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final q = questions[currentIndex];
    final progress = (currentIndex + 1) / widget.totalQuestions;

    Color optionColor(int index) {
      if (isAnswered) {
        if (index == q.correctAnswerIndex) return const Color(0xFFBFF3C8);
        if (selectedIndex == index && selectedIndex != q.correctAnswerIndex) {
          return const Color(0xFFF7C6C6);
        }
        return Colors.white;
      } else {
        return (selectedIndex == index)
            ? const Color(0xFFBFC3C8)
            : Colors.white;
      }
    }

    Widget? optionTrailing(int index) {
      if (!isAnswered) return null;
      if (index == q.correctAnswerIndex) {
        return const Icon(Icons.check_circle, color: Colors.green);
      }
      if (selectedIndex == index && selectedIndex != q.correctAnswerIndex) {
        return const Icon(Icons.cancel, color: Colors.red);
      }
      return null;
    }

    return WillPopScope(
      onWillPop: () async {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Kuis belum selesai, tidak bisa kembali!'),
            duration: Duration(milliseconds: 900),
          ),
        );
        return false;
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFF0ECE6),
        body: SafeArea(
          child: SingleChildScrollView( // ⬅️ semua bisa di-scroll
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.08),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: screenHeight * 0.065),

                  // Nomor Kuis
                  Text(
                    'Question ${currentIndex + 1}',
                    style: TextStyle(
                      fontFamily: 'Doggybag',
                      fontWeight: FontWeight.w700,
                      fontSize: screenWidth * 0.06,
                      color: const Color(0xFF001833),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.035),

                  // Progress Bar
                  ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: TweenAnimationBuilder<double>(
                      tween: Tween<double>(begin: 0, end: progress),
                      duration: const Duration(milliseconds: 600),
                      curve: Curves.easeInOut,
                      builder: (context, value, _) => LinearProgressIndicator(
                        value: value,
                        backgroundColor: Colors.white,
                        color: const Color(0xFF001833),
                        minHeight: 10,
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.04),

                  // Pertanyaan
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(screenWidth * 0.055),
                    decoration: BoxDecoration(
                      color: const Color(0xFF001833),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      children: [
                        if (q.image != null && q.image!.isNotEmpty) ...[
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.asset(
                              q.image!,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.025),
                        ],

                        Text(
                          q.question,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Rubik',
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                            fontSize: screenWidth * 0.045,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.04),

                  // Opsi Jawaban
                  Column(
                    children: List.generate(q.options.length, (index) {
                      final bg = optionColor(index);
                      final trailing = optionTrailing(index);

                      return Padding(
                        padding: EdgeInsets.only(bottom: screenHeight * 0.02),
                        child: GestureDetector(
                          onTap: () => _onOptionTap(index),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(
                              vertical: screenHeight * 0.02,
                            ),
                            decoration: BoxDecoration(
                              color: bg,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 3,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Center(
                                    child: Text(
                                      q.options[index],
                                      style: TextStyle(
                                        fontFamily: 'Rubik',
                                        fontWeight: FontWeight.w400,
                                        fontSize: screenWidth * 0.04,
                                        color: const Color(0xFF001833),
                                      ),
                                    ),
                                  ),
                                ),
                                if (trailing != null)
                                  Padding(
                                    padding: EdgeInsets.only(
                                        right: screenWidth * 0.03),
                                    child: trailing,
                                  ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
                  ),

                   Visibility(
                    visible: isAnswered,
                    maintainSize: true,
                    maintainAnimation: true,
                    maintainState: true,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: screenHeight * 0.02),
                      child: Text(
                        answerIsCorrect ? 'Jawaban benar!' : 'Jawaban salah!',
                        style: TextStyle(
                          fontFamily: 'Rubik',
                          fontWeight: FontWeight.w600,
                          fontSize: screenWidth * 0.045,
                          color: answerIsCorrect
                              ? Colors.green[700]
                              : Colors.red[700],
                        ),
                      ),
                    ),
                  ),

                  CustomButton(
                    text: (currentIndex == questions.length - 1)
                        ? 'Finish'
                        : 'Next',
                    onPressed: nextQuestion,
                  ),
                  SizedBox(height: screenHeight * 0.07),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
