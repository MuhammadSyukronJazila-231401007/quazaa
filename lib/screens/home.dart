import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';
import '../widgets/quiz_card.dart';
import 'package:go_router/go_router.dart';
import '../data/quiz_data.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context); 
    final quizzes = QuizData.allQuizzes;

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
                  // Bagian kiri: teks Halo + nama user
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
                        userProvider.username.isNotEmpty
                            ? userProvider.username
                            : 'Guest',
                        style: TextStyle(
                          fontFamily: 'Rubik',
                          fontWeight: FontWeight.w700,
                          fontSize: screenWidth * 0.05,
                          color: const Color(0xFFF0ECE6),
                        ),
                      ),
                    ],
                  ),

                  // Bagian kanan: avatar + tombol logout
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image.asset(
                          userProvider.avatarPath.isNotEmpty
                              ? userProvider.avatarPath
                              : 'assets/images/avatar1.png',
                          width: screenWidth * 0.15,
                          height: screenWidth * 0.15,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(width: screenWidth * 0.03),

                      // Tombol logout
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.redAccent,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.redAccent.withOpacity(0.4),
                              blurRadius: 6,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.logout, color: Colors.white, size: 22),
                          onPressed: () async {
                            await userProvider.logout();
                            if (context.mounted) context.go('/signin');
                          },
                          tooltip: 'Logout',
                        ),
                      ),
                    ],
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

            Expanded(
              child: ListView.separated(
                itemCount: quizzes.length,
                separatorBuilder: (_, __) =>
                    SizedBox(height: screenHeight * 0.02),
                itemBuilder: (context, index) {
                  final quizName = quizzes.keys.elementAt(index);
                  final isCompleted = userProvider.completedQuizzes.contains(quizName);
                  final data = quizzes[quizName]!;
                  final totalToPlay = data['questionCount'] as int;
                  final subtitle =
                      '${data['category']} · $totalToPlay Questions';

                  return QuizCard(
                    imagePath: data['imagePath'],
                    title: quizName,
                    subtitle: subtitle,
                    isCompleted: isCompleted, 
                    onTap: () {
                      if (!isCompleted) {
                        context.push(
                          '/quiz?name=${Uri.encodeComponent(quizName)}&count=$totalToPlay',
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Kuis "$quizName" sudah diselesaikan!'),
                            duration: const Duration(seconds: 1),
                          ),
                        );
                      }
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
