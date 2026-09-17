import 'package:flutter/material.dart';
import 'package:notes_app/feature/auth_services/auth_services.dart';

class AuthProvider with ChangeNotifier {
  final AuthServices _authServices = AuthServices();

  bool _passwordObsecure = false;

  bool get passwordObsecure => _passwordObsecure;

  void togglePasswordObsecure() {
    _passwordObsecure = !_passwordObsecure;

    notifyListeners();
  }

  bool _confirmPasswordObsecure = false;
  bool get confirmPasswordObsecure => _confirmPasswordObsecure;

  void toggleConfirmPasswordObsecrue() {
    _confirmPasswordObsecure = !_confirmPasswordObsecure;

    notifyListeners();
  }

  Future<void> logIn({required String email, required String password}) async {
    try {
      await _authServices.logIn(email: email, password: password);
    } finally {
      notifyListeners();
    }
  }

  Future<void> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      await _authServices.signUp(name: name, email: email, password: password);
    } finally {
      notifyListeners();
    }
  }
}
