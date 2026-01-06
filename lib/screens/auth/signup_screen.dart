import 'dart:ui';
import 'package:flutter/material.dart';
import '../../services/auth_service.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final emailC = TextEditingController();
  final nameC = TextEditingController();
  final passC = TextEditingController();

  String role = 'pembeli';
  bool loading = false;

  /// ❗ LOGIC REGISTER — TIDAK DIUBAH
  void register() async {
    if (nameC.text.isEmpty ||
        emailC.text.isEmpty ||
        passC.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Semua kolom wajib diisi'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() => loading = true);

    final String? errorMessage = await AuthService.register(
      nameC.text.trim(),
      emailC.text.trim(),
      passC.text.trim(),
      role,
    );

    setState(() => loading = false);

    if (errorMessage != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Daftar berhasil, silakan login'),
        backgroundColor: Colors.green,
      ),
    );

    await Future.delayed(const Duration(seconds: 1));
    Navigator.pushReplacementNamed(context, '/login');
  }

  void _socialSignup(String provider) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('$provider signup belum tersedia')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          /// BACKGROUND
          Image.asset(
            'assets/images/bg_login.jpg',
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),

          /// OVERLAY GELAP TIPIS
          Container(color: Colors.black.withOpacity(0.35)),

          /// CARD GLASS
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(22),
                child: BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: 3.5,
                    sigmaY: 3.5,
                  ),
                  child: Container(
                    constraints: const BoxConstraints(maxWidth: 340),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 22,
                      vertical: 24,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.28),
                      borderRadius: BorderRadius.circular(22),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.45),
                      ),
                    ),
                    child: Column(
                      children: [
                        const Text(
                          'Registration',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),

                        const SizedBox(height: 12),

                        /// ICON PROFIL
                        Transform.translate(
                          offset: const Offset(0, 6),
                          child: CircleAvatar(
                            radius: 34,
                            backgroundColor:
                                Colors.white.withOpacity(0.65),
                            child: const Icon(
                              Icons.person,
                              size: 38,
                              color: Colors.black54,
                            ),
                          ),
                        ),

                        const SizedBox(height: 24),

                        _field(emailC, Icons.email, 'Email'),
                        const SizedBox(height: 14),

                        _field(nameC, Icons.person, 'Username'),
                        const SizedBox(height: 14),

                        _field(
                          passC,
                          Icons.lock,
                          'Password',
                          obscure: true,
                        ),
                        const SizedBox(height: 14),

                        DropdownButtonFormField<String>(
                          value: role,
                          items: const [
                            DropdownMenuItem(
                              value: 'petani',
                              child: Text('Petani'),
                            ),
                            DropdownMenuItem(
                              value: 'pembeli',
                              child: Text('Pembeli'),
                            ),
                          ],
                          onChanged: (v) =>
                              setState(() => role = v!),
                          decoration: InputDecoration(
                            prefixIcon:
                                const Icon(Icons.person_add),
                            filled: true,
                            fillColor:
                                Colors.white.withOpacity(0.85),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(14),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),

                        const SizedBox(height: 22),

                        /// BUTTON SIGN UP
                        SizedBox(
                          width: double.infinity,
                          height: 46,
                          child: ElevatedButton(
                            onPressed:
                                loading ? null : register,
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color(0xFF8BC34A),
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(14),
                              ),
                            ),
                            child: loading
                                ? const CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                : const Text(
                                    'Sign Up',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                          ),
                        ),

                        const SizedBox(height: 14),

                        /// LINK LOGIN
                        Row(
                          mainAxisAlignment:
                              MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Sudah punya akun?',
                              style:
                                  TextStyle(color: Colors.white),
                            ),
                            TextButton(
                              onPressed: () =>
                                  Navigator.pushReplacementNamed(
                                      context, '/login'),
                              child: const Text(
                                'Login',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green,
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 8),

                        const Text(
                          'or sign up with',
                          style:
                              TextStyle(color: Colors.white70),
                        ),

                        const SizedBox(height: 14),

                        /// SOCIAL LOGIN
                        Row(
                          mainAxisAlignment:
                              MainAxisAlignment.center,
                          children: [
                            _socialAsset(
                              'assets/icons/facebook.png',
                              () => _socialSignup('Facebook'),
                            ),
                            const SizedBox(width: 22),
                            _socialAsset(
                              'assets/icons/google.png',
                              () => _socialSignup('Google'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _field(
    TextEditingController c,
    IconData icon,
    String hint, {
    bool obscure = false,
  }) {
    return TextField(
      controller: c,
      obscureText: obscure,
      decoration: InputDecoration(
        prefixIcon: Icon(icon),
        hintText: hint,
        filled: true,
        fillColor: Colors.white.withOpacity(0.85),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _socialAsset(String asset, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: CircleAvatar(
        radius: 24,
        backgroundColor: Colors.white.withOpacity(0.9),
        child: Image.asset(asset, width: 26),
      ),
    );
  }
}
