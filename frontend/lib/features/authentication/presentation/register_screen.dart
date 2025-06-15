import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:frontend/core/providers/auth_provider.dart';
import 'package:frontend/core/services/auth/auth_service.dart';
import 'package:frontend/features/authentication/presentation/login_screen.dart';
import 'dart:async';

import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailPhoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _verificationCodeController =
      TextEditingController();

  bool _obscurePassword = true; // Toggle password visibility
  String? _gender; // Gender
  bool _acceptPromotions = false; // Accept promotions
  bool _acceptTerms = false; // Accept terms
  DateTime _selectedDate = DateTime.now(); // Selected date of birth
  bool _isDialogVisible = false; // Track dialog visibility

  String? _verificationCode;
  bool _isCodeSent = false;
  bool _isCodeValid = false;
  late Timer _timer;
  int _timeRemaining = 60; // Time remaining for verification code

  @override
  void dispose() {
    _nameController.dispose();
    _emailPhoneController.dispose();
    _passwordController.dispose();
    _dobController.dispose();
    _verificationCodeController.dispose();
    if (_timer.isActive) {
      _timer.cancel(); // Cancel timer if active
    }
    super.dispose();
  }

  // Validate email
  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Vui lòng nhập email';
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

  // Validate name
  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Vui lòng nhập tên';
    }

    final RegExp nameRegex = RegExp(r'^[a-zA-Z\s]+$');
    if (!nameRegex.hasMatch(value)) {
      return 'Tên không được chứa ký tự đặc biệt và phải viết không dấu';
    }

    return null;
  }

  // Validate password
  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Vui lòng nhập mật khẩu';
    }

    if (value.length < 6 || value.length > 32) {
      return 'Mật khẩu phải từ 6 đến 32 ký tự';
    }

    final RegExp passwordRegex = RegExp(r'^[a-zA-Z0-9]+$');
    if (!passwordRegex.hasMatch(value)) {
      return 'Mật khẩu không được chứa ký tự đặc biệt';
    }

    return null;
  }

  // Open date picker
  void _showDatePicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext builder) {
        return Container(
          height: 250,
          padding: const EdgeInsets.only(top: 10),
          child: Column(
            children: [
              SizedBox(
                height: 200,
                child: CupertinoDatePicker(
                  initialDateTime: _selectedDate,
                  mode: CupertinoDatePickerMode.date,
                  minimumDate: DateTime(1900),
                  maximumDate: DateTime.now(),
                  onDateTimeChanged: (DateTime newDate) {
                    setState(() {
                      _selectedDate = newDate;
                      _dobController.text =
                          "${newDate.day}/${newDate.month}/${newDate.year}";
                    });
                  },
                ),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text(
                  'Xong',
                  style: TextStyle(color: Colors.blue, fontSize: 16),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Send verification code
  void _sendVerificationCode() {
    _verificationCode = '12345'; // Fake verification code
    _isCodeSent = true;
    _isCodeValid = false;

    // Reset time
    _timeRemaining = 60;

    // Start timer
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_timeRemaining > 0) {
        setState(() {
          _timeRemaining--;
        });
      } else {
        _timer.cancel();
      }
    });
  }

  // Verify code
  void _verifyCode() {
    if (_verificationCodeController.text == _verificationCode) {
      setState(() {
        _isCodeValid = true;
      });

      Navigator.of(context, rootNavigator: true).pop(); // Close all dialogs

      _showDialog('Mã xác nhận đúng! Đăng ký thành công.', resetFields: true);
    } else {
      _showDialog('Mã xác nhận không đúng. Vui lòng thử lại.');
    }
  }

  // Show dialog
  void _showDialog(String message, {bool resetFields = false}) {
    if (_isDialogVisible) {
      return; // Prevent multiple dialog displays
    }

    setState(() {
      _isDialogVisible = true; // Mark dialog as visible
    });

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Thông báo'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                _isDialogVisible = false; // Mark dialog as closed
              });
              Navigator.of(context).pop(); // Close current dialog

              if (resetFields) {
                _resetForm(); // Reset form fields after successful registration
              }
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  // Reset form fields
  void _resetForm() {
    _nameController.clear();
    _emailPhoneController.clear();
    _passwordController.clear();
    _dobController.clear();
    _verificationCodeController.clear();
    _gender = null;
    _acceptPromotions = false;
    _acceptTerms = false;
    _isCodeSent = false;
    _isCodeValid = false;
    _timeRemaining = 60; // Reset time
    if (_timer.isActive) {
      _timer.cancel(); // Cancel timer if active
    }
  }

  // Handle registration
  void _register() async {
    try {
      if (_formKey.currentState!.validate()) {
        if (validateName(_nameController.text) != null) {
          _showDialog('Tên không hợp lệ');
          return;
        }

        if (validatePassword(_passwordController.text) != null) {
          _showDialog('Mật khẩu không hợp lệ');
          return;
        }

        if (_gender == null) {
          _showDialog('Vui lòng chọn giới tính');
          return;
        }

        if (!_acceptTerms) {
          _showDialog('Bạn cần đồng ý với điều khoản và chính sách bảo mật');
          return;
        }
        await Provider.of<AuthProvider>(context, listen: false).register(
            _emailPhoneController.text,
            _passwordController.text,
            _nameController.text,
            _dobController.text,
            _gender!);
        if (Provider.of<AuthProvider>(context, listen: false).currentUser !=
            null) {
          Navigator.pushReplacementNamed(context, '/');
        }
      }
    } catch (e) {
      _showDialog('Đăng ký thất bại: $e');
    }
  }

  // Show code dialog
  void _showCodeDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Nhập mã xác nhận'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _verificationCodeController,
              decoration: const InputDecoration(hintText: 'Mã xác nhận'),
              keyboardType: TextInputType.number,
            ),
            Text('Thời gian còn lại: $_timeRemaining giây'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              if (_timeRemaining == 0) {
                _showDialog('Hết thời gian, vui lòng yêu cầu mã mới');
              } else {
                _verifyCode();
              }
            },
            child: const Text('Xác nhận'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Đóng'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          'Đăng ký',
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  hintText: 'Họ và tên',
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
                validator: (value) => validateName(value),
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: _emailPhoneController,
                decoration: InputDecoration(
                  hintText: 'Email',
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
                validator: (value) => validateEmail(value),
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: _passwordController,
                obscureText: _obscurePassword,
                decoration: InputDecoration(
                  hintText: 'Mật khẩu',
                  filled: true,
                  fillColor: Colors.grey[200],
                  suffixIcon: IconButton(
                    icon: Icon(_obscurePassword
                        ? Icons.visibility
                        : Icons.visibility_off),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
                validator: (value) => validatePassword(value),
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: _dobController,
                readOnly: true,
                onTap: () => _showDatePicker(context),
                decoration: InputDecoration(
                  hintText: 'Ngày sinh',
                  filled: true,
                  fillColor: Colors.grey[200],
                  suffixIcon: const Icon(Icons.calendar_today),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng chọn ngày sinh';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  const Text('Giới tính:'),
                  Row(
                    children: [
                      Radio<String>(
                        value: 'Male',
                        groupValue: _gender,
                        onChanged: (value) {
                          setState(() {
                            _gender = value;
                          });
                        },
                      ),
                      const Text('Nam'),
                    ],
                  ),
                  const SizedBox(width: 20),
                  Row(
                    children: [
                      Radio<String>(
                        value: 'Female',
                        groupValue: _gender,
                        onChanged: (value) {
                          setState(() {
                            _gender = value;
                          });
                        },
                      ),
                      const Text('Nữ'),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 10),
              SwitchListTile(
                value: _acceptPromotions,
                onChanged: (value) {
                  setState(() {
                    _acceptPromotions = value;
                  });
                },
                activeColor: Colors.blue,
                title: const Text('Nhận khuyến mãi qua email'),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Checkbox(
                    value: _acceptTerms,
                    onChanged: (value) {
                      setState(() {
                        _acceptTerms = value!;
                      });
                    },
                  ),
                  Expanded(
                    child: RichText(
                      text: const TextSpan(
                        text: 'Tôi đã đọc và đồng ý với ',
                        style: TextStyle(color: Colors.black),
                        children: [
                          TextSpan(
                            text: 'Điều khoản dịch vụ',
                            style: TextStyle(
                              color: Colors.blue,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                          TextSpan(text: ' và '),
                          TextSpan(
                            text: 'Chính sách bảo mật',
                            style: TextStyle(
                              color: Colors.blue,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _register,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'ĐĂNG KÝ',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Center(
                child: TextButton(
                  onPressed: () {
                    // Navigator.pushReplacementNamed(context, '/');
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      "/login",
                      (route) => false,
                    );
                  },
                  child: const Text(
                    'Đã có tài khoản? Đăng nhập.',
                    style: TextStyle(color: Colors.blue, fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
