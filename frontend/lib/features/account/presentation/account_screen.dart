import 'package:flutter/material.dart';
import 'package:frontend/core/providers/auth_provider.dart';
import 'package:frontend/features/authentication/presentation/login_screen.dart';
import 'package:provider/provider.dart';
import 'package:frontend/features/account/location/locationScreen.dart';
import 'package:frontend/features/account/review/reviewscreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../changepassword/changePasswordScreen.dart';
import '../favoriteproduct/FavoriteProduct.dart';
import '../newproduct/newproductScreen.dart';
import '../order/orderScreen.dart';
import '../proFile/profileScreen.dart';
import '../trademark/trademarkscreen.dart';
import '../voucher/voucherScreen.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  bool _isSwitched = true;
  String _address = 'Vui lòng nhập vị trí của bạn';

  @override
  void initState() {
    super.initState();
    _loadSavedAddress();
  }

  Future<void> _loadSavedAddress() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _address =
          prefs.getString('saved_address') ?? 'Vui lòng nhập vị trí của bạn';
    });
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Xác nhận'),
          content: Text('Bạn có muốn đăng xuất không?'),
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
              },
              child: Text('OK'),
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
        title: TextField(
          decoration: InputDecoration(
            hintText: 'Quản lý tài khoản',
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.search),
            filled: true,
            fillColor: Colors.grey[300],
          ),
        ),
        backgroundColor: Color.fromARGB(255, 210, 180, 140),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Color.fromARGB(255, 210, 180, 140),
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Đăng nhập',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(width: 20),
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Đăng ký',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: InkWell(
                      onTap: () async {
                        final updatedAddress = await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    LocationSelectionScreen()));
                        if (updatedAddress != null) {
                          setState(() {
                            _address = updatedAddress.toString();
                          });
                        }
                      },
                      child: Card(
                        elevation: 4.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(
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
                                _address,
                                style: TextStyle(
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.normal),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.new_releases,
                                color: Colors.green),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => OrderScreen()));
                            },
                          ),
                          const Text('Mới đặt'),
                        ],
                      ),
                      Column(
                        children: [
                          IconButton(
                            icon:
                                const Icon(Icons.pending, color: Colors.green),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => OrderScreen()));
                            },
                          ),
                          const Text('Đang xử lý'),
                        ],
                      ),
                      Column(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.check_circle,
                                color: Colors.green),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => OrderScreen()));
                            },
                          ),
                          const Text('Thành công'),
                        ],
                      ),
                      Column(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.cancel, color: Colors.green),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => OrderScreen()));
                            },
                          ),
                          const Text('Đã huỷ'),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 16.0),
                  const Text(
                    'Thông tin',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.person),
                            onPressed: () {
                              Navigator.pushNamed(context, '/info');
                            },
                          ),
                          const Text('Cá nhân'),
                        ],
                      ),
                      Column(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.favorite),
                            onPressed: () {
                              Navigator.pushNamed(context, '/favorite');
                            },
                          ),
                          const Text('Yêu thích'),
                        ],
                      ),
                      Column(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.star),
                            onPressed: () {
                              Navigator.pushNamed(context, '/review');
                            },
                          ),
                          const Text('Đánh giá'),
                        ],
                      ),
                      Column(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.branding_watermark),
                            onPressed: () {
                              Navigator.pushNamed(context, '/trademark');
                            },
                          ),
                          const Text('Thương hiệu'),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 16.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.card_giftcard),
                            onPressed: () {
                              Navigator.pushNamed(context, '/voucher');
                            },
                          ),
                          const Text('Voucher'),
                        ],
                      ),
                      Column(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.new_releases),
                            onPressed: () {
                              Navigator.pushNamed(context, '/newproduct');
                            },
                          ),
                          const Text('Sản phẩm mới'),
                        ],
                      ),
                      Column(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.visibility),
                            onPressed: () {
                              Navigator.pushNamed(context, '/changePass');
                            },
                          ),
                          const Text('Đổi mật khẩu'),
                        ],
                      ),
                      Column(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.local_offer),
                            onPressed: () {
                              // Hành động khi nhấn nút
                            },
                          ),
                          const Text('Khuyến mãi'),
                        ],
                      ),
                    ],
                  ),
                  Divider(),
                  const SizedBox(height: 16.0),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SwitchListTile(
                          title: const Text('Cho phép nhận thông báo'),
                          value: _isSwitched,
                          onChanged: (bool value) {
                            setState(() {
                              _isSwitched = value;
                            });
                          },
                          activeColor: Color.fromARGB(255, 210, 180, 140),
                          inactiveThumbColor: Colors.grey,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: TextButton.icon(
                                onPressed: () {
                                  Provider.of<AuthProvider>(context,
                                          listen: false)
                                      .logout();
                                  Navigator.push(
                                      context, MaterialPageRoute(builder: (context)=>LoginPage()));
                                },
                                icon: const Icon(Icons.logout),
                                label: const Text('Đăng xuất'),
                                style: TextButton.styleFrom(
                                  foregroundColor: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
      //       label: 'Trang chủ',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.list),
      //       label: 'Danh mục',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.notifications),
      //       label: 'Thông báo',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.account_circle),
      //       label: 'Tài khoản',
      //     ),
      //   ],
      // ),
