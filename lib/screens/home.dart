import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../widgets/quiz_card.dart';
import '../data/quiz_data.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final quizzes = QuizData.allQuizzes;
    final screenWidth = MediaQuery.of(context).size.width;
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

            Expanded(
              child: ListView.separated(
                itemCount: quizzes.length,
                separatorBuilder: (_, __) =>
                    SizedBox(height: screenHeight * 0.02),
                itemBuilder: (context, index) {
                  final quizName = quizzes.keys.elementAt(index);
                  final data = quizzes[quizName]!;
                  final totalToPlay = data['questionCount'] as int;
                  final subtitle =
                      '${data['category']} · $totalToPlay Questions';

                  return QuizCard(
                    imagePath: data['imagePath'],
                    title: quizName,
                    subtitle: subtitle,
                    onTap: () {
                      context.push(
                        '/quiz?name=${Uri.encodeComponent(quizName)}&count=$totalToPlay',
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
