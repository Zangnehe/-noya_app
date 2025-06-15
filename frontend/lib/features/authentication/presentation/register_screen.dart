import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'login_screen.dart'; // Nhớ kiểm tra lại đường dẫn của LoginPage
import 'dart:async';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

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

  bool _obscurePassword = true; // Trạng thái ẩn/hiện mật khẩu
  String? _gender; // Giới tính
  bool _acceptPromotions = false; // Nhận khuyến mãi
  bool _acceptTerms = false; // Đồng ý điều khoản
  DateTime _selectedDate = DateTime.now(); // Ngày sinh được chọn
  bool _isDialogVisible = false; // Thêm biến trạng thái để theo dõi dialog

  String? _verificationCode;
  bool _isCodeSent = false;
  bool _isCodeValid = false;
  late Timer _timer;
  int _timeRemaining = 60; // Thời gian còn lại 60 giây

  @override
  void dispose() {
    _nameController.dispose();
    _emailPhoneController.dispose();
    _passwordController.dispose();
    _dobController.dispose();
    _verificationCodeController.dispose();
    if (_timer.isActive) {
      _timer.cancel(); // Hủy Timer nếu còn hoạt động
    }
    super.dispose();
  }

  // Hàm kiểm tra email hợp lệ
  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Vui lòng nhập emACail';
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

  // Hàm kiểm tra tên hợp lệ (Không có ký tự đặc biệt)
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

  // Hàm kiểm tra mật khẩu hợp lệ
  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Vui lòng nhập mật khẩu';
    }

    if (value.length < 6 || value.length > 32) {
      return 'Mật khẩu phải có từ 6 đến 32 ký tự';
    }

    // Kiểm tra không chứa ký tự đặc biệt
    final RegExp passwordRegex = RegExp(r'^[a-zA-Z0-9]+$');
    if (!passwordRegex.hasMatch(value)) {
      return 'Mật khẩu không được chứa ký tự đặc biệt';
    }

    return null;
  }

  // Hàm mở giao diện chọn ngày sinh
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

  // Hàm xử lý gửi mã xác nhận
  void _sendVerificationCode() {
    _verificationCode = '12345'; // Mã xác nhận giả
    _isCodeSent = true;
    _isCodeValid = false; // Reset lại trạng thái mã xác nhận hợp lệ

    // Reset lại thời gian
    _timeRemaining = 60;

    // Bắt đầu hẹn giờ
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_timeRemaining > 0) {
        setState(() {
          _timeRemaining--;
        });
      } else {
        _timer.cancel();
      }
    });
  }

  void _verifyCode() {
    if (_verificationCodeController.text == _verificationCode) {
      setState(() {
        _isCodeValid = true;
      });

      // Đóng tất cả dialog và hiển thị thông báo đăng ký thành công
      Navigator.of(context, rootNavigator: true).pop(); // Đóng tất cả dialog

      // Hiển thị thông báo đăng ký thành công
      _showDialog('Mã xác nhận đúng! Đăng ký thành công.', resetFields: true);
    } else {
      _showDialog('Mã xác nhận không đúng. Vui lòng thử lại.');
    }
  }

  void _showDialog(String message, {bool resetFields = false}) {
    if (_isDialogVisible)
      return; // Nếu dialog đã hiển thị, không mở thêm dialog mới

    setState(() {
      _isDialogVisible = true; // Đánh dấu dialog là đang hiển thị
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
                _isDialogVisible = false; // Đánh dấu dialog đã đóng
              });
              Navigator.of(context).pop(); // Đóng dialog hiện tại

              if (resetFields) {
                _resetForm(); // Reset các trường nhập liệu khi đăng ký thành công
              }
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

// Hàm reset lại các trường nhập liệu
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
    _timeRemaining = 60; // Reset lại thời gian
    if (_timer.isActive) {
      _timer.cancel(); // Hủy hẹn giờ nếu còn hoạt động
    }
  }

  // Hàm xử lý nút Đăng ký
  void _register() {
    if (_formKey.currentState!.validate()) {
      // Kiểm tra tên
      if (validateName(_nameController.text) != null) {
        _showDialog('Tên không hợp lệ');
        return;
      }

      // Kiểm tra mật khẩu
      if (validatePassword(_passwordController.text) != null) {
        _showDialog('Mật khẩu không hợp lệ');
        return;
      }

      // Kiểm tra giới tính
      if (_gender == null) {
        _showDialog('Bạn chưa chọn giới tính');
        return;
      }

      // Kiểm tra điều khoản
      if (!_acceptTerms) {
        _showDialog(
            'Bạn cần đồng ý với điều kiện giao dịch và chính sách bảo mật của Dolia.');
        return;
      }

      // Xử lý gửi mã xác nhận
      _showDialog('Mã xác nhận sẽ được gửi tới email.');

      // Chờ một chút trước khi hiển thị dialog nhập mã xác nhận
      Future.delayed(Duration(seconds: 2), () {
        _sendVerificationCode();
        _showCodeDialog();
      });
    }
  }

  // Hiển thị thông báo nhập mã xác nhận
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
            // Hiển thị thời gian còn lại
            Text('Thời gian còn lại: $_timeRemaining giây'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              if (_timeRemaining == 0) {
                _showDialog('Thời gian hết, vui lòng yêu cầu mã xác nhận mới');
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
          'Đăng Ký',
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
              // Họ tên
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  hintText: 'Họ Tên',
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
              // Email
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
              // Mật khẩu
              TextFormField(
                controller: _passwordController,
                obscureText: _obscurePassword,
                decoration: InputDecoration(
                  hintText: 'Mật khẩu',
                  filled: true,
                  fillColor: Colors.grey[200],
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
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
              // Ngày sinh
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
              // Giới tính
              Row(
                children: [
                  const Text('Giới tính:'),
                  const SizedBox(width: 20),
                  Row(
                    children: [
                      Radio<String>(
                        value: 'Nam',
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
                        value: 'Nữ',
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
              // Nhận thông tin khuyến mãi
              SwitchListTile(
                value: _acceptPromotions,
                onChanged: (value) {
                  setState(() {
                    _acceptPromotions = value;
                  });
                },
                title: const Text('Nhận thông tin khuyến mãi qua email'),
              ),
              const SizedBox(height: 10),
              // Đồng ý điều khoản
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                            text: 'Điều kiện giao dịch chung',
                            style: TextStyle(
                              color: Colors.blue,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                          TextSpan(text: ' và '),
                          TextSpan(
                            text: 'Chính sách bảo mật thông tin',
                            style: TextStyle(
                              color: Colors.blue,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                          TextSpan(text: ' của Dolia.'),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              // Nút Đăng ký
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
              const SizedBox(width: 20),
              // Liên kết đăng nhập
              Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            const LoginPage(), // Chuyển đến trang đăng nhập
                      ),
                    );
                  },
                  style: TextButton.styleFrom(
                    padding: EdgeInsets
                        .zero, // Để không có padding xung quanh văn bản
                    tapTargetSize: MaterialTapTargetSize
                        .shrinkWrap, // Tối thiểu hóa diện tích nhấn
                  ),
                  child: const Text(
                    'Bạn đã có tài khoản? Đăng nhập.',
                    style: TextStyle(color: Colors.blue, fontSize: 16),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
