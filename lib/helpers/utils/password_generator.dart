import 'dart:math';

String generatePassword() {
  final random = Random();
  const characters =
      'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#\$%^&*()_+';
  String password = '';
  for (int i = 0; i < 12; i++) {
    password += characters[
    random.nextInt(characters.length)]; // Generate a random password
  }
   return password;
}