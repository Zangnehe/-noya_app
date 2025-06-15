import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  final String brandName;

  DetailScreen({required this.brandName});

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
      width: 200, // Adjusted card width
      child: Card(
        elevation: 10,
        shadowColor: Colors.grey.withOpacity(0.5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12), // Rounded corners
        ),
        child: Padding(
          padding: EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 120, // Fixed image height
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    'assets/Skinqua.png', // Replace with actual image path
                    fit: BoxFit.cover, // Scale image to cover the entire area
                  ),
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                title,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 4.0),
              Text(
                description,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 14),
              ),
              SizedBox(height: 8.0),
              Text(
                price,
                style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 4.0),
              Row(
                children: [
                  Icon(Icons.star, color: Colors.orange, size: 16),
                  SizedBox(width: 4),
                  Text(
                    '$rating ($reviewCount)',
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }


}
