import 'package:flutter/material.dart';
import '../../services/auth_service.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailC = TextEditingController();
  final passC = TextEditingController();
  bool loading = false;

  void doLogin() async {
    setState(() => loading = true);

    final user = await AuthService.login(
      emailC.text.trim(),
      passC.text.trim(),
    );

    setState(() => loading = false);

    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Login gagal')),
      );
      return;
    }

    if (user.role == 'petani') {
      Navigator.pushReplacementNamed(context, '/petani');
    } else {
      Navigator.pushReplacementNamed(context, '/pembeli');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: emailC,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: passC,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Password'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: loading ? null : doLogin,
              child: loading
                  ? const CircularProgressIndicator()
                  : const Text('Login'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/signup');
              },
              child: const Text('Daftar'),
            ),
          ],
        ),
      ),
    );
  }
}
