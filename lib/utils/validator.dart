class Validator {
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) return 'Email wajib diisi';
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) return 'Email tidak valid';
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) return 'Password wajib diisi';
    if (value.length < 6) return 'Password minimal 6 karakter';
    return null;
  }

  static String? validateNotEmpty(String? value, String field) {
    if (value == null || value.isEmpty) return '$field wajib diisi';
    return null;
  }

  static String? validateNumber(String? value, String field) {
    if (value == null || value.isEmpty) return '$field wajib diisi';
    if (int.tryParse(value) == null) return '$field harus angka';
    return null;
  }
}
