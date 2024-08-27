import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'orders_provider.dart'; // Assuming this file contains the OrdersProvider class

class CartPage extends StatefulWidget {
  final List<Map<String, String>> cartItems;

  CartPage({required this.cartItems});

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  late List<Map<String, String>> _cartItems;
  double _totalAmount = 0.0;

  @override
  void initState() {
    super.initState();
    _cartItems = widget.cartItems;
    _calculateTotalAmount();
  }

  void _calculateTotalAmount() {
    _totalAmount = _cartItems.fold(
      0.0,
      (sum, item) {
        final priceString = item['price']!;
        final cleanedPriceString = priceString.replaceAll(RegExp(r'[^\d.]'), ''); // Remove any non-numeric characters
        final price = double.tryParse(cleanedPriceString) ?? 0.0;
        return sum + price;
      },
    );
  }

  void _placeOrder() {
    Provider.of<OrdersProvider>(context, listen: false).addOrder(_cartItems);
    setState(() {
      _cartItems.clear();
      _totalAmount = 0.0;
    });

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Order Placed'),
        content: Text('Your order has been placed successfully.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: _cartItems.isEmpty
          ? Center(child: Text('No items in the cart.'))
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: _cartItems.length,
                    itemBuilder: (context, index) {
                      final item = _cartItems[index];
                      return ListTile(
                        leading: Image.asset(item['image']!),
                        title: Text(item['name']!),
                        subtitle: Text(item['price']!),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Total Amount: \$${_totalAmount.toStringAsFixed(2)}',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton(
                    onPressed: _placeOrder,
                    child: Container(
                      width: double.infinity,
                      child: Text(
                        'Place Your Order',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
