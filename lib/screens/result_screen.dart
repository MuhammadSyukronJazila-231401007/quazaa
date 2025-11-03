import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/quiz_result_provider.dart';
import '../widgets/custom_button.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final resultProvider = Provider.of<QuizResultProvider>(context);
    final correct = resultProvider.correctAnswers;
    final total = resultProvider.totalQuestions;
    final ratio = resultProvider.scoreRatio;

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Hitung jumlah bintang aktif (setiap 1/3 dari total skor)
    int activeStars = (ratio * 3).floor();

    return Scaffold(
      backgroundColor: const Color(0xFFF0ECE6),
      body: SafeArea(
        child: Stack(
          children: [
            // Konten utama
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: screenHeight * 0.05),

                  // Judul
                  Text(
                    'QUAZAA Result',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Doggybag',
                      fontWeight: FontWeight.w700,
                      fontSize: screenWidth * 0.08,
                      color: const Color(0xFF001833),
                    ),
                  ),

                  SizedBox(height: screenHeight * 0.12),

                  // "Nice Work"
                  Text(
                    'Nice Work',
                    style: TextStyle(
                      fontFamily: 'Rubik',
                      fontWeight: FontWeight.w700,
                      fontSize: screenWidth * 0.08,
                      color: const Color(0xFF001833),
                    ),
                  ),

                  SizedBox(height: screenHeight * 0.04),

                  // Lingkaran skor
                  Container(
                    width: screenWidth * 0.3,
                    height: screenWidth * 0.3,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFF001833),
                    ),
                    child: Center(
                      child: Text(
                        '$correct/$total',
                        style: TextStyle(
                          fontFamily: 'Rubik',
                          fontWeight: FontWeight.w700,
                          fontSize: screenWidth * 0.08,
                          color: const Color(0xFFF0ECE6),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: screenHeight * 0.04),

                  // Bintang
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(3, (index) {
                      bool isActive = index < activeStars;
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.015),
                        child: Icon(
                          Icons.star,
                          size: screenWidth * 0.15,
                          color: isActive
                              ? Colors.yellow.shade600
                              : const Color(0xFF001833),
                        ),
                      );
                    }),
                  ),

                  SizedBox(height: screenHeight * 0.05),

                  // Teks hasil
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: 'You scored ',
                      style: TextStyle(
                        fontFamily: 'Rubik',
                        fontWeight: FontWeight.w400,
                        fontSize: screenWidth * 0.055,
                        color: const Color(0xFF001833),
                      ),
                      children: [
                        TextSpan(
                          text: '$correct out of $total! ',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF001833),
                          ),
                        ),
                        const TextSpan(text: '\nKeep it Up!'),
                      ],
                    ),
                  ),
                  const Spacer(),

                  // Tombol ke home
                  Padding(
                    padding: EdgeInsets.only(bottom: screenHeight * 0.05),
                    child: CustomButton(
                      text: 'Go To Home',
                      onPressed: () {
                        resultProvider.reset();
                        Navigator.of(context)
                            .popUntil((route) => route.isFirst);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
