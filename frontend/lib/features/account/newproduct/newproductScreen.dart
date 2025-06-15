import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ProductGridScreen(),
    );
  }
}

class ProductGridScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        title: Row(
          children: [
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 10),
                  prefixIcon: Icon(Icons.search, color: Colors.black54),
                  hintText: "Sản phẩm mới",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                  fillColor: Colors.white,
                  filled: true,
                ),
              ),
            ),
            SizedBox(width: 10),
            Icon(Icons.shopping_cart, color: Colors.white),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: GridView.builder(
          itemCount: products.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio: 0.7,
          ),
          itemBuilder: (context, index) {
            return ProductCard(product: products[index]);
          },
        ),
      ),
    );
  }
}

class Product {
  final String imageUrl;
  final String name;
  final String price;
  final String description;
  final double rating;
  final int reviews;

  Product({
    required this.imageUrl,
    required this.name,
    required this.price,
    required this.description,
    required this.rating,
    required this.reviews,
  });
}

final List<Product> products = [
  Product(
    imageUrl: "assets/Skinqua.png",
    name: "Obagi",
    price: "1.480.000đ",
    description: "Kem Dưỡng Obagi Retinal 1.0% Trẻ Hóa Da, Ngừa Mụn",
    rating: 4.0,
    reviews: 12,
  ),
  Product(
    imageUrl: "assets/Skinqua.png",
    name: "Skin Aqua UV Body",
    price: "120.000đ",
    description: "Sữa Chống Nắng Sunday Skin Aqua UV Body PA+++",
    rating: 4.7,
    reviews: 12,
  ),
  // Thêm các sản phẩm khác nếu cần
];

class ProductCard extends StatelessWidget {
  final Product product;

  ProductCard({required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              product.imageUrl,
              height: 50,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 8),
            Text(
              product.name,
              style: TextStyle(fontWeight: FontWeight.bold),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 4),
            Text(
              product.price,
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4),
            Text(
              product.description,
              style: TextStyle(fontSize: 12, color: Colors.black54),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 4),
            Row(
              children: [
                Icon(Icons.star, color: Colors.orange, size: 16),
                SizedBox(width: 4),
                Text(
                  '${product.rating} (${product.reviews})',
                  style: TextStyle(fontSize: 12),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
