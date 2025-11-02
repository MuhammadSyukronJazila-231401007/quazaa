import 'package:flutter/material.dart';
import '../widgets/custom_button.dart';
import '../widgets/text_input_field.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFFF0ECE6),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.08,
            vertical: screenHeight * 0.05,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Judul
              Text(
                'QUAZAA Settings',
                style: TextStyle(
                  fontFamily: 'Doggybag',
                  fontSize: screenWidth * 0.08,
                  color: const Color(0xFF001833),
                ),
              ),
              SizedBox(height: screenHeight * 0.07),

              // Avatar
              CircleAvatar(
                radius: screenWidth * 0.15,
                backgroundImage: const AssetImage('assets/images/avatar1.png'),
              ),
              SizedBox(height: screenHeight * 0.02),

              // Nama pengguna
              Text(
                'Ahmad Subardjo',
                style: TextStyle(
                  fontFamily: 'Rubik',
                  fontWeight: FontWeight.w700,
                  fontSize: screenWidth * 0.063,
                  color: const Color(0xFF001833),
                ),
              ),
              SizedBox(height: screenHeight * 0.07),

              // Label input
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Name',
                  style: TextStyle(
                    fontFamily: 'Rubik',
                    fontWeight: FontWeight.w600,
                    fontSize: screenWidth * 0.05,
                    color: const Color(0xFF001833),
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.01),

              // Input nama
              TextInputField(
                controller: _nameController,
                hintText: 'Type your new name...',
              ),
              SizedBox(height: screenHeight * 0.07),

              // Tombol Update
              CustomButton(
                text: 'Update',
                onPressed: () {
                  // Tambahkan aksi update nanti
                  debugPrint("Name updated: ${_nameController.text}");
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
