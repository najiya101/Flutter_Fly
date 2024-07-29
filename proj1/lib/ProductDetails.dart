import 'package:flutter/material.dart';
import 'cart.dart';
import 'FavoritePage.dart';

class ProductDetails extends StatefulWidget {
  final String name;
  final String image;
  final String price;
  final String Detail;

  ProductDetails({
    required this.name,
    required this.image,
    required this.price,
    required this.Detail,
  });

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  bool isFavorite = false;
  static List<Map<String, String>> favoriteProducts = [];
  static List<Map<String, String>> cartItems = [];

  void _addToCart() {
    final product = {
      'name': widget.name,
      'image': widget.image,
      'price': widget.price,
      'Detail': widget.Detail,
    };

    setState(() {
      cartItems.add(product);
    });

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CartPage(cartItems: cartItems),
      ),
    );
  }

  void _toggleFavorite() {
    final product = {
      'name': widget.name,
      'image': widget.image,
      'price': widget.price,
      'Detail': widget.Detail,
    };

    setState(() {
      isFavorite = !isFavorite;
      if (isFavorite) {
        favoriteProducts.add(product);
      } else {
        favoriteProducts.removeWhere((item) => item['name'] == widget.name);
      }
    });
  }

  void _navigateToFavorites() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FavoritePage(favoriteProducts: favoriteProducts),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
        actions: [
          IconButton(
            icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border),
            onPressed: _toggleFavorite,
          ),
          IconButton(
            icon: Icon(Icons.list),
            onPressed: _navigateToFavorites,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Image.asset(widget.image),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.name,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(
                    widget.Detail,
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 10),
                  Text(
                    widget.price,
                    style: TextStyle(fontSize: 20, color: Colors.grey),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: _addToCart,
                child: Container(
                  width: double.infinity,
                  child: Text(
                    'Add to Cart',
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
