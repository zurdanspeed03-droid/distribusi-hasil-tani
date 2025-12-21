import '../models/user_model.dart';

class AuthService {
  static UserModel? _currentUser;

  static Future<UserModel?> login(String email, String password) async {
    await Future.delayed(const Duration(milliseconds: 500));

    if (email == 'petani@mail.com' && password == '123456') {
      _currentUser = UserModel(
        id: 1,
        name: 'Petani Demo',
        email: email,
        role: 'petani',
      );
      return _currentUser;
    }

    if (email == 'pembeli@mail.com' && password == '123456') {
      _currentUser = UserModel(
        id: 2,
        name: 'Pembeli Demo',
        email: email,
        role: 'pembeli',
      );
      return _currentUser;
    }

    return null;
  }

  static Future<UserModel?> register(
    String name,
    String email,
    String password,
    String role,
  ) async {
    await Future.delayed(const Duration(milliseconds: 500));

    _currentUser = UserModel(
      id: DateTime.now().millisecondsSinceEpoch,
      name: name,
      email: email,
      role: role,
    );

    return _currentUser;
  }

  static Future<bool> isLoggedIn() async {
    return _currentUser != null;
  }

  static Future<String?> getUserRole() async {
    return _currentUser?.role;
  }

  static void logout() {
    _currentUser = null;
  }
}
