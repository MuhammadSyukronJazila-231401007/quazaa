import 'package:flutter/material.dart';

class LeaderboardItem extends StatelessWidget {
  final int rank;
  final String name;
  final int points;
  final String avatarPath;

  const LeaderboardItem({
    super.key,
    required this.rank,
    required this.name,
    required this.points,
    required this.avatarPath,
  });

  // Pilih mahkota berdasarkan ranking
  String? getCrownPath() {
    if (rank == 1) return 'assets/images/gold.png';
    if (rank == 2) return 'assets/images/silver.png';
    if (rank == 3) return 'assets/images/copper.png';
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Container(
      margin: EdgeInsets.only(bottom: screenHeight * 0.02),
      padding: EdgeInsets.symmetric(
        vertical: screenHeight * 0.017,
        horizontal: screenWidth * 0.04,
      ),
     decoration: BoxDecoration(
        color: Colors.white.withAlpha((0.9 * 255).toInt()), // opacity 0.9
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha((0.05 * 255).toInt()), // opacity 0.05
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Rank bulat kecil
         Container(
            width: screenWidth * 0.08,
            height: screenWidth * 0.08,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.grey, // warna border abu-abu
                width: 2,           // tebal border
              ),
            ),
            alignment: Alignment.center,
            child: Text(
              '$rank',
              style: TextStyle(
                fontFamily: 'Rubik',
                fontWeight: FontWeight.w600,
                fontSize: screenWidth * 0.045,
                color: const Color(0xFF001833),
              ),
            ),
          ),
          SizedBox(width: screenWidth * 0.04),

          // Avatar
          CircleAvatar(
            radius: screenWidth * 0.07,
            backgroundImage: AssetImage(avatarPath),
          ),
          SizedBox(width: screenWidth * 0.04),

          // Nama dan poin
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontFamily: 'Rubik',
                    fontWeight: FontWeight.w700,
                    fontSize: screenWidth * 0.045,
                    color: const Color(0xFF001833),
                  ),
                ),
                Text(
                  '$points points',
                  style: TextStyle(
                    fontFamily: 'Rubik',
                    fontWeight: FontWeight.w400,
                    fontSize: screenWidth * 0.035,
                    color: Colors.grey.shade700,
                  ),
                ),
              ],
            ),
          ),

          // Mahkota (hanya rank 1–3)
          if (getCrownPath() != null)
            Image.asset(
              getCrownPath()!,
              width: screenWidth * 0.085,
              height: screenWidth * 0.085,
            ),
        ],
      ),
    );
  }
}
