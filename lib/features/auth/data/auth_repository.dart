// auth_repository.dart

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 👇 Tu clase AuthRepository aquí
class AuthRepository {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore;

  AuthRepository(this._firebaseAuth, this._firestore);

  Future<void> signUp({
    required String email,
    required String password,
    required String name,
    required String gender,
    required int age,
    required String location,
    required String orientation,
    required List<String> interests,
  }) async {
    // 👉 Crear cuenta
    final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    final uid = userCredential.user?.uid;

    if (uid == null) {
      throw FirebaseAuthException(
        code: 'registration-failed',
        message: 'No se pudo obtener el UID del usuario',
      );
    }

    // 👉 Guardar perfil en Firestore
    await _firestore.collection('users').doc(uid).set({
      'uid': uid,
      'email': email,
      'name': name,
      'gender': gender,
      'age': age,
      'location': location,
      'orientation': orientation,
      'interests': interests,
      'createdAt': FieldValue.serverTimestamp(),
    });

    // 🔐 IMPORTANTE: Forzar autenticación persistente
    await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> login({
    required String email,
    required String password,
  }) async {
    await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> logout() async {
    await _firebaseAuth.signOut();
  }
}

// 👇 Aquí colocas el provider
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository(FirebaseAuth.instance, FirebaseFirestore.instance);
});