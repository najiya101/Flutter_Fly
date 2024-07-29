import 'package:flutter/material.dart';

class FavoritePage extends StatefulWidget {
  final List<Map<String, String>> favoriteProducts;

  FavoritePage({required this.favoriteProducts});

  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  void _removeFromFavorites(int index) {
    setState(() {
      widget.favoriteProducts.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite Products'),
      ),
      body: widget.favoriteProducts.isEmpty
          ? Center(child: Text('No favorite products added yet.'))
          : ListView.builder(
              itemCount: widget.favoriteProducts.length,
              itemBuilder: (context, index) {
                final product = widget.favoriteProducts[index];
                return ListTile(
                  leading: Image.asset(product['image']!),
                  title: Text(product['name']!),
                  subtitle: Text(product['price']!),
                  trailing: IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () => _removeFromFavorites(index),
                  ),
                );
              },
            ),
    );
  }
}
