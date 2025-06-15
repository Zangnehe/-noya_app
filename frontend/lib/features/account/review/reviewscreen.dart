import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ReviewScreen(),
    );
  }
}

class ReviewScreen extends StatefulWidget {
  @override
  _ReviewScreenState createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          "Đánh giá",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
      body: Column(
        children: [
          Container(
            color: Colors.white,
            child: TabBar(
              controller: _tabController,
              indicatorColor: Colors.red,
              indicatorWeight: 2.0,
              labelColor: Colors.red,
              unselectedLabelColor: Colors.black54,
              tabs: [
                Tab(text: "Kiện chưa đánh giá"),
                Tab(text: "Kiện đã đánh giá"),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                // Tab 1: Kiện chưa đánh giá
                SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.star, color: Colors.orange, size: 100),
                      SizedBox(height: 16),
                      Text(
                        "Bạn chưa có đánh giá nào",
                        style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          // Handle "Tiếp tục mua sắm" action
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.lightBlue,
                          padding: EdgeInsets.symmetric(
                              vertical: 12, horizontal: 24),
                        ),
                        child: Text(
                          "Tiếp tục mua sắm",
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                      SizedBox(height: 32),
                      Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Có thể bạn thích',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                ProductCard(
                                  name: 'Obagi',
                                  price: '1.480.000đ',
                                  rating: 4.0,
                                  reviews: 12,
                                  description: 'Kem Dưỡng Obagi Retinal 1.0%',
                                ),
                                ProductCard(
                                  name: 'Skin Aqua UV Body',
                                  price: '120.000đ',
                                  rating: 4.7,
                                  reviews: 10,
                                  description: 'Sữa Chống Nắng Skin Aqua UV',
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                // Tab 2: Kiện đã đánh giá
                Center(
                  child: Text("Không có đánh giá nào"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final String name;
  final String price;
  final double rating;
  final int reviews;
  final String description;

  ProductCard({
    required this.name,
    required this.price,
    required this.rating,
    required this.reviews,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Hành động khi nhấn vào card
      },
      child: Card(
        elevation: 4, // Đổ bóng cho Card
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(8),
                ),
                alignment: Alignment.center,
                child: Text(
                  'Hình ảnh',
                  style: TextStyle(color: Colors.black54),
                ),
              ),
              SizedBox(height: 8),
              Text(
                name,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(price, style: TextStyle(color: Colors.red)),
              Row(
                children: [
                  Icon(Icons.star, size: 14, color: Colors.orange),
                  SizedBox(width: 4),
                  Text(
                    '$rating ($reviews)',
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              ),
              Text(
                description,
                style: TextStyle(fontSize: 12, color: Colors.black54),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
