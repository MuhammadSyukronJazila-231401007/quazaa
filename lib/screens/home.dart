import 'package:flutter/material.dart';
import '../widgets/quiz_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.06,
          vertical: screenHeight * 0.065,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header QUAZAA
            Center(
              child: Text(
                'QUAZAA',
                style: TextStyle(
                  fontFamily: 'Doggybag',
                  fontSize: screenWidth * 0.1,
                  color: const Color(0xFF001833),
                ),
              ),
            ),

            SizedBox(height: screenHeight * 0.04),

            // Card Halo User
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.06,
                vertical: screenHeight * 0.025,
              ),
              decoration: BoxDecoration(
                color: const Color(0xFF001833),
                borderRadius: BorderRadius.circular(screenWidth * 0.05),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Halo,",
                        style: TextStyle(
                          fontFamily: 'Rubik',
                          fontWeight: FontWeight.w400,
                          fontSize: screenWidth * 0.045,
                          color: const Color(0xFFF0ECE6),
                        ),
                      ),
                      Text(
                        "Ahmad Subardjo!",
                        style: TextStyle(
                          fontFamily: 'Rubik',
                          fontWeight: FontWeight.w700,
                          fontSize: screenWidth * 0.05,
                          color: const Color(0xFFF0ECE6),
                        ),
                      ),
                    ],
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image.asset(
                      'assets/images/avatar1.png',
                      width: screenWidth * 0.15,
                      height: screenWidth * 0.15,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: screenHeight * 0.05),

            // Judul Section
            Text(
              "Quizzes",
              style: TextStyle(
                fontFamily: 'Rubik',
                fontWeight: FontWeight.w700,
                fontSize: screenWidth * 0.05,
                color: const Color(0xFF001833),
              ),
            ),

            SizedBox(height: screenHeight * 0.02),

            // Daftar Quiz (pakai widget reusable)
            QuizCard(
              imagePath: 'assets/images/html.png',
              title: 'HTML Crash Quiz',
              subtitle: 'Technology · 20 Questions',
            ),
            SizedBox(height: screenHeight * 0.02),
            QuizCard(
              imagePath: 'assets/images/flutter.png',
              title: 'Flutter Quiz',
              subtitle: 'Technology · 15 Questions',
            ),
          ],
        ),
      ),
    );
  }
}
