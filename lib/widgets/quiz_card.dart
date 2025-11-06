import 'package:flutter/material.dart';

class QuizCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final String subtitle;
  final VoidCallback? onTap;
  final bool isCompleted;

  const QuizCard({
    super.key,
    required this.imagePath,
    required this.title,
    required this.subtitle,
    required this.onTap,
    this.isCompleted = false,
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.05,
          vertical: screenHeight * 0.02,
        ),
        decoration: BoxDecoration(
          color: isCompleted
              ? const Color(0xFF28415C) 
              : const Color(0xFF001833),
          borderRadius: BorderRadius.circular(screenWidth * 0.04),
          border: isCompleted
              ? Border.all(color: const Color(0xFF4CAF50), width: 2)
              : null,
        ),
        child: Row(
          children: [
            Stack(
              children: [
                Image.asset(
                  imagePath,
                  width: screenWidth * 0.12,
                  height: screenWidth * 0.12,
                  fit: BoxFit.contain,
                ),
                if (isCompleted)
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Icon(
                      Icons.check_circle,
                      color: const Color(0xFF4CAF50),
                      size: screenWidth * 0.05,
                    ),
                  ),
              ],
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
            if (isCompleted)
              Container(
                padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.025,
                    vertical: screenHeight * 0.004),
                decoration: BoxDecoration(
                  color: const Color(0xFF4CAF50),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  "Done",
                  style: TextStyle(
                    fontFamily: 'Rubik',
                    color: Colors.white,
                    fontSize: screenWidth * 0.03,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              )
            else
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
