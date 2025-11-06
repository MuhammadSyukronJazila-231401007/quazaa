import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';
import 'package:quazaa/widgets/custom_button.dart';

class Signin extends StatefulWidget {
  const Signin({super.key});

  @override
  State<Signin> createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  final TextEditingController nameController = TextEditingController();

  void _handleNext() async {
    final name = nameController.text.trim();

    if (name.isEmpty) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: const Color(0xFFF0ECE6),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          title: const Text(
            'Name Required',
            style: TextStyle(
              fontFamily: 'Rubik',
              fontWeight: FontWeight.w700,
              color: Color(0xFF001833),
            ),
          ),
          content: const Text(
            'Please enter your name before continuing.',
            style: TextStyle(
              fontFamily: 'Rubik',
              color: Color(0xFF001833),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                'OK',
                style: TextStyle(
                  color: Color(0xFF001833),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      );
      return;
    }

    final prefs = await SharedPreferences.getInstance();
    final existingName = prefs.getString('username');

    final userProvider = Provider.of<UserProvider>(context, listen: false);

    if (existingName != null && existingName == name) {
      // Jika user sudah ada, load data lamanya
      await userProvider.loadFromPrefs();
    } else {
      // Jika user baru, set data baru
      await userProvider.setUser(name);
    }

    if (context.mounted) context.goNamed('home');
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFF001833),
      resizeToAvoidBottomInset: false,
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isLargeScreen = constraints.maxWidth > 600;
          screenWidth = constraints.maxWidth;

          return Center(
            child: Padding(
              padding: EdgeInsets.all(screenWidth * 0.07),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: screenHeight * 0.02),
                    width: screenWidth,
                    height: screenHeight * 0.25,
                    alignment: Alignment.center,
                    child: Image.asset(
                      'assets/images/tanda_tanya.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.04),
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
                              borderRadius:
                                  BorderRadius.circular(screenWidth * 0.1),
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
                  SizedBox(height: screenHeight * 0.09),
                  CustomButton(
                    text: 'Next',
                    onPressed: _handleNext,
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
