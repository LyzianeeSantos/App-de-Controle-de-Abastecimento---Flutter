// lib/services/firebase_auth_service.dart

import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Registrar um novo usuário
  Future<User?> registerWithEmailPassword(String email, String password) async {
    try {
      final UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(email: email, password: password);
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      throw e.message ?? 'Erro ao registrar';
    }
  }

  // Login de usuário
  Future<User?> loginWithEmailPassword(String email, String password) async {
    try {
      final UserCredential userCredential =
          await _auth.signInWithEmailAndPassword(email: email, password: password);
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      throw e.message ?? 'Erro ao fazer login';
    }
  }

  // Recuperação de senha
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw e.message ?? 'Erro ao enviar email de recuperação';
    }
  }

  // Logout
  Future<void> logout() async {
    await _auth.signOut();
  }

  // Verificar se o usuário está autenticado
  User? getCurrentUser() {
    return _auth.currentUser;
  }
}
