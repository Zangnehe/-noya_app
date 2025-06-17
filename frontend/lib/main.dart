import 'package:flutter/material.dart';
import 'package:frontend/core/providers/auth_provider.dart';
import 'package:frontend/features/account/favoriteproduct/FavoriteProduct.dart';
import 'package:frontend/features/account/newproduct/newproductScreen.dart';
import 'package:frontend/features/account/order/orderScreen.dart';
import 'package:frontend/features/account/review/reviewscreen.dart';
import 'package:frontend/features/account/voucher/voucherScreen.dart';
import 'package:frontend/features/authentication/presentation/forgot_password_screen.dart';
import 'package:frontend/features/authentication/presentation/login_screen.dart';
import 'package:frontend/features/authentication/presentation/register_screen.dart';
import 'package:frontend/features/authentication/presentation/reset_password_page.dart';
import 'package:frontend/features/authentication/presentation/verification_code_page.dart';
import 'package:frontend/features/category/presentation/category_screen.dart';
import 'package:frontend/features/home/presentation/home_screen.dart';
import 'package:frontend/features/notification/presentation/notification_screen.dart';
import 'package:frontend/features/cart/presentation/cart/cart_screen.dart';
import 'package:provider/provider.dart';
import 'features/account/changepassword/changePasswordScreen.dart';
import 'features/account/location/locationScreen.dart';
import 'features/account/presentation/account_screen.dart';
import 'features/account/proFile/profileScreen.dart';
import 'features/account/trademark/trademarkscreen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    const HomeScreen(),
    const CategoryScreen(),
    CartScreen(),
    NotificationScreen(),
    AccountScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: _widgetOptions[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          selectedItemColor: Color.fromARGB(255, 210, 180, 140),
          unselectedItemColor: Colors.black54,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Trang chủ',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.grid_view),
              label: 'Danh mục',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart),
              label: 'Giỏ hàng',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.notifications),
              label: 'Thông báo',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Tài khoản',
            ),
          ],
        ),
      ),
      routes: {
        '/account': (context) => AccountScreen(),
        '/category': (context) => CategoryScreen(),
        '/cart': (context) => CartScreen(),
        '/favorite': (context) => FavoriteProductScreen(),
        '/review': (context) => ReviewScreen(),
        '/profile': (context) => AccountInfoScreen(),
        '/order': (context) => OrderScreen(),
        '/location': (context) => LocationSelectionScreen(),
        '/info': (context) => AccountInfoScreen(),
        '/changePass': (context) => ChangePasswordScreen(),
        '/trademark': (context) => BrandScreen(),
        '/voucher': (context) => VoucherScreen(),
        '/newproduct': (context) => ProductGridScreen(),
        '/notification': (context) => NotificationScreen(),
        '/login': (context) => LoginPage(),
        '/register': (context) => RegisterPage(),
        '/forgot-password': (context) => ForgotPasswordPage(),
        '/reset-password': (context) => ResetPasswordPage(),
        '/verification-code': (context) => VerificationCodePage(),
      },
    );
  }
}
