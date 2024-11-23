import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  bool _isEditing = false;
  String? _username;

  User? get currentUser => _auth.currentUser;

  @override
  void initState() {
    super.initState();
    _fetchUserData();
    if (currentUser != null) {
      _emailController.text = currentUser!.email ?? '';
    }
  }

  // Função para buscar o nome de usuário no Firestore
  Future<void> _fetchUserData() async {
    final userDoc = await _firestore.collection('users').doc(currentUser?.uid).get();
    if (userDoc.exists) {
      setState(() {
        _username = userDoc.data()?['username'];
        _usernameController.text = _username ?? '';
      });
    }
  }

  // Função para atualizar o nome de usuário no Firestore
  Future<void> _updateUsername() async {
    try {
      await _firestore.collection('users').doc(currentUser?.uid).set({
        'username': _usernameController.text,
      }, SetOptions(merge: true));
      setState(() {
        _username = _usernameController.text;
      });
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Nome de usuário atualizado com sucesso!'),
      ));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Erro ao atualizar nome de usuário: $e'),
      ));
    }
  }

  // Função para editar o email
  Future<void> _updateEmail() async {
    try {
      await currentUser?.updateEmail(_emailController.text);
      await currentUser?.reload();
      setState(() {});
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Email atualizado com sucesso!'),
      ));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Erro ao atualizar email: $e'),
      ));
    }
  }

  // Função para editar a senha
  Future<void> _updatePassword() async {
    try {
      await currentUser?.updatePassword(_passwordController.text);
      await currentUser?.reload();
      setState(() {});
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Senha atualizada com sucesso!'),
      ));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Erro ao atualizar senha: $e'),
      ));
    }
  }

  // Função de logout
  Future<void> _logout() async {
    await _auth.signOut();
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final user = currentUser;

    return Scaffold(
      appBar: AppBar(title: const Text('Perfil')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.blue,
              child: Text(
                user?.email?.substring(0, 1).toUpperCase() ?? '?',
                style: const TextStyle(fontSize: 40, color: Colors.white),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              _username ?? 'Usuário sem nome definido',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              user?.email ?? 'Usuário não identificado',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 24),
            if (_isEditing) ...[
              TextField(
                controller: _usernameController,
                decoration: const InputDecoration(labelText: 'Nome de Usuário'),
              ),
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email'),
              ),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(labelText: 'Nova Senha'),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  _updateUsername();
                  _updateEmail();
                  _updatePassword();
                },
                child: const Text('Salvar Alterações'),
              ),
            ] else ...[
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _isEditing = true;
                  });
                },
                child: const Text('Editar Perfil'),
              ),
            ],
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _logout,
              child: const Text('Sair'),
            ),
          ],
        ),
      ),
    );
  }
}
