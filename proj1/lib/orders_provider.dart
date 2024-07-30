import 'package:flutter/material.dart';

class OrdersProvider with ChangeNotifier {
  List<Map<String, String>> _orders = [];

  List<Map<String, String>> get orders => _orders;

  void addOrder(List<Map<String, String>> cartItems) {
    _orders.addAll(cartItems);
    notifyListeners();
  }
}
