import 'package:flutter/material.dart';

class Signin extends StatefulWidget {
  const Signin({super.key});

  @override
  State<Signin> createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  final TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFF001833), // biru tua
      resizeToAvoidBottomInset: false,
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isLargeScreen = constraints.maxWidth > 600;
          screenWidth = constraints.maxWidth;

          return Center(
            child: Padding(
              padding: EdgeInsets.all(screenWidth * 0.07),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Gambar tanda tanya (PNG)
                  Container(
                    width: screenWidth,
                    height: screenHeight * 0.3,
                    alignment: Alignment.center,
                    child: Image.asset(
                      'assets/images/tanda_tanya.png',
                      fit: BoxFit.contain, 
                    ),
                  ),


                  SizedBox(height: screenHeight * 0.06),

                  // Card putih untuk input
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.06,
                      vertical: screenHeight * 0.04,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF0ECE6),
                      borderRadius: BorderRadius.circular(screenWidth * 0.07),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Judul
                        Text(
                          "Hello Strangers,\nWhat's your name?",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Rubik',
                            fontWeight: FontWeight.w700,
                            fontSize:
                                screenWidth * (isLargeScreen ? 0.045 : 0.065),
                            color: const Color(0xFF001833),
                          ),
                        ),

                        SizedBox(height: screenHeight * 0.03),

                        // Input nama
                        TextField(
                          controller: nameController,
                          decoration: InputDecoration(
                            hintText: 'name',
                            hintStyle: TextStyle(
                              fontFamily: 'Rubik',
                              fontWeight: FontWeight.w400,
                              fontSize: screenWidth * 0.04,
                              color: const Color(0xFFB9B9B9),
                            ),
                            filled: true,
                            fillColor: const Color(0xFFE0DEDA),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                  screenWidth * 0.1), // sudut membulat
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: EdgeInsets.symmetric(
                              vertical: screenHeight * 0.015,
                              horizontal: screenWidth * 0.05,
                            ),
                          ),
                          style: TextStyle(
                            fontFamily: 'Rubik',
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFF001833),
                            fontSize: screenWidth * 0.04,
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: screenHeight * 0.05),

                  // Tombol Next 
                  SizedBox(
                    width: screenWidth * 0.7, // lebar tombol 70% dari layar
                    height: screenHeight * 0.07, // tinggi tombol 7% dari layar
                    child: TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: const Color(0xFF30304D), // background gelap
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12), // corner radius sedang
                        ),
                      ),
                      onPressed: () {
                        // Navigasi ke halaman berikutnya
                        debugPrint('Nama: ${nameController.text}');
                      },
                      child: Text(
                        'Next', // teks tombol
                        style: TextStyle(
                          fontFamily: 'Rubik',
                          fontWeight: FontWeight.w600, // SemiBold
                          color: Colors.white,
                          fontSize:  screenWidth * (isLargeScreen ? 0.038 : 0.055),
                        ),
                      ),
                    ),
                  ),

                 
                 ],
              ),
            ),
          );
        },
      ),
    );
  }
}
