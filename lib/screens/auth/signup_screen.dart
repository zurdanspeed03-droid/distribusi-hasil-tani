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
  bool loading = false;

  void register() async {
    if (nameC.text.isEmpty ||
        emailC.text.isEmpty ||
        passC.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Semua kolom wajib diisi')),
      );
      return;
    }

    setState(() => loading = true);

    final success = await AuthService.register(
      nameC.text.trim(),
      emailC.text.trim(),
      passC.text.trim(),
      role,
    );

    setState(() => loading = false);

    if (!success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Daftar gagal, email mungkin sudah ada')),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Daftar berhasil, silakan login')),
    );

    await Future.delayed(const Duration(seconds: 1));
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Daftar Akun')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: nameC,
              decoration: const InputDecoration(labelText: 'Nama'),
            ),
            TextField(
              controller: emailC,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: passC,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Password'),
            ),
            const SizedBox(height: 10),
            DropdownButtonFormField<String>(
              value: role,
              items: const [
                DropdownMenuItem(value: 'petani', child: Text('Petani')),
                DropdownMenuItem(value: 'pembeli', child: Text('Pembeli')),
              ],
              onChanged: (v) => setState(() => role = v!),
              decoration: const InputDecoration(labelText: 'Role'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: loading ? null : register,
              child: loading
                  ? const CircularProgressIndicator(color: Colors.green)
                  : const Text('Daftar akun'),
            ),
          ],
        ),
      ),
    );
  }
}
