import 'package:flutter/material.dart';
import 'login_screen.dart'; // Đảm bảo login_screen.dart có trang đăng ký của bạn

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  // Giả lập việc gửi mã xác nhận qua email
  Future<void> _sendVerificationCode(String email) async {
    setState(() {
      _isLoading = true;
    });

    // Giả lập gửi mã xác nhận thành công
    await Future.delayed(const Duration(seconds: 2)); // Giả lập trễ
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Mã xác nhận đã được gửi qua email')),
    );

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Center(
            child: Text(
          'Quên Mật Khẩu',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        )),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    hintText: 'Nhập email',
                    filled: true,
                    fillColor: Colors.grey[200],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Vui lòng nhập email';
                    }
                    final RegExp emailRegex = RegExp(
                        r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$");
                    if (!emailRegex.hasMatch(value)) {
                      return 'Vui lòng nhập email hợp lệ';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: _isLoading
                      ? null
                      : () {
                          final email = _emailController.text;
                          if (_formKey.currentState!.validate()) {
                            // _sendVerificationCode(email);
                            Navigator.pushNamed(
                              context,
                              '/verification-code',
                            );
                          }
                        },
                  child: _isLoading
                      ? CircularProgressIndicator(color: Colors.white)
                      : const Text('Gửi mã xác nhận'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Text('Vui lòng cung cấp địa chỉ email để lấy lại mật khẩu'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
