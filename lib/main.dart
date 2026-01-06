import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'screens/auth/login_screen.dart';
import 'screens/auth/signup_screen.dart';
import 'screens/splash/splash_screen.dart';

void main() {
  runApp(
    DevicePreview(
      enabled: true, 
      builder: (context) => MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      useInheritedMediaQuery: true, 
      locale: DevicePreview.locale(context),
      builder: (context, child) {
        return child!;
      },
      title: 'Distribusi Hasil Tani',
      initialRoute: '/splash',
      routes: {
        '/splash': (context) => SplashScreen(),
        '/login': (context) => LoginScreen(),
        '/signup': (context) => SignupScreen(),
        '/petani': (context) => Scaffold(
              body: Center(child: Text('Dashboard Petani')),
            ),
        '/pembeli': (context) => Scaffold(
              body: Center(child: Text('Dashboard Pembeli')),
            ),
      },
    );
  }
}
