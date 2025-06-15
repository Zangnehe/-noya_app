import 'package:flutter/material.dart';
import 'package:frontend/features/account/trademark/productTrademark.dart';

class BrandScreen extends StatefulWidget {
  @override
  _BrandScreenState createState() => _BrandScreenState();
}

class _BrandScreenState extends State<BrandScreen> {
  final ScrollController _scrollController = ScrollController();
  final Map<String, GlobalKey> _brandKeys = {
    '0-9': GlobalKey(),
    'A': GlobalKey(),
    'B': GlobalKey(),
    'C': GlobalKey(),
    'D': GlobalKey(),
    'E': GlobalKey(),
    'F': GlobalKey(),
    'G': GlobalKey(),
    'H': GlobalKey(),
    'I': GlobalKey(),
    'J': GlobalKey(),
    'K': GlobalKey(),
    'L': GlobalKey(),
    'M': GlobalKey(),
    'N': GlobalKey(),
    'O': GlobalKey(),
    'P': GlobalKey(),
    'Q': GlobalKey(),
    'R': GlobalKey(),
    'S': GlobalKey(),
    'T': GlobalKey(),
    'U': GlobalKey(),
    'V': GlobalKey(),
    'W': GlobalKey(),
    'X': GlobalKey(),
    'Y': GlobalKey(),
    'Z': GlobalKey(),
  };

  void _scrollToBrand(String letter) {
    final key = _brandKeys[letter];
    if (key != null) {
      Scrollable.ensureVisible(key.currentContext!, duration: Duration(seconds: 1));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Thương Hiệu'),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              controller: _scrollController,
              children: _buildBrandSections(),
            ),
          ),
          _buildBottomBar(),
        ],
      ),
    );
  }

  List<Widget> _buildBrandSections() {
    List<Widget> sections = [];
    sections.add(_buildBrandSection('0-9', '16Plan', 'assets/Skinqua.png'));
    sections.add(_buildBrandSection('0-9', '50 Megumi', 'assets/Skinqua.png'));
    sections.add(_buildBrandSection('A', 'ABone', 'assets/Skinqua.png'));
    sections.add(_buildBrandSection('B', 'BNNG', 'assets/Skinqua.png'));
    return sections;
  }

  Widget _buildBrandSection(String letter, String brand1, String image1, [String? brand2, String? image2]) {
    return Column(
      key: _brandKeys[letter],
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            letter,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        _buildBrandItem(brand1, image1),
        if (brand2 != null && image2 != null) _buildBrandItem(brand2, image2),
      ],
    );
  }

  Widget _buildBrandItem(String brand, String image) {
    return GestureDetector(
      onTap: () {
        // Điều hướng đến trang chi tiết
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DetailScreen(brandName: brand)),
        );
      },
      child: Card(
        elevation: 4,
        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: ListTile(
          contentPadding: EdgeInsets.all(16),
          leading: Image.asset(image, width: 50, height: 50, fit: BoxFit.cover),
          title: Text(brand),
        ),
      ),
    );
  }

  Widget _buildBottomBar() {
    return Container(
      height: 70, // Chiều cao lớn hơn cho thanh điều hướng dưới cùng
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: _brandKeys.keys
              .map(
                (letter) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: ElevatedButton(
                onPressed: () {
                  _scrollToBrand(letter);
                },
                child: Text(letter),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue, // Màu sắc cho nút
                  foregroundColor: Colors.white, // Màu chữ
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12), // Kích thước nút lớn hơn
                  textStyle: TextStyle(
                    fontSize: 16, // Cỡ chữ lớn hơn
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          )
              .toList(),
        ),
      ),
    );
  }
}

