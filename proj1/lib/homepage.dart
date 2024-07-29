import 'package:flutter/material.dart';
import 'package:proj1/cart.dart';
import 'package:proj1/home1.dart';
import 'package:proj1/profile.dart';
import 'package:proj1/FavoritePage.dart';

class HomePage extends StatefulWidget {
  final String email;
  final String password;

  HomePage({required this.email, required this.password});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  List<Map<String, String>> favoriteProducts = [];
  List<Map<String, String>> cartItems = [];
  late List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = <Widget>[
      HomeScreen(onFavoriteAdd: _addToFavorites),
      CartPage(cartItems: cartItems),
      FavoritePage(favoriteProducts: favoriteProducts),
      ProfilePage(email: widget.email, password: widget.password),
      
    ];
  }

  void _addToFavorites(Map<String, String> product) {
    setState(() {
      favoriteProducts.add(product);
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Delight your day',),titleTextStyle: TextStyle(color: Colors.black),
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Colors.black,),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart, color: Colors.black),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite, color: Colors.black),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle, color: Colors.black),
            label: 'Account',
          ),
          
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Color.fromARGB(255, 174, 96, 238),

        onTap: _onItemTapped,
      ),
    );
  }
}
