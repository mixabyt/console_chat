import 'dart:convert';
import 'package:crypto/crypto.dart';

String hashPassword(String password) {
  var bytes = utf8.encode(password); // Перетворюємо пароль в байти
  var digest = sha256.convert(bytes); // Хешуємо байти за допомогою SHA-256
  return digest.toString(); // Повертаємо хеш у вигляді рядка
}


