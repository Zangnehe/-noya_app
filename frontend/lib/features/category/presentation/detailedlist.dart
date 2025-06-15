import 'package:flutter/material.dart';
import 'package:frontend/features/category/presentation/catalogproducts.dart';

class detailedList extends StatelessWidget {
  final List<Map<String, String>> cards = [
    {'image': 'https://example.com/image1.jpg', 'text': 'Card 1'},
    {'image': 'https://example.com/image2.jpg', 'text': 'Card 2'},
    {'image': 'https://example.com/image3.jpg', 'text': 'Card 3'},
    {'image': 'https://example.com/image4.jpg', 'text': 'Card 4'},
  ];

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
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: SizedBox(
              height: 250,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: cards.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Card(
                      elevation: 4,
                      shadowColor: Colors.grey.withOpacity(1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  catalogproducts(cards[index]['text']!),
                            ),
                          );
                        },
                        child: Container(
                          width: 170,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Expanded(
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(12),
                                    topRight: Radius.circular(12),
                                  ),
                                  child: Image.network(
                                    cards[index]['image']!,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Center(
                                        child:
                                            Icon(Icons.broken_image, size: 50),
                                      );
                                    },
                                    loadingBuilder:
                                        (context, child, loadingProgress) {
                                      if (loadingProgress == null) return child;
                                      return Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    },
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  cards[index]['text']!,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Divider(),
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

  Widget _buildProductCard(String title, String description, String price,
      double rating, int reviewCount) {
    return Container(
      width: 170, // Đặt chiều rộng của mỗi thẻ
      height: 280,
      child: Card(
        elevation: 10,
        shadowColor: Colors.grey.withOpacity(1), // Màu của viền mờ
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15), // Bo tròn góc của thẻ
        ),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Bạn có thể bỏ ghi chú để hiển thị hình ảnh nếu cần
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
