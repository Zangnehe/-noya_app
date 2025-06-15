import 'package:flutter/material.dart';

class CartModel extends ChangeNotifier {
  // Singleton instance
  static CartModel? _instance;

  // Private constructor
  CartModel._internal();

  // Get instance method
  static CartModel getInstance() {
    _instance ??= CartModel._internal();
    return _instance!;
  }

  // Danh sách sản phẩm trong giỏ hàng
  List<Product> products = [];

  // Thông tin địa chỉ
  String address = '';

  // Phương thức thanh toán
  String paymentMethod = '';

  // Mã khuyến mãi
  String promotionCode = '';

  // Ghi chú
  String note = '';

  // Thêm sản phẩm vào giỏ hàng
  void addProduct(Product product) {
    products.add(product);
    notifyListeners();
  }

  // Cập nhật địa chỉ
  void updateAddress(String newAddress) {
    address = newAddress;
    notifyListeners();
  }

  // Cập nhật phương thức thanh toán
  void updatePaymentMethod(String newPaymentMethod) {
    paymentMethod = newPaymentMethod;
    notifyListeners();
  }

  // Cập nhật mã khuyến mãi
  void updatePromotionCode(String newPromotionCode) {
    promotionCode = newPromotionCode;
    notifyListeners();
  }

  // Cập nhật ghi chú
  void updateNote(String newNote) {
    note = newNote;
    notifyListeners();
  }

  // Tính tổng giá trị giỏ hàng
  int get totalPrice {
    int total = 0;
    for (var product in products) {
      total += product.quantity * product.pricePerItem;
    }
    return total;
  }

  // Xóa sản phẩm khỏi giỏ hàng
  void removeProduct(int index) {
    products.removeAt(index);
    notifyListeners();
  }
}

// Lớp sản phẩm
class Product {
  final String name;
  final int quantity;
  final int pricePerItem;

  Product({
    required this.name,
    required this.quantity,
    required this.pricePerItem,
  });
}
