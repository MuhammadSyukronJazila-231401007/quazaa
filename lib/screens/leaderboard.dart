import 'package:flutter/material.dart';
import '../widgets/leaderboard_item.dart';
import '../providers/user_provider.dart';

class LeaderboardScreen extends StatefulWidget {
  const LeaderboardScreen({super.key});

  @override
  State<LeaderboardScreen> createState() => _LeaderboardScreenState();
}

class _LeaderboardScreenState extends State<LeaderboardScreen> {
  List<Map<String, dynamic>> leaderboardData = [];

  @override
  void initState() {
    super.initState();
    _loadLeaderboard();
  }

  Future<void> _loadLeaderboard() async {
    final users = await UserProvider.getAllUsers();

    final List<Map<String, dynamic>> data = users.values.map<Map<String, dynamic>>((u) {
      return {
        'name': u['username'],
        'points': u['totalPoints'],
        'avatar': u['avatarPath'],
      };
    }).toList();

    // Urutkan dari poin tertinggi
    data.sort((a, b) => b['points'].compareTo(a['points']));

    setState(() {
      leaderboardData = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFFF0ECE6),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.08, vertical: screenWidth * 0.07),
          child: Column(
            children: [
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

              Expanded(
                child: leaderboardData.isEmpty
                    ? const Center(child: Text("Belum ada data leaderboard"))
                    : ListView.builder(
                        itemCount: leaderboardData.length,
                        itemBuilder: (context, index) {
                          final user = leaderboardData[index];
                          return LeaderboardItem(
                            rank: index + 1,
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
