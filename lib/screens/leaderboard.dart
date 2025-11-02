import 'package:flutter/material.dart';
import '../widgets/leaderboard_item.dart';

class LeaderboardScreen extends StatelessWidget {
  const LeaderboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    // Data dummy sementara
    final List<Map<String, dynamic>> leaderboardData = [
      {
        'rank': 1,
        'name': 'Ahmad Subardjo',
        'points': 35,
        'avatar': 'assets/images/avatar1.png',
      },
      {
        'rank': 2,
        'name': 'Alena Donin',
        'points': 33,
        'avatar': 'assets/images/avatar2.png',
      },
      {
        'rank': 3,
        'name': 'Craig Gouse',
        'points': 30,
        'avatar': 'assets/images/avatar3.png',
      },
      {
        'rank': 4,
        'name': 'Madelyn Dias',
        'points': 28,
        'avatar': 'assets/images/avatar4.png',
      },
      {
        'rank': 5,
        'name': 'Zain Vaccaro',
        'points': 20,
        'avatar': 'assets/images/avatar5.png',
      },
      // {
      //   'rank': 6,
      //   'name': 'Zain Vaccaro',
      //   'points': 20,
      //   'avatar': 'assets/images/avatar5.png',
      // },
      // {
      //   'rank': 7,
      //   'name': 'Zain Vaccaro',
      //   'points': 20,
      //   'avatar': 'assets/images/avatar5.png',
      // },
      // {
      //   'rank': 8,
      //   'name': 'Zain Vaccaro',
      //   'points': 20,
      //   'avatar': 'assets/images/avatar5.png',
      // },
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF0ECE6),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsetsGeometry.directional(start: screenWidth * 0.08, end: screenWidth * 0.08, top: screenWidth * 0.07),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Judul halaman
              Text(
                'QUAZAA',
                style: TextStyle(
                  fontFamily: 'Doggybag',
                  fontSize: screenWidth * 0.08,
                  color: const Color(0xFF001833),
                ),
              ),
              Text(
                'Leaderboard',
                style: TextStyle(
                  fontFamily: 'Doggybag',
                  fontSize: screenWidth * 0.08,
                  color: const Color(0xFF001833),
                ),
              ),
              SizedBox(height: screenHeight * 0.04),

              // Daftar leaderboard
              Expanded(
                child: ListView.builder(
                  itemCount: leaderboardData.length,
                  itemBuilder: (context, index) {
                    final user = leaderboardData[index];
                    return LeaderboardItem(
                      rank: user['rank'],
                      name: user['name'],
                      points: user['points'],
                      avatarPath: user['avatar'],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
