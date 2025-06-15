import 'package:flutter/material.dart';

class PaymentMethodScreen extends StatefulWidget {
  @override
  _PaymentMethodScreenState createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  String _selectedPaymentMethod = 'Thanh toán khi nhận hàng (COD)'; // Giá trị mặc định

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chọn hình thức thanh toán'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Hình thức thanh toán COD với icon
          RadioListTile<String>(
            title: Row(
              children: [
                Icon(Icons.attach_money, color: Colors.green), // Icon for COD
                SizedBox(width: 8),
                Text('Thanh toán khi nhận hàng (COD)'),
              ],
            ),
            value: 'Thanh toán khi nhận hàng (COD)',
            groupValue: _selectedPaymentMethod,
            onChanged: (value) {
              setState(() {
                _selectedPaymentMethod = value!;
              });
            },
          ),

          // Hình thức thanh toán bằng thẻ tín dụng với icon
          RadioListTile<String>(
            title: Row(
              children: [
                Icon(Icons.credit_card, color: Colors.blue), // Icon for Credit Card
                SizedBox(width: 8),
                Text('Thanh toán bằng thẻ tín dụng'),
              ],
            ),
            value: 'Thanh toán bằng thẻ tín dụng',
            groupValue: _selectedPaymentMethod,
            onChanged: (value) {
              setState(() {
                _selectedPaymentMethod = value!;
              });
            },
          ),

          // Nút "Xác nhận"
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context, _selectedPaymentMethod);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: EdgeInsets.symmetric(vertical: 16),
                ),
                child: Text(
                  'Xác nhận',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
