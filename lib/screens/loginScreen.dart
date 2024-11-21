import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('test'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Ação ao clicar no botão
            criarconta();
          },
          child: const Text('Entrar'),
        ),
      ),
    );
  }
  Future<void> criarconta() async{
    try {
      final auth = FirebaseAuth.instance;
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(email: "lyziane_lyzi@hotmail.com", password: "123456");
    } on FirebaseAuthException catch (e) {
      print(e.message);
    }
  }

}
