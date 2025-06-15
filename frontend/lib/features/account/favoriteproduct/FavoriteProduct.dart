import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FavoriteProductScreen(),
    );
  }
}

class FavoriteProductScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Sản phẩm yêu thích"),
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                // Product image with smaller size
                Image.asset(
                  'assets/Skinqua.png', // Replace with your image asset
                  width: 50, // Adjusted width
                  height: 50, // Adjusted height
                ),
                SizedBox(width: 16),
                // Product details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Skin Aqua Clear White",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        "Sữa Chống Nắng Sunday Skin Aqua Clear White PA++",
                        style: TextStyle(fontSize: 14, color: Colors.black54),
                      ),
                      SizedBox(height: 8),
                      Text(
                        "Dung tích: 55g | Loại da: Da dầu/Da nhạy cảm",
                        style: TextStyle(fontSize: 12, color: Colors.black54),
                      ),
                      SizedBox(height: 8),
                      Text(
                        "150.000 ₫",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          // Handle button action
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red, // Button color
                          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                        ),
                        child: Text(
                          "Mua Online",
                          style: TextStyle(fontSize: 16, color: Colors.white),

                        ),
                      ),
                      SizedBox(height: 16, width: 20,)
                    ],
                  ),
                ),
              ],
            ),
            Spacer(),
            // Buy Online button
          ],
        ),
      ),
    );
  }
}
