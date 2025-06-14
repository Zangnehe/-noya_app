import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CartScreen(),
    );
  }
}

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<int> quantities = [1];
  List<int> prices = [150000];
  List<String> items = ['Skin Aqua Clear White'];

  int get totalPrice {
    int total = 0;
    for (int i = 0; i < quantities.length; i++) {
      total += quantities[i] * prices[i];
    }
    return total;
  }

  void updateQuantity(int index, int newQuantity) {
    setState(() {
      quantities[index] = newQuantity;
    });
  }

  void removeItem(int index) {
    setState(() {
      quantities.removeAt(index);
      prices.removeAt(index);
      items.removeAt(index);
    });
  }

  void _showDeleteDialog(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Xóa sản phẩm'),
          content: Text('Bạn có chắc muốn xóa sản phẩm này không?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Hủy'),
            ),
            TextButton(
              onPressed: () {
                removeItem(index);
                Navigator.of(context).pop();
              },
              child: Text('Xóa', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Giỏ hàng'),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: quantities.isEmpty
                ? Center(
                    child: Text('Giỏ hàng trống', style: TextStyle(fontSize: 16)),
                  )
                : ListView.builder(
                    itemCount: quantities.length,
                    itemBuilder: (context, index) {
                      return Card(
                        margin: EdgeInsets.all(12),
                        child: ListTile(
                          leading: Icon(Icons.image),
                          title: Text(items[index]),
                          subtitle: Text('${prices[index]}đ'),
                          trailing: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: Icon(Icons.remove),
                                    onPressed: quantities[index] > 1
                                        ? () => updateQuantity(index, quantities[index] - 1)
                                        : null,
                                  ),
                                  Text('${quantities[index]}'),
                                  IconButton(
                                    icon: Icon(Icons.add),
                                    onPressed: () => updateQuantity(index, quantities[index] + 1),
                                  ),
                                ],
                              ),
                              IconButton(
                                icon: Icon(Icons.delete, color: Colors.red),
                                onPressed: () => _showDeleteDialog(index),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Tổng cộng:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    Text('$totalPrice đ',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.red)),
                  ],
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: quantities.isEmpty ? null : () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: quantities.isEmpty ? Colors.grey : Colors.orange,
                    padding: EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: Text(
                    quantities.isEmpty ? 'Giỏ hàng trống' : 'TIẾN HÀNH ĐẶT HÀNG',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
