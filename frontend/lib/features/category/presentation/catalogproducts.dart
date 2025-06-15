import 'package:flutter/material.dart';

class catalogproducts extends StatelessWidget {
  final String category;
  catalogproducts(this.category);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          decoration: InputDecoration(
            hintText: 'Tìm kiếm',
            prefixIcon: Icon(Icons.search),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide.none,
            ),
          ),
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Color(0xFF3CABF3),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Wrap(
              spacing: 20.0, // Khoảng cách giữa các thẻ
              runSpacing: 20.0, // Khoảng cách giữa các hàng
              alignment: WrapAlignment.center, // Canh giữa các thẻ
              children: [
                _buildProductCard(
                  'Obagi',
                  'Kem Dưỡng Obagi Retinal 1.0% Trẻ Hóa Da, Ngừa Mụn',
                  '1,480,000đ',
                  4.0,
                  12,
                ),
                _buildProductCard(
                  'Skin Aqua UV Body',
                  'Sữa Chống Nắng Sunday Skin Aqua UV Body PA+++',
                  '120,000đ',
                  4.7,
                  115,
                ),
                _buildProductCard(
                  'Skin Aqua UV Body',
                  'Sữa Chống Nắng Sunday Skin Aqua UV Body PA+++',
                  '120,000đ',
                  4.7,
                  115,
                ),
                _buildProductCard(
                  'Obagi',
                  'Kem Dưỡng Obagi Retinal 1.0% Trẻ Hóa Da, Ngừa Mụn',
                  '1,480,000đ',
                  4.0,
                  12,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductCard(String title, String description, String price, double rating, int reviewCount) {
    return Container(
      width: 220, // Đặt chiều rộng của mỗi thẻ
      height: 300,
      child: Card(
        elevation: 10,
        shadowColor: Colors.grey.withOpacity(1), // Màu của viền mờ
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15), // Bo tròn góc của thẻ
        ),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image.network(
              // image, width: 160,
              // // Đặt chiều rộng của ảnh cho phù hợp với thẻ
              // height: 100, // Đặt chiều cao của ảnh
              // fit: BoxFit.cover, // Đảm bảo ảnh vừa khung và cắt nếu cần
              // ),
              // SizedBox(height: 8.0),
              Text(
                title,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8.0),
              Text(
                description,
                softWrap: true, // Tự động xuống hàng khi văn bản quá dài
              ),
              SizedBox(height: 8.0),
              Text(price, style: TextStyle(color: Colors.red)),
              SizedBox(height: 8.0),
              Row(
                children: [
                  Icon(Icons.star, color: Colors.yellow),
                  Text('$rating ($reviewCount)'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
