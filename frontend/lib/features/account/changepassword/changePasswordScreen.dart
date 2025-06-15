import 'package:flutter/material.dart';

class ChangePasswordScreen extends StatefulWidget {
  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _oldPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  void _changePassword() {
    if (_oldPasswordController.text.isNotEmpty &&
        _newPasswordController.text.isNotEmpty &&
        _confirmPasswordController.text.isNotEmpty) {
      if (_newPasswordController.text == _confirmPasswordController.text) {
        // Logic to change the password
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Thông báo'),
              content: Text('Đổi mật khẩu thành công'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('Đóng'),
                ),
              ],
            );
          },
        );
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Thông báo'),
              content: Text('Mật khẩu mới không khớp'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('Đóng'),
                ),
              ],
            );
          },
        );
      }
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Thông báo'),
            content: Text('Vui lòng nhập đầy đủ thông tin'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('Đóng'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Đổi mật khẩu'),
        centerTitle: true,
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _oldPasswordController,
              decoration: InputDecoration(labelText: 'Nhập mật khẩu cũ'),
              obscureText: true,
            ),
            TextField(
              controller: _newPasswordController,
              decoration: InputDecoration(labelText: 'Nhập mật khẩu mới'),
              obscureText: true,
            ),
            TextField(
              controller: _confirmPasswordController,
              decoration: InputDecoration(labelText: 'Nhập lại mật khẩu mới'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _changePassword(),
              child: Text('Cập nhật'),
              style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
                foregroundColor: Colors.white
              ),
            ),
          ],
        ),
      ),
    );
  }
}
