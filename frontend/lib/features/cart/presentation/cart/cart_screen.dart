import 'package:flutter/material.dart';
import 'package:frontend/features/cart/data/models/cart_model.dart';
import 'package:frontend/features/cart/presentation/cartaddress/cart_address.dart';
import 'package:frontend/features/cart/presentation/cart/cart_item.dart';
import 'package:frontend/features/home/presentation/home_screen.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<int> quantities = [1]; // Product quantities
  List<int> pricePerItem = [150000]; // List of prices per item
  List<String> items = ['Skin Aqua Clear White']; // List of item names

  // Calculate the total price dynamically based on quantities and prices
  int get totalPrice {
    int total = 0;
    for (int i = 0; i < quantities.length; i++) {
      total += quantities[i] * pricePerItem[i];
    }
    return total;
  }

  // Update the quantity of a specific item
  void updateQuantity(int index, int newQuantity) {
    setState(() {
      quantities[index] = newQuantity;
    });
  }

  // Remove the item from the cart
  void removeItem(int index) {
    setState(() {
      quantities.removeAt(index); // Remove the item at the specified index
      items.removeAt(index); // Remove the item from the list
      pricePerItem.removeAt(index); // Remove the price at the specified index
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Giỏ hàng'),
        foregroundColor: Colors.white,
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: quantities.isEmpty
                ? Center(
              child: Text(
                'Giỏ hàng không có sản phẩm',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            )
                : ListView.builder(
              padding: EdgeInsets.all(16.0),
              itemCount: quantities.length,
              itemBuilder: (context, index) {
                return CartItem(
                  quantity: quantities[index],
                  onQuantityChanged: (newQuantity) {
                    updateQuantity(index, newQuantity);
                  },
                  onDelete: () {
                    _showDeleteDialog(
                        index); // Show confirmation dialog before deletion
                  }, product: null,
                );
              },
            ),
          ),
          Divider(height: 1, color: Colors.grey),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (quantities.isNotEmpty)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Tổng thanh toán',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            '${totalPrice.toString()} đ',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.red,
                            ),
                          ),
                          Text(
                            'Đã bao gồm VAT',
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                        ],
                      ),
                    ],
                  ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: quantities.isEmpty
                      ? null // Disable button when cart is empty
                      : () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AddressScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: quantities.isEmpty
                        ? Colors.grey // Set a disabled color for the button
                        : Colors.orange,
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                  ),
                  child: Text(
                    quantities.isEmpty
                        ? 'Giỏ hàng trống'
                        : 'TIẾN HÀNH ĐẶT HÀNG',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showDeleteDialog(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Xóa sản phẩm'),
          content:
          Text('Bạn có chắc chắn muốn xóa sản phẩm này khỏi giỏ hàng?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context)
                    .pop(); // Đóng hộp thoại mà không xóa sản phẩm
              },
              child: Text('Hủy'),
            ),
            TextButton(
              onPressed: () {
                removeItem(index); // Gọi hàm xóa sản phẩm
                Navigator.of(context).pop(); // Đóng hộp thoại sau khi xóa
                if (quantities.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Giỏ hàng đã trống!'),
                    ),
                  );
                }
              },
              child: Text(
                'Xóa',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }
}
