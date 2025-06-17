import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:frontend/core/abstracts/auth_service.dart';
import 'package:frontend/core/config/constants.dart';
import 'package:frontend/core/providers/auth_provider.dart';
import 'package:frontend/core/services/auth/auth_service.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:provider/provider.dart';

import '../../account/presentation/account_screen.dart';
import '../../cart/presentation/cart/cart_screen.dart';
import '../../category/presentation/category_screen.dart';
import '../../notification/presentation/notification_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<dynamic> products = []; // Danh sách sản phẩm
  List<dynamic> categories = []; // Danh sách danh mục

  @override
  void dispose() {
    super.dispose();
  }

  // Kiểm tra trạng thái đăng nhập
  void checkLoginStatus() {
    final authProvider =
        Provider.of<AuthProvider>(context, listen: false); // Lấy authProvider
    authProvider.loadUser().then((_) {
      print(authProvider.currentUser);      if (authProvider.currentUser == null) {
        Navigator.pushReplacementNamed(context, '/login');
      }
    });
  }

  Future<void> fetchProducts() async {
    try {
      final response =
          await http.get(Uri.parse('${backendUrl}/api/v1/product'));
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        setState(() {
          products = json['data'] as List; // Ép kiểu thành List
        });
      } else {
        print('Lỗi khi tải dữ liệu sản phẩm: ${response.statusCode}');
      }
    } catch (e) {
      print('Lỗi kết nối: $e');
    }
  }

  Future<void> fetchCategories() async {
    try {
      final response =
          await http.get(Uri.parse('http://192.168.2.25:3001/api/v1/category'));
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        setState(() {
          categories = json['data'] as List; // Ép kiểu thành List
        });
      } else {
        print('Lỗi khi tải dữ liệu danh mục: ${response.statusCode}');
      }
    } catch (e) {
      print('Lỗi kết nối: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    // checkLoginStatus();
    fetchProducts();
    fetchCategories(); // Gọi hàm để tải danh mục
  }

  // int _selectedIndex = 0;
  // static List<Widget> _widgetOptions = <Widget>[
  //   CategoryScreen(),
  //   CartScreen(),
  //   NotificationScreen(),
  //   AccountScreen(),
  // ];
  //
  // void _onItemTapped(int index) {
  //   setState(() {
  //     _selectedIndex = index;
  //   });
  //   // Điều hướng đến các màn hình khác nhau dựa trên chỉ số đã chọn
  // }

  final List<String> bannerImages = [
    'assets/banner1.jpg',
    'assets/banner2.jpg',
    'assets/banner3.jpg',
    'assets/banner4.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 210, 180, 140),
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: 50.0,
            height: 50.0,
            decoration: BoxDecoration(
              color: Colors.lightBlueAccent,
              shape: BoxShape.circle,
            ),
            child: ClipOval(
              child: Image.asset(
                'assets/logo_N_den.jpg',
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        title: TextField(
          decoration: InputDecoration(
            hintText: 'Tìm kiếm',
            prefixIcon: Icon(Icons.search),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
              borderSide: BorderSide.none,
            ),
            filled: true,
            fillColor: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.location_on),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.inventory_2),
            onPressed: () {},
          ),
        ],
      ),
      body: Container(
        color: Color.fromARGB(255, 210, 180, 140),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CarouselSlider(
                options: CarouselOptions(
                  height: 120.0,
                  autoPlay: true,
                  enlargeCenterPage: true,
                  viewportFraction: 0.95,
                  aspectRatio: 16 / 9,
                  autoPlayInterval: Duration(seconds: 3),
                ),
                items: bannerImages.map((imagePath) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 2.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          image: DecorationImage(
                            image: AssetImage(imagePath),
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
              // Mở đầu
              Padding(
                padding: const EdgeInsets.only(top: 10.0, bottom: 10),
                child: GridView.count(
                  shrinkWrap: true,
                  crossAxisCount: 4,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 16,
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    _buildCategoryItem('Danh Mục', Color.fromARGB(255, 32, 121, 63), Color(0xFFB6E2C9), Icons.grid_view),
                    _buildCategoryItem('Hàng Mới', Color.fromARGB(255, 143, 82, 186), Color(0xFFEEDCFB), Icons.fiber_new_outlined),
                    _buildCategoryItem('Đánh Giá', Color.fromARGB(255, 190, 135, 98), Color(0xFFFFE9D6), Icons.star),
                    _buildCategoryItem('Kiểm Tra Loại Da', Color.fromARGB(255, 31, 96, 143), Color.fromARGB(255, 148, 169, 185), Icons.spa),
                    _buildCategoryItem('Hỗ Trợ', Color.fromARGB(255, 222, 109, 109), Color(0xFFFFF1F1), Icons.support_agent),
                    _buildCategoryItem('Cẩm Nang', Color.fromARGB(255, 196, 204, 110), Color(0xFFF5F8D0), Icons.auto_stories),
                    _buildCategoryItem('Khuyến Mãi', Color.fromARGB(255, 70, 140, 149), Color(0xFFD0F0F5), Icons.local_offer),
                    _buildCategoryItem('Chat', Color.fromARGB(255, 83, 95, 174), Color(0xFFDDE1F2), Icons.chat),
                  ],
                ),
              ),

// Danh mục
              Container(
                color: Colors.grey[200],
                padding: EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Danh mục',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 210, 180, 140)),
                    ),
                    SizedBox(height: 10),
                    SizedBox(
                      height: 320,
                      child: GridView.builder(
                        scrollDirection: Axis.horizontal,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10.0,
                          mainAxisSpacing: 10.0,
                          childAspectRatio: 1.5,
                        ),
                        itemCount: categories.length,
                        itemBuilder: (context, index) {
                          final category = categories[index];
                          return Container(
                            width: 100,
                            height: 150,
                            decoration: BoxDecoration(
                              color: Colors
                                  .primaries[index % Colors.primaries.length]
                                  .shade100,
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: Column(
                              children: [
                                SizedBox(
                                  width: 100,
                                  height: 100,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(15.0)),
                                    child: Image.network(
                                      category['icon_url'] ?? '',
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        return Icon(Icons.error);
                                      },
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    category['name'] ?? '',
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),

// Thương hiệu
              Container(
                color: Colors.grey[200],
                padding: EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Thương hiệu',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 210, 180, 140)),
                    ),
                    SizedBox(height: 10),
                    SizedBox(
                      height: 150,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 6, // Số lượng item
                        itemBuilder: (context, index) {
                          List<Map<String, String>> brandData = [
                            {
                              'image': 'assets/logo.jpg',
                              'nameImage': 'assets/logo-cocoon.jpg'
                            },
                          ];

                          String brandImagePath =
                              brandData[index % brandData.length]['image']!;
                          String brandNameImagePath =
                              brandData[index % brandData.length]['nameImage']!;

                          return Container(
                            width: 150,
                            margin: EdgeInsets.symmetric(horizontal: 5.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                  15.0), // Bo tròn góc cho item
                            ),
                            child: Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(15.0),
                                  child: Image.asset(
                                    brandImagePath,
                                    fit: BoxFit.cover,
                                    width: 150,
                                    height: 150,
                                  ),
                                ),
                                Positioned(
                                  bottom: 10,
                                  left: 0,
                                  right: 0,
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8.0),
                                      child: Image.asset(
                                        brandNameImagePath,
                                        width: 100,
                                        height: 30,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),

              // Gợi ý cho bạn
              Container(
                color: Colors.grey[200],
                padding: EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Gợi ý cho bạn',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 210, 180, 140)),
                    ),
                    SizedBox(height: 10),
                    SizedBox(
                      height: 700,
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10.0,
                          mainAxisSpacing: 5.0,
                          childAspectRatio: 0.6,
                        ),
                        itemCount: products.length,
                        itemBuilder: (context, index) {
                          final product = products[index]
                              as Map<String, dynamic>; // Ép kiểu thành Map
                          return Container(
                            height: 150,
                            margin: EdgeInsets.symmetric(vertical: 5.0),
                            decoration: BoxDecoration(
                              color:
                                  Colors.accents[index % Colors.accents.length],
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: Column(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(15.0)),
                                    child: Image.network(
                                      product['image_url'] as String,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: Text('${product['price']} đ',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold)),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: Text(product['name'] as String),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: Row(
                                          children: [
                                            Text('Đánh giá: ',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            Text('⭐' *
                                                (product['rating'] as double)
                                                    .toInt()),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      // Center(
      //   child: _widgetOptions.elementAt(_selectedIndex),
      // ),
      // bottomNavigationBar: BottomNavigationBar(
      //   items: const [
      //     BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Trang chủ'),
      //     BottomNavigationBarItem(
      //         icon: Icon(Icons.category), label: 'Danh mục'),
      //     BottomNavigationBarItem(
      //         icon: Icon(Icons.shopping_cart), label: 'Giỏ hàng'),
      //     BottomNavigationBarItem(
      //         icon: Icon(Icons.notifications), label: 'Thông báo'),
      //     BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Tài khoản'),
      //   ],
      //   currentIndex: _selectedIndex,
      //   onTap: _onItemTapped,
      //   selectedItemColor: Colors.black,
      //   unselectedItemColor: Colors.black54,
      //   showUnselectedLabels: true,
      //   showSelectedLabels: true,
      // ),
    );
  }

  Widget _buildCategoryItem(String title, Color startColor, Color endColor, IconData icon) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Icon trong item
        Container(
          width: 55.0,
          height:55.0,
          decoration: BoxDecoration(
           gradient: LinearGradient(
            colors: [startColor, endColor],
            begin: Alignment.topLeft,
            end: Alignment.bottomLeft,
            ),
            borderRadius: BorderRadius.circular(25),
          ),
          child: Icon(
            icon,
            color: const Color.fromARGB(119, 0, 0, 0),
            size: 30.0,
          ),
        ),
        SizedBox(height: 8.0),
        Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 10.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
