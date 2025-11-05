import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';
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
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

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

              // Avatar + tombol refresh
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  CircleAvatar(
                    radius: screenWidth * 0.15,
                    backgroundImage: AssetImage(userProvider.avatarPath),
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      color: Color(0xFF001833),
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.refresh, color: Colors.white),
                      onPressed: () {
                        userProvider.randomizeAvatar();
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: screenHeight * 0.02),

              // Nama pengguna
              Text(
                userProvider.username.isNotEmpty
                    ? userProvider.username
                    : 'Guest',
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
                  if (_nameController.text.trim().isNotEmpty) {
                    userProvider.updateUsername(_nameController.text.trim());
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Profile updated!')),
                    );

                    _nameController.clear();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
