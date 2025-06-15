import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class LocationSelectionScreen extends StatefulWidget {
  @override
  _LocationSelectionScreen createState() => _LocationSelectionScreen();
}

class _LocationSelectionScreen extends State<LocationSelectionScreen> {
  // Dữ liệu mẫu
  final Map<String, List<String>> locationData =
  {
    'Quận 1': [
      'Bến Nghé',
      'Bến Thành',
      'Cô Giang',
      'Cầu Kho',
      'Cầu Ông Lãnh',
      'Đa Kao',
      'Nguyễn Cư Trinh',
      'Nguyễn Thái Bình',
      'Phạm Ngũ Lão',
      'Tân Định'
    ],
    'Quận 2': [
      'An Phú',
      'Thảo Điền',
      'Bình An',
      'Bình Trưng Đông',
      'Bình Trưng Tây',
      'Bình Khánh',
      'An Khánh',
      'Thủ Thiêm'
    ],
    'Quận 3': [
      'Phường 1',
      'Phường 2',
      'Phường 3',
      'Phường 4',
      'Phường 5',
      'Phường 6',
      'Phường 7',
      'Phường 8',
      'Phường 9',
      'Phường 10'
    ],
    'Quận 4': [
      'Phường 1',
      'Phường 2',
      'Phường 3',
      'Phường 4',
      'Phường 5',
      'Phường 6',
      'Phường 8',
      'Phường 9',
      'Phường 10',
      'Phường 12',
      'Phường 13',
      'Phường 14',
      'Phường 15',
      'Phường 16',
      'Phường 18'
    ],
    'Quận 5': [
      'Phường 1',
      'Phường 2',
      'Phường 3',
      'Phường 4',
      'Phường 5',
      'Phường 6',
      'Phường 7',
      'Phường 8',
      'Phường 9',
      'Phường 10',
      'Phường 11',
      'Phường 12',
      'Phường 13',
      'Phường 14',
      'Phường 15'
    ],
    'Quận 6': [
      'Phường 1',
      'Phường 2',
      'Phường 3',
      'Phường 4',
      'Phường 5',
      'Phường 6',
      'Phường 7',
      'Phường 8',
      'Phường 9',
      'Phường 10',
      'Phường 11',
      'Phường 12',
      'Phường 13',
      'Phường 14'
    ],
    'Quận 7': [
      'Tân Thuận Đông',
      'Tân Thuận Tây',
      'Bình Thuận',
      'Tân Kiểng',
      'Tân Quy',
      'Phú Thuận',
      'Tân Phong',
      'Tân Hưng',
      'Phú Mỹ',
      'Phú Mỹ Hưng'
    ],
    'Quận 8': [
      'Phường 1',
      'Phường 2',
      'Phường 3',
      'Phường 4',
      'Phường 5',
      'Phường 6',
      'Phường 7',
      'Phường 8',
      'Phường 9',
      'Phường 10',
      'Phường 11',
      'Phường 12',
      'Phường 13',
      'Phường 14',
      'Phường 15',
      'Phường 16'
    ],
    'Quận 9': [
      'Long Bình',
      'Long Phước',
      'Long Thạnh Mỹ',
      'Tân Phú',
      'Hiệp Phú',
      'Tăng Nhơn Phú A',
      'Tăng Nhơn Phú B',
      'Phước Long A',
      'Phước Long B',
      'Trường Thạnh',
      'Long Trường',
      'Phú Hữu'
    ],
    'Quận 10': [
      'Phường 1',
      'Phường 2',
      'Phường 3',
      'Phường 4',
      'Phường 5',
      'Phường 6',
      'Phường 7',
      'Phường 8',
      'Phường 9',
      'Phường 10',
      'Phường 11',
      'Phường 12',
      'Phường 13',
      'Phường 14',
      'Phường 15'
    ],
    'Quận 11': [
      'Phường 1',
      'Phường 2',
      'Phường 3',
      'Phường 4',
      'Phường 5',
      'Phường 6',
      'Phường 7',
      'Phường 8',
      'Phường 9',
      'Phường 10',
      'Phường 11',
      'Phường 12',
      'Phường 13',
      'Phường 14',
      'Phường 15'
    ],
    'Quận 12': [
      'An Phú Đông',
      'Đông Hưng Thuận',
      'Hiệp Thành',
      'Thạnh Lộc',
      'Thạnh Xuân',
      'Tân Chánh Hiệp',
      'Tân Thới Hiệp',
      'Tân Thới Nhất',
      'Trung Mỹ Tây'
    ],
    'Quận Bình Thạnh': [
      'Phường 1',
      'Phường 2',
      'Phường 3',
      'Phường 5',
      'Phường 6',
      'Phường 7',
      'Phường 11',
      'Phường 12',
      'Phường 13',
      'Phường 14',
      'Phường 15',
      'Phường 17',
      'Phường 19',
      'Phường 21',
      'Phường 22',
      'Phường 24',
      'Phường 25',
      'Phường 26',
      'Phường 27',
      'Phường 28'
    ],
    'Quận Tân Bình': ['Phường 1', 'Phường 2',
      'Phường 3', 'Phường 4', 'Phường 5', 'Phường 6',
      'Phường 7', 'Phường 8', 'Phường 9', 'Phường 10',
      'Phường 11', 'Phường 12', 'Phường 13', 'Phường 14',
      'Phường 15'],
    'Quận Phú Nhuận': [
      'Phường 1',
      'Phường 2',
      'Phường 3',
      'Phường 4',
      'Phường 5',
      'Phường 6',
      'Phường 7',
      'Phường 8',
      'Phường 9',
      'Phường 10',
      'Phường 11',
      'Phường 12',
      'Phường 13',
      'Phường 14',
      'Phường 15'
    ],
    'Quận Gò Vấp': [
      'Phường 1',
      'Phường 3',
      'Phường 4',
      'Phường 5',
      'Phường 6',
      'Phường 7',
      'Phường 8',
      'Phường 9',
      'Phường 10',
      'Phường 11',
      'Phường 12',
      'Phường 13',
      'Phường 14',
      'Phường 15',
      'Phường 16',
      'Phường 17'
    ],
    'Quận Tân Phú': [
      'Tân Sơn Nhì',
      'Tân Thành',
      'Tân Thới Hòa',
      'Tân Quý',
      'Tân Thới Nhất',
      'Sơn Kỳ',
      'Phú Thọ Hòa',
      'Phú Trung',
      'Hòa Thạnh'
    ],
    'Quận Bình Tân': [
      'An Lạc',
      'An Lạc A',
      'Bình Hưng Hòa',
      'Bình Hưng Hòa A',
      'Bình Hưng Hòa B',
      'Bình Trị Đông',
      'Bình Trị Đông A',
      'Bình Trị Đông B',
      'Tân Tạo',
      'Tân Tạo A'
    ],
    'Quận Nhà Bè': [
      'Nhơn Đức',
      'Hiệp Phước',
      'Phước Kiển',
      'Phước Lộc',
      'Phước An',
      'Phước Bình',
      'Phước Long'
    ],
    'Quận Hóc Môn': [
      'Bà Điểm',
      'Đông Thạnh',
      'Xuân Thới Thượng',
      'Xuân Thới Đông',
      'Xuân Thới Sơn',
      'Thới Tam Thôn',
      'Tân Hiệp',
      'Trung Chánh',
      'Nhị Bình',
      'Tân Thới Nhì',
      'Tân Xuân',
      'Tân Thới Nhất'
    ],
  };


  String? selectedCity; // Lưu trữ Quận/Thành phố được chọn
  String? selectedDistrict; // Lưu trữ Xã/Phường được chọn
  String _address = 'Vui lòng nhập vị trí của bạn'; // Địa chỉ hiển thị trên Card

  @override
  void initState() {
    super.initState();
    _loadSavedAddress();
  }

  Future<void> _loadSavedAddress() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _address = prefs.getString('saved_address') ?? 'Vui lòng nhập vị trí của bạn';
    });
  }

  // Save the address persistently
  Future<void> _saveAddress(String address) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('saved_address', address);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chọn khu vực của bạn'),
        centerTitle: true,
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back), // Icon quay lại
          onPressed: () {
            _saveAddress(_address); // Lưu địa chỉ trước khi quay lại
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Card hiển thị địa chỉ
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: InkWell(
                onTap: () {},
                child: Card(
                  elevation: 4.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 20.0, right: 20, left: 20, bottom: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.location_on),
                            SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                'Khu vực của bạn chọn hiện tại',
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        Text(
                          _address, // Hiển thị địa chỉ
                          style: TextStyle(
                              fontSize: 12.0, fontWeight: FontWeight.normal),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Chọn Quận/Thành phố',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            DropdownButton<String>(
              value: selectedCity,
              isExpanded: true,
              hint: Text('Chọn Quận/Thành phố'),
              items: locationData.keys.map((city) {
                return DropdownMenuItem(
                  value: city,
                  child: Text(city),
                );
              }).toList(),
                  onChanged: (String? newValue) {
                  setState(() {
                  selectedCity = newValue;
                  selectedDistrict = null; // Reset Xã/Phường khi đổi thành phố
                });
              },
            ),
            SizedBox(height: 16),
            Text(
              'Chọn Xã/Phường',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            DropdownButton<String>(
              value: selectedDistrict,
              isExpanded: true,
              hint: Text('Chọn Xã/Phường'),
              items: selectedCity != null
                  ? locationData[selectedCity]!.map((district) {
                return DropdownMenuItem(
                  value: district,
                  child: Text(district),
                );
              }).toList()
                  : [], // Nếu chưa chọn thành phố thì danh sách trống
              onChanged: (String? newValue) {
                setState(() {
                  selectedDistrict = newValue;
                });
              },
            ),
            SizedBox(height: 32),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    String message;

                    // Kiểm tra các điều kiện và gán thông báo
                    if (selectedCity == null && selectedDistrict == null) {
                      message = 'Vui lòng nhập đầy đủ nội dung';
                    } else if (selectedCity == null) {
                      message = 'Vui lòng chọn Quận/Thành phố';
                    } else if (selectedDistrict == null) {
                      message = 'Vui lòng chọn Phường/Xã';
                    } else {
                      // Cập nhật địa chỉ trên Card
                      _address = 'Địa chỉ: $selectedDistrict, $selectedCity';
                      message = 'Địa chỉ đã được cập nhật';
                      _saveAddress(_address);
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
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding:
                  const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                ),
                child: const Text(
                  'Xác nhận',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
