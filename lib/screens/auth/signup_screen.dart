import 'package:flutter/material.dart';
import '../../services/auth_service.dart';

class SignupScreen extends StatefulWidget {
  SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final nameC = TextEditingController();
  final emailC = TextEditingController();
  final passC = TextEditingController();
  String role = 'pembeli';

  void register() async {
    await AuthService.register(
      nameC.text,
      emailC.text,
      passC.text,
      role,
    );

    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Daftar')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(controller: nameC, decoration: const InputDecoration(labelText: 'Nama')),
            TextField(controller: emailC, decoration: const InputDecoration(labelText: 'Email')),
            TextField(controller: passC, obscureText: true, decoration: const InputDecoration(labelText: 'Password')),
            DropdownButtonFormField(
              value: role,
              items: const [
                DropdownMenuItem(value: 'petani', child: Text('Petani')),
                DropdownMenuItem(value: 'pembeli', child: Text('Pembeli')),
              ],
              onChanged: (v) => setState(() => role = v!),
            ),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: register, child: const Text('Daftar')),
          ],
        ),
      ),
    );
  }
}
