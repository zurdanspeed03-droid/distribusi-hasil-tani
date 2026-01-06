import 'dart:ui';
import 'package:flutter/material.dart';
import '../../services/auth_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailC = TextEditingController();
  final passC = TextEditingController();

  bool loading = false;
  bool hidePassword = true;

  @override
  void dispose() {
    emailC.dispose();
    passC.dispose();
    super.dispose();
  }

  /// ❗ LOGIC LOGIN — TIDAK DIUBAH
  void doLogin() async {
    if (emailC.text.isEmpty || passC.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Email dan password wajib diisi'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() => loading = true);

    final user = await AuthService.login(
      emailC.text.trim(),
      passC.text.trim(),
    );

    setState(() => loading = false);

    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Email atau password salah'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    Navigator.pushReplacementNamed(
      context,
      user.role == 'petani' ? '/petani' : '/pembeli',
    );
  }

  void _socialLogin(String provider) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('$provider login belum tersedia')),
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
                  filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                  child: Container(
                    constraints: const BoxConstraints(maxWidth: 360),
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
                        /// LOGO
                        Image.asset(
                          'assets/images/logo.png',
                          height: 56,
                        ),

                        const SizedBox(height: 10),

                        const Text(
                          'Welcome Back',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),

                        const SizedBox(height: 12),

                        /// ICON PROFIL (PAS & TIDAK HILANG)
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

                        /// EMAIL
                        _field(
                          emailC,
                          Icons.email,
                          'Email',
                        ),

                        const SizedBox(height: 14),

                        /// PASSWORD
                        _field(
                          passC,
                          Icons.lock,
                          'Password',
                          obscure: hidePassword,
                          suffix: IconButton(
                            icon: Icon(
                              hidePassword
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                            onPressed: () {
                              setState(() {
                                hidePassword = !hidePassword;
                              });
                            },
                          ),
                        ),

                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {},
                            child: const Text(
                              'Forgot Password?',
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 6),

                        /// BUTTON LOGIN
                        SizedBox(
                          width: double.infinity,
                          height: 46,
                          child: ElevatedButton(
                            onPressed: loading ? null : doLogin,
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
                                    'Sign In',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                  ),
                          ),
                        ),

                        const SizedBox(height: 14),

                        /// LINK SIGN UP
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Belum punya akun?',
                              style:
                                  TextStyle(color: Colors.white),
                            ),
                            TextButton(
                              onPressed: () => Navigator.pushNamed(
                                  context, '/signup'),
                              child: const Text(
                                'Sign Up',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green,
                                ),
                              ),
                            ),
                          ],
                        ),

                        const Text(
                          'or sign in with',
                          style:
                              TextStyle(color: Colors.white70),
                        ),
                        const SizedBox(height: 14),

                        /// SOCIAL LOGIN (ASSET BENAR)
                        Row(
                          mainAxisAlignment:
                              MainAxisAlignment.center,
                          children: [
                            _social(
                              'assets/icons/facebook.png',
                              () => _socialLogin('Facebook'),
                            ),
                            const SizedBox(width: 22),
                            _social(
                              'assets/icons/google.png',
                              () => _socialLogin('Google'),
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
    Widget? suffix,
  }) {
    return TextField(
      controller: c,
      obscureText: obscure,
      decoration: InputDecoration(
        prefixIcon: Icon(icon),
        suffixIcon: suffix,
        hintText: hint,
        filled: true,
        fillColor: Colors.white.withOpacity(0.85),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _social(String asset, VoidCallback onTap) {
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
