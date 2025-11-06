import 'dart:convert';
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider extends ChangeNotifier {
  static const String _allUsersKey = 'all_users_data';

  String _username = 'Guest';
  String _avatarPath = 'assets/images/avatar1.png';
  int _totalPoints = 0;
  final Set<String> _completedQuizzes = {};

  String get username => _username;
  String get avatarPath => _avatarPath;
  int get totalPoints => _totalPoints;
  Set<String> get completedQuizzes => _completedQuizzes;

  bool get hasUser => _username != 'Guest';

  // ========= Update Methods =========

  Future<void> setUser(String name) async {
    final prefs = await SharedPreferences.getInstance();
    final dataString = prefs.getString(_allUsersKey);
    Map<String, dynamic> allUsers =
        dataString != null ? jsonDecode(dataString) : {};

    if (allUsers.containsKey(name)) {
      // Load user lama
      final user = allUsers[name];
      _username = user['username'];
      _avatarPath = user['avatarPath'];
      _totalPoints = user['totalPoints'];
      _completedQuizzes
        ..clear()
        ..addAll(List<String>.from(user['completedQuizzes']));
    } else {
      // Buat user baru
      _username = name;
      _avatarPath = 'assets/images/avatar${Random().nextInt(10) + 1}.png';
      _totalPoints = 0;
      _completedQuizzes.clear();
    }

    await _saveToPrefs();
    notifyListeners();
  }

  void updateUsername(String newName) async {
    final prefs = await SharedPreferences.getInstance();
    final dataString = prefs.getString(_allUsersKey);
    Map<String, dynamic> allUsers =
        dataString != null ? jsonDecode(dataString) : {};

    // Hapus data lama dan simpan dengan nama baru
    allUsers.remove(_username);
    _username = newName;
    allUsers[_username] = _toMap();

    await prefs.setString(_allUsersKey, jsonEncode(allUsers));
    notifyListeners();
  }

  void randomizeAvatar() {
    _avatarPath = 'assets/images/avatar${Random().nextInt(10) + 1}.png';
    _saveToPrefs();
    notifyListeners();
  }

  void addPoints(int points) {
    _totalPoints += points;
    _saveToPrefs();
    notifyListeners();
  }

  void markQuizComplete(String quizName) {
    _completedQuizzes.add(quizName);
    _saveToPrefs();
    notifyListeners();
  }

  // ========= Persistence =========

  Future<void> loadFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final dataString = prefs.getString(_allUsersKey);

    if (dataString != null) {
      final allUsers = jsonDecode(dataString);
      if (allUsers.containsKey(_username)) {
        final user = allUsers[_username];
        _avatarPath = user['avatarPath'];
        _totalPoints = user['totalPoints'];
        _completedQuizzes
          ..clear()
          ..addAll(List<String>.from(user['completedQuizzes']));
      }
    }
    notifyListeners();
  }

  Future<void> _saveToPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final dataString = prefs.getString(_allUsersKey);
    Map<String, dynamic> allUsers =
        dataString != null ? jsonDecode(dataString) : {};

    allUsers[_username] = _toMap();
    await prefs.setString(_allUsersKey, jsonEncode(allUsers));
  }

  Map<String, dynamic> _toMap() => {
        'username': _username,
        'avatarPath': _avatarPath,
        'totalPoints': _totalPoints,
        'completedQuizzes': _completedQuizzes.toList(),
      };

  // ========= Reset / Logout =========

  Future<void> resetProgress() async {
    _totalPoints = 0;
    _completedQuizzes.clear();
    await _saveToPrefs();
    notifyListeners();
  }

  Future<void> logout() async {
    _username = 'Guest';
    _avatarPath = 'assets/images/avatar${Random().nextInt(10) + 1}.png';
    _totalPoints = 0;
    _completedQuizzes.clear();
    notifyListeners();
  }

  // ========= Static Helpers =========

  static Future<Map<String, dynamic>> getAllUsers() async {
    final prefs = await SharedPreferences.getInstance();
    final dataString = prefs.getString(_allUsersKey);
    return dataString != null ? jsonDecode(dataString) : {};
  }

  static Future<bool> userExists(String name) async {
    final prefs = await SharedPreferences.getInstance();
    final dataString = prefs.getString(_allUsersKey);
    if (dataString == null) return false;
    final allUsers = jsonDecode(dataString);
    return allUsers.containsKey(name);
  }
}
