// lib/main.dart
import 'package:flutter/material.dart';
import 'features/carts/presentation//cart/cart_screen.dart'; // Đảm bảo đường dẫn đúng
import 'features/authentication/presentation/login_screen.dart';
import 'features/authentication/presentation/forgot_password_screen.dart';
import 'features/authentication/presentation/register_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}
