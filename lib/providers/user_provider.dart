import 'dart:math';
import 'package:flutter/foundation.dart';

class UserProvider extends ChangeNotifier {
  String _username = '';
  String _avatarPath = '';

  String get username => _username;
  String get avatarPath => _avatarPath;

  void setUser(String name) {
    _username = name;

    // Pilih avatar random dari 1–10
    final randomIndex = Random().nextInt(10) + 1; // 1..10
    _avatarPath = 'assets/images/avatar$randomIndex.png';

    notifyListeners();
  }

  void updateUsername(String newName) {
    _username = newName;
    notifyListeners();
  }

  void randomizeAvatar() {
    final random = Random();
    int avatarIndex = random.nextInt(10) + 1;
    _avatarPath = 'assets/images/avatar$avatarIndex.png';
    notifyListeners();
  }

  bool get hasUser => _username.isNotEmpty && _avatarPath.isNotEmpty;
}
