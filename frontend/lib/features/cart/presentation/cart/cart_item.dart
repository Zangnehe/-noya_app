import 'package:flutter/material.dart';

class CartItem extends StatelessWidget {
  final int quantity;
  final Function(int) onQuantityChanged;
  final Function() onDelete; // Callback to notify parent for deletion

  CartItem({
    required this.quantity,
    required this.onQuantityChanged,
    required this.onDelete, required product,
  });

  int pricePerItem = 150000; // Price per item

  int get totalPrice => quantity * pricePerItem;

  void incrementQuantity() {
    onQuantityChanged(quantity + 1);
  }

  void decrementQuantity() {
    if (quantity > 1) {
      onQuantityChanged(quantity - 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Product image (Replace with actual image URL or asset path)
        Container(
          width: 80,
          height: 80,
          child: Image.asset(
            'assets/skinqua.png', // Replace with actual image URL
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(width: 16),
        // Product info
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Skin Aqua Clear White',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 4),
              Text(
                'Sữa Chống Nắng Sunday Skin Aqua Clear White PA+++',
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
              SizedBox(height: 4),
              Text(
                'Dung tích 55g | Loại da: Da dầu/Da nhạy cảm',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
              SizedBox(height: 8),
              // Quantity and price section
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.remove),
                    onPressed: decrementQuantity,
                  ),
                  Text(
                    '$quantity',
                    style: TextStyle(fontSize: 16),
                  ),
                  IconButton(
                    icon: Icon(Icons.add),
                    onPressed: incrementQuantity,
                  ),
                  Spacer(),
                  Text(
                    '${totalPrice.toString()} đ',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
          ),
        ),
        // Delete button with confirmation dialog
        IconButton(
          icon: Icon(Icons.close),
          onPressed: onDelete, // Use the passed onDelete function directly
        ),
      ],
    );
  }
}
