import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthNotifier extends ChangeNotifier {
  bool isLoggedIn = false;

  AuthNotifier() {
    _checkAuth();
  }

  void _checkAuth() {
    final user = FirebaseAuth.instance.currentUser;
    isLoggedIn = user != null;
    print("🔄 FirebaseAuth: Usuario actual = ${user?.email}");
    notifyListeners();
  }

  void login() {
    isLoggedIn = true;
    print("✅ Usuario logueado");
    notifyListeners();
  }

  void logout() async {
    await FirebaseAuth.instance.signOut();
    isLoggedIn = false;
    print("✅ Usuario deslogueado");
    notifyListeners();
  }
}