import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quazaa/providers/quiz_result_provider.dart';
import 'package:quazaa/screens/result_screen.dart';
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

  @override
  void initState() {
    super.initState();
    questions = QuizData.getRandomQuestions(widget.quizName);
  }

  void nextQuestion() {
    final q = questions[currentIndex];

    if (selectedIndex == null) {
      // Peringatan kalau belum pilih jawaban
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: const Color(0xFFF0ECE6),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: Text(
            'Pilih Jawaban Dulu!',
            style: TextStyle(
              fontFamily: 'Rubik',
              fontWeight: FontWeight.w700,
              fontSize: MediaQuery.of(context).size.width * 0.045,
              color: const Color(0xFF001833),
            ),
          ),
          content: Text(
            'Kamu harus memilih salah satu jawaban sebelum lanjut ke soal berikutnya.',
            style: TextStyle(
              fontFamily: 'Rubik',
              fontWeight: FontWeight.w400,
              fontSize: MediaQuery.of(context).size.width * 0.04,
              color: const Color(0xFF001833),
            ),
          ),
          actions: [
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: const Color(0xFF001833),
                foregroundColor: const Color(0xFFF0ECE6),
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

    // Cek apakah jawaban benar
    if (selectedIndex == q.correctAnswerIndex) {
      correctAnswers++;
    }

    // Pindah ke pertanyaan berikut
    if (currentIndex < questions.length - 1) {
      setState(() {
        currentIndex++;
        selectedIndex = null;
      });
    } else {
      // Kuis selesai — kirim hasil ke Provider & pindah ke halaman Result
      final resultProvider = Provider.of<QuizResultProvider>(context, listen: false);
      resultProvider.setResult(correctAnswers, widget.totalQuestions);

      // Navigator.pushReplacementNamed(context, '/result');
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const ResultScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final q = questions[currentIndex];
    final progress = (currentIndex + 1) / widget.totalQuestions;

    return PopScope(
      canPop: false, // cegah pengguna kembali
      onPopInvoked: (didPop) {
        if (didPop) return;
        // tampilkan pesan kalau belum siap kuis tapi back
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Kuis belum selesai, tidak bisa kembali!'),
            duration: Duration(seconds: 2),
          ),
        );
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFF0ECE6),
        body: SafeArea(
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

                // Progress Bar dengan border radius
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
                  padding: EdgeInsets.all(screenWidth * 0.08),
                  decoration: BoxDecoration(
                    color: const Color(0xFF001833),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    q.question,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Rubik',
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                      fontSize: screenWidth * 0.045,
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.04),

                // Opsi Jawaban
                ...List.generate(q.options.length, (index) {
                  final isSelected = selectedIndex == index;
                  return Padding(
                    padding: EdgeInsets.only(bottom: screenHeight * 0.02),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedIndex = index;
                        });
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(
                          vertical: screenHeight * 0.02,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? const Color(0xFFBFC3C8)
                              : Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 3,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
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
                    ),
                  );
                }),

                const Spacer(),

                // Tombol Next pakai CustomButton
                CustomButton(
                  text: 'Next',
                  onPressed: nextQuestion,
                ),

                SizedBox(height: screenHeight * 0.07),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
