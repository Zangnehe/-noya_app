import 'package:flutter/material.dart';
import 'package:frontend/core/providers/auth_provider.dart';
import 'package:frontend/core/services/auth/google_service.dart';
import 'package:frontend/features/authentication/presentation/register_screen.dart';
import 'package:frontend/features/authentication/presentation/forgot_password_screen.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // Validate email
  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Vui lòng nhập email';
    }
    void checkLoginStatus() {
      final authProvider =
          Provider.of<AuthProvider>(context, listen: false); // Lấy authProvider
      authProvider.loadUser().then((_) {
        if (authProvider.currentUser != null) {
          Navigator.pushReplacementNamed(context, '/');
        }
      });
    }

    void initState() {
      super.initState();
      checkLoginStatus();
    }

    final RegExp emailRegex =
        RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$");
    if (!emailRegex.hasMatch(value)) {
      return 'Vui lòng nhập email hợp lệ';
    }

    if (value.length < 5) {
      return 'Email phải có ít nhất 5 ký tự';
    }

    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Mật khẩu không được để trống';
    }
    if (value.length < 6 || value.length > 32) {
      return 'Mật khẩu phải từ 6 đến 32 ký tự';
    }
    return null;
  }

  void _showDialog(String message, Color color) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Thông báo'),
          content: Text(message),
          backgroundColor: color,
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _showGoogleLoginDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.grey[900],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  '"Dolia" muốn sử dụng "Google.com" để đăng nhập',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Việc này cho phép ứng dụng và trang web chia sẻ thông tin về bạn',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(); // Đóng hộp thoại
                      },
                      child: const Text(
                        'Hủy',
                        style: TextStyle(color: Colors.blue, fontSize: 16),
                      ),
                    ),
                    TextButton(
                      onPressed: () async {
                        try {
                          final account =
                              await GoogleSignInService().signInWithGoogle();
                          if (account != null) {
                            print("User logged in: ${account}");
                          }
                          // Navigator.of(context).pop();
                          // _showDialog(
                          //     'Đăng nhập Google thành công', Colors.white);
                        } catch (e) {
                          print("Lỗi đăng nhập: $e");
                        }
                      },
                      child: const Text(
                        'Tiếp tục',
                        style: TextStyle(color: Colors.blue, fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _submit() async {
    if (_formKey.currentState!.validate()) {
      try {
        await Provider.of<AuthProvider>(context, listen: false)
            .login(_usernameController.text, _passwordController.text);
        // Xóa dữ liệu sau khi đăng nhập thành công
        _usernameController.clear();
        _passwordController.clear();

        _showDialog('Đăng nhập thành công', Colors.white);

        // Điều hướng tới trang chủ sau khi đăng nhập thành công
        if (Provider.of<AuthProvider>(context, listen: false).currentUser !=
            null) {
          Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
        } else {
          _showDialog(
              'Vui lòng điền đầy đủ thông tin và kiểm tra lại', Colors.white);
        }
      } catch (e) {
        _showDialog('Đăng nhập thất bại', Colors.red);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Center(
          child: Text(
            'Đăng Nhập',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: size.width * 0.50,
                height: size.width * 0.40,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: Image.asset('assets/Logo_doria.png', fit: BoxFit.cover),
              ),
              const SizedBox(height: 15),
              ElevatedButton.icon(
                onPressed: () {
                  _showGoogleLoginDialog();
                },
                icon: const Icon(Icons.g_mobiledata),
                label: const Text('Đăng nhập bằng Google'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              const Text(
                'Hoặc tài khoản Dolia.vn',
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 20),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _usernameController,
                      validator: _validateEmail,
                      decoration: InputDecoration(
                        hintText: 'Email',
                        filled: true,
                        fillColor: Colors.grey[200],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: true,
                      validator: _validatePassword,
                      decoration: InputDecoration(
                        hintText: 'Mật khẩu',
                        filled: true,
                        fillColor: Colors.grey[200],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            '/forgot-password',
                          );
                        },
                        child: const Text(
                          'Quên mật khẩu?',
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _submit,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 100, vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        'ĐĂNG NHẬP',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextButton(
                      onPressed: () {
                        // Navigator.pushNamed(
                        //   context,
                        //   '/register',
                        // );
                        Navigator.push(
                          context,
                         MaterialPageRoute(builder: (context)=>RegisterPage())
                        );
                      },
                      child: const Text(
                        'Bạn chưa có tài khoản đăng nhập? Đăng ký',
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
