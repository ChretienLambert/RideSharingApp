import 'package:flutter/foundation.dart';
import '../utils/app_logger.dart';

enum UserRole { passenger, driver, admin, none }

class AuthProvider extends ChangeNotifier {
  UserRole _userRole = UserRole.none;
  bool _isOnboarded = false;
  bool _isAuthenticated = false;
  String? _userId;
  String? _userName;
  String? _userEmail;
  String? _userPhone;

  // Getters
  UserRole get userRole => _userRole;
  bool get isOnboarded => _isOnboarded;
  bool get isAuthenticated => _isAuthenticated;
  String? get userId => _userId;
  String? get userName => _userName;
  String? get userEmail => _userEmail;
  String? get userPhone => _userPhone;

  bool get isPassenger => _userRole == UserRole.passenger;
  bool get isDriver => _userRole == UserRole.driver;
  bool get isAdmin => _userRole == UserRole.admin;

  // Setters
  void setUserRole(UserRole role) {
    _userRole = role;
    AppLogger.info('User role set to $role', tag: 'AuthProvider');
    notifyListeners();
  }

  void setOnboarded(bool onboarded) {
    _isOnboarded = onboarded;
    AppLogger.info('Onboarding completed: $onboarded', tag: 'AuthProvider');
    notifyListeners();
  }

  void setAuthenticated(bool authenticated) {
    _isAuthenticated = authenticated;
    AppLogger.info('Authentication status: $authenticated',
        tag: 'AuthProvider');
    notifyListeners();
  }

  void setUser({
    required String id,
    required String name,
    String? email,
    String? phone,
  }) {
    _userId = id;
    _userName = name;
    _userEmail = email;
    _userPhone = phone;
    AppLogger.info('User set: $name (ID: $id)', tag: 'AuthProvider');
    notifyListeners();
  }

  void completeOnboarding() {
    _isOnboarded = true;
    notifyListeners();
  }

  void completeAuthentication() {
    _isAuthenticated = true;
    notifyListeners();
  }

  Future<void> signInWithPhone(String phoneNumber) async {
    try {
      // Simulate phone authentication
      await Future.delayed(const Duration(seconds: 2));

      _userPhone = phoneNumber;
      _isAuthenticated = true;
      notifyListeners();
    } catch (e) {
      debugPrint('Error signing in with phone: $e');
      rethrow;
    }
  }

  Future<void> signOut() async {
    _userRole = UserRole.none;
    _isOnboarded = false;
    _isAuthenticated = false;
    _userId = null;
    _userName = null;
    _userEmail = null;
    _userPhone = null;
    notifyListeners();
  }

  void reset() {
    _userRole = UserRole.none;
    _isOnboarded = false;
    _isAuthenticated = false;
    _userId = null;
    _userName = null;
    _userEmail = null;
    _userPhone = null;
    notifyListeners();
  }
}
