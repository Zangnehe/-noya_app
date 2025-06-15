// lib/main.dart
import 'package:flutter/material.dart';
import 'features/carts/presentation//cart/cart_screen.dart'; // Đảm bảo đường dẫn đúng

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CartScreen(),
    );
  }
}
