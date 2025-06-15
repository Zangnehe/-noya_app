import 'package:flutter/material.dart';


class VoucherScreen extends StatelessWidget {
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
                  hintText: "Voucher",
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
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          VoucherCard(
            imageUrl: "https://via.placeholder.com/100",
            description: "Giảm 50% cho lần mua hàng đầu tiên trên Dolia",
          ),
          SizedBox(height: 16),
          VoucherCard(
            imageUrl: "https://via.placeholder.com/100",
            description: "Giảm 25% cho tất cả sản phẩm",
          ),
        ],
      ),
    );
  }
}

class VoucherCard extends StatelessWidget {
  final String imageUrl;
  final String description;

  VoucherCard({required this.imageUrl, required this.description});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          children: [
            Image.network(
              imageUrl,
              height: 80,
              width: 80,
              fit: BoxFit.cover,
            ),
            SizedBox(width: 16),
            Expanded(
              child: Text(
                description,
                style: TextStyle(fontSize: 16),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
