import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthCheckWidget extends StatefulWidget {
  const AuthCheckWidget({super.key});

  @override
  State<AuthCheckWidget> createState() => _AuthCheckWidgetState();
}

class _AuthCheckWidgetState extends State<AuthCheckWidget> {
  String status = 'Inicializando...';

  @override
  void initState() {
    super.initState();
    checkAuth();
  }

  Future<void> checkAuth() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInAnonymously();
      setState(() {
        status = '✅ Conectado con Firebase como ${userCredential.user?.uid}';
      });
    } catch (e) {
      setState(() {
        status = '❌ Error: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Verificación Firebase')),
      body: Center(child: Text(status, textAlign: TextAlign.center)),
    );
  }
}