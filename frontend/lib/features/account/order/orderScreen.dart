import 'package:flutter/material.dart';

class OrderScreen extends StatefulWidget {
  @override
  _DonHangScreenState createState() => _DonHangScreenState();
}

class _DonHangScreenState extends State<OrderScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int quantity = 1;
  final int price = 150000;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this); // Updated to 5 tabs
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: _buildAppBar(),
        body: Column(
          children: [
            _buildTabBar(),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildEmptyCart(),
                  _justordered(),
                  _orderprocessing(),
                  _success(),
                  _buildCancelledOrders(), // New widget for cancelled orders
                ],
              ),
            ),
          ],
        ),
      );
    }

    /// AppBar phần trên cùng
    AppBar _buildAppBar() {
      return AppBar(
        title: Text('Đơn hàng'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        centerTitle: true,
      );
    }

    /// TabBar riêng bên dưới AppBar
    Widget _buildTabBar() {
      return Material(
        color: Colors.white,
        child: TabBar(
          controller: _tabController,
          isScrollable: true, // Cho phép cuộn
          indicatorColor: Colors.red, // Màu gạch chân
          labelColor: Colors.red, // Màu chữ khi được chọn
          unselectedLabelColor: Colors.black, // Màu chữ khi không được chọn
          tabs: [
            Tab(text: 'Tất cả'),
            Tab(text: 'Mới đặt'),
            Tab(text: 'Đang xử lý'),
            Tab(text: 'Đang vận chuyển'),
            Tab(text: 'Đã hủy'), // Added the new 'Cancelled' tab
          ],
        ),
      );
    }

  Widget _buildEmptyCart() {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Cart empty state
          SizedBox(height: 50),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Image.network(
                    'https://example.com/image.jpg', // Replace with a real image URL
                    width: 100,
                    height: 100,
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Skin Aqua Clear White',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Text('Sữa Chống Nắng Sunday Skin Aqua Clear White PA+++'),
                        Text('Dung tích 55g | Loại da: Da dầu/Da nhạy cảm'),
                      ],
                    ),
                  ),
                  // Corrected the position of the close button inside the Row
                  IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () {
                      // Handle the close button logic here
                    },
                  ),
                ],
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.remove),
                        onPressed: () {
                          setState(() {
                            if (quantity > 1) quantity--;
                          });
                        },
                      ),
                      Text('$quantity'),
                      IconButton(
                        icon: Icon(Icons.add),
                        onPressed: () {
                          setState(() {
                            quantity++;
                          });
                        },
                      ),
                    ],
                  ),
                  Text('x ${price * quantity} đ'),
                ],
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Icon(Icons.location_on),
                  SizedBox(width: 8),
                  Text('Kiểm tra còn hàng tại cơ sở 220 Pasteur'),
                ],
              ),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Tổng thanh toán',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '${price * quantity} đ',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.red),
                  ),
                ],
              ),
              Text('Đã bao gồm VAT'),
            ],
          ),
        ),
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
    );
  }

  Widget _orderprocessing() {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Cart empty state
          SizedBox(height: 50),
          Icon(
            Icons.shopping_cart_outlined,
            size: 100,
            color: Colors.black54,
          ),
          SizedBox(height: 10),
          Center(
            child: Text(
              'Bạn chưa có đơn hàng nào',
              style: TextStyle(fontSize: 16, color: Colors.black54),
            ),
          ),
          SizedBox(height: 20),
          Center(
            child: ElevatedButton(
              onPressed: () {
                // Logic tiếp tục mua sắm
              },
              child: Text('Tiếp tục mua sắm'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              ),
            ),
          ),
          // Suggestion section
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
    );
  }
  Widget _justordered() {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Cart empty state
          SizedBox(height: 50),
          Icon(
            Icons.shopping_cart_outlined,
            size: 100,
            color: Colors.black54,
          ),
          SizedBox(height: 10),
          Center(
            child: Text(
              'Bạn chưa có đơn hàng nào',
              style: TextStyle(fontSize: 16, color: Colors.black54),
            ),
          ),
          SizedBox(height: 20),
          Center(
            child: ElevatedButton(
              onPressed: () {
                // Logic tiếp tục mua sắm
              },
              child: Text('Tiếp tục mua sắm'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              ),
            ),
          ),
          // Suggestion section
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
    );
  }
  Widget _success() {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Cart empty state
          SizedBox(height: 50),
          Icon(
            Icons.shopping_cart_outlined,
            size: 100,
            color: Colors.black54,
          ),
          SizedBox(height: 10),
          Center(
            child: Text(
              'Bạn chưa có đơn hàng nào',
              style: TextStyle(fontSize: 16, color: Colors.black54),
            ),
          ),
          SizedBox(height: 20),
          Center(
            child: ElevatedButton(
              onPressed: () {
                // Logic tiếp tục mua sắm
              },
              child: Text('Tiếp tục mua sắm'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              ),
            ),
          ),
          // Suggestion section
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
    );
  }

  // New method for the "Cancelled Orders" tab
  Widget _buildCancelledOrders() {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 50),
          Icon(
            Icons.cancel_outlined,
            size: 100,
            color: Colors.redAccent,
          ),
          SizedBox(height: 10),
          Center(
            child: Text(
              'Đơn hàng đã hủy',
              style: TextStyle(fontSize: 16, color: Colors.black54),
            ),
          ),
          SizedBox(height: 20),
          Center(
            child: ElevatedButton(
              onPressed: () {
                // Logic for user to take actions
              },
              child: Text('Khám phá các sản phẩm khác'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              ),
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
