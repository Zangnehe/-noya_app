import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AccountInfoScreen extends StatefulWidget {
  @override
  _AccountInfoScreenState createState() => _AccountInfoScreenState();
}

class _AccountInfoScreenState extends State<AccountInfoScreen> {
  String _gender = 'Nam';
  DateTime _selectedDate = DateTime.now();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _Sdt = TextEditingController();
  final TextEditingController _ngaySinh = TextEditingController();

  // Biến lưu trữ tên hiển thị
  String _displayName = 'ThanhDanh';

  @override
  void dispose() {
    _name.dispose();
    _Sdt.dispose();
    _ngaySinh.dispose();
    _dobController.dispose();
    super.dispose();
  }

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
                      _ngaySinh.text =
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

  bool _isValidPhoneNumber(String phone) {
    final RegExp regex = RegExp(r'^(03|05|07|08|09)\d{8}$');
    return regex.hasMatch(phone) && phone.length == 10;
  }

  void _updateAccountInfo() {
    setState(() {
      String message;

      // Kiểm tra các điều kiện và gán thông báo
      if (_name.text.isEmpty && _Sdt.text.isEmpty && _ngaySinh.text.isEmpty) {
        message = 'Vui lòng nhập đầy đủ nội dung';
      } else if(_name.text.isEmpty && _Sdt.text.isEmpty){
        message = 'Vui lòng nhập Tên';
      }
      else if (_Sdt.text.isEmpty) {
        message = 'Vui lòng nhập số điện thoại';
      } else if (_ngaySinh.text.isEmpty) {
        message = 'Vui lòng nhập ngày sinh';
      } else if (!_isValidPhoneNumber(_Sdt.text)) {
        message = 'Số điện thoại không đúng định dạng';
      }
      else {
        message = 'Cập nhật thành công';
        _displayName = _name.text;  // Cập nhật tên hiển thị
      }

      // Hiển thị thông báo
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Thông báo'),
            content: Text(message),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context), // Đóng hộp thoại
                child: Text('Đóng'),
              ),
            ],
          );
        },
      );
    });
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Xác nhận'),
          content: Text('Bạn có muốn xóa tài khoản không?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Hủy'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              }, child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Thông tin tài khoản'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CircleAvatar(
              radius: 40,
              child: Icon(Icons.person, size: 40),
            ),
            SizedBox(height: 8),
            Text(
              _displayName,  // Hiển thị tên mới
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _name,
              decoration: InputDecoration(
                hintText: 'Tên tài khoản',
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _Sdt,
              decoration: InputDecoration(
                hintText: 'Số điện thoại',
              ),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ListTile(
                    title: const Text('Nam'),
                    leading: Radio<String>(
                      value: 'Nam',
                      groupValue: _gender,
                      onChanged: (String? value) {
                        setState(() {
                          _gender = value!;
                        });
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: ListTile(
                    title: const Text('Nữ'),
                    leading: Radio<String>(
                      value: 'Nữ',
                      groupValue: _gender,
                      onChanged: (String? value) {
                        setState(() {
                          _gender = value!;
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            TextField(
              controller: _ngaySinh,
              readOnly: true,
              onTap: () => _showDatePicker(context),
              decoration: InputDecoration(
                hintText: 'Ngày sinh',
              ),
            ),
            SizedBox(height: 16),
            Center(
              child: ElevatedButton(
                onPressed: _updateAccountInfo,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                ),
                child: const Text(
                  'Cập nhật',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(height: 8),
            TextButton(
              onPressed: () {_showLogoutDialog(context);},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              ),
              child: Text(
                'Xóa tài khoản',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
