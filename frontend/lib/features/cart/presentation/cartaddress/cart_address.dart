import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontend/features/cart/presentation/cartconfirm/cart_confirm.dart';
import 'package:frontend/features/cart/presentation/cart/cart_screen.dart';

class AddressScreen extends StatefulWidget {
  @override
  _AddressScreenState createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _houseController = TextEditingController();

  String _selectedProvince = '';
  String _selectedCity = '';

  // Data for provinces and their cities
  final Map<String, List<String>> _provinceToCities = {
    'Hồ Chí Minh': ['Quận 1','Quận 2', 'Quận 3','Quận 4',
      'Quận 5','Quận 6','Quận 7','Quận 8', 'Thủ Đức','Bình Chánh','Củ Chi'],
  };

  @override
  void dispose() {
    _phoneController.dispose();
    _nameController.dispose();
    _houseController.dispose();
    super.dispose();
  }

  void _showCustomDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Text(
                  message,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              Divider(height: 1, thickness: 1),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  'Đồng ý',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Địa chỉ nhận hàng'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Số điện thoại
              TextFormField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                decoration: InputDecoration(
                  labelText: 'Số điện thoại',
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Vui lòng nhập số điện thoại';
                  } else if (!RegExp(r'^(0[3|5|7|8|9])+([0-9]{8})$').hasMatch(value)) {
                    return 'Vui lòng nhập số điện thoại hợp lệ';
                  }
                  return null;
                },
              ),

              SizedBox(height: 16),
              // Họ tên
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Họ tên',
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Vui lòng nhập họ tên';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              // Tỉnh Dropdown
              DropdownButtonFormField<String>(
                value: _selectedProvince.isEmpty ? null : _selectedProvince,
                items: _provinceToCities.keys.map((province) {
                  return DropdownMenuItem(
                    value: province,
                    child: Text(province),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedProvince = value!;
                    _selectedCity = ''; // Reset city when province changes
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Thành phố',
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng chọn Thành phố';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              // Thành phố Dropdown
              DropdownButtonFormField<String>(
                value: _selectedCity.isEmpty ? null : _selectedCity,
                items: _selectedProvince.isNotEmpty
                    ? _provinceToCities[_selectedProvince]!.map((city) {
                  return DropdownMenuItem(
                    value: city,
                    child: Text(city),
                  );
                }).toList()
                    : [],
                onChanged: (value) {
                  setState(() {
                    _selectedCity = value!;
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Quận',
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng chọn Quận';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              // Quốc gia (khóa "Việt Nam")
              TextFormField(
                initialValue: 'Việt Nam',
                enabled: false,
                decoration: InputDecoration(
                  labelText: 'Quốc gia',
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              SizedBox(height: 16),
              // Số nhà + Tên đường
              TextFormField(
                controller: _houseController,
                decoration: InputDecoration(
                  labelText: 'Số nhà + Tên đường',
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Vui lòng nhập Số nhà + Tên đường';
                  } else if (!RegExp(r'^(?=.*\d)(?=.*[a-zA-Z])').hasMatch(value)) {
                    return 'Số nhà + Tên đường phải chứa cả số và chữ';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              Spacer(),
              // Nút tiếp tục
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => OrderConfirmationScreen()),
                      );
                    } else {
                      _showCustomDialog(
                          'Vui lòng điền đầy đủ thông tin và kiểm tra lại');
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: Text(
                    'Tiếp tục',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
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
