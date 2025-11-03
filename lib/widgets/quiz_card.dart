import 'package:flutter/material.dart';

class QuizCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final String subtitle;
  final VoidCallback? onTap;

  const QuizCard({
    super.key,
    required this.imagePath,
    required this.title,
    required this.subtitle,
    this.onTap, 
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: onTap, 
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.05,
          vertical: screenHeight * 0.02,
        ),
        decoration: BoxDecoration(
          color: const Color(0xFF001833),
          borderRadius: BorderRadius.circular(screenWidth * 0.04),
        ),
        child: Row(
          children: [
            Image.asset(
              imagePath,
              width: screenWidth * 0.12,
              height: screenWidth * 0.12,
              fit: BoxFit.contain,
            ),
            SizedBox(width: screenWidth * 0.04),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontFamily: 'Rubik',
                      fontWeight: FontWeight.w700,
                      fontSize: screenWidth * 0.045,
                      color: const Color(0xFFF0ECE6),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.004),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontFamily: 'Rubik',
                      fontWeight: FontWeight.w400,
                      fontSize: screenWidth * 0.035,
                      color: const Color(0xFFB9B9B9),
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios_rounded,
              color: const Color(0xFFF0ECE6),
              size: screenWidth * 0.05,
            ),
          ],
        ),
      ),
    );
  }
}
