import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:proj1/SettingsPage.dart';
import 'package:provider/provider.dart';
import 'orders_provider.dart'; // Assuming this file contains the OrdersProvider class
// Assuming this file contains the SettingsPage class

class ProfilePage extends StatefulWidget {
  final String email;
  final String password;

  ProfilePage({required this.email, required this.password});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  final DBbox = Hive.box('DBbox');
  File? _profileImage;

  @override
  void initState() {
    super.initState();
    var user = DBbox.get('email');
    if (user != null) {
      _nameController.text = user[2] ?? ''; // assuming the name is stored in the 3rd index
      _emailController.text = user[0];
      _passwordController.text = user[1];
    }
  }

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
    }
  }

  void updateProfile(String name, String email, String password) {
    DBbox.put(email, [email, password, name]); // including name in the list
  }

  void navigateToOrders() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => OrdersPage()),
    );
  }

  void navigateToSettings() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SettingsPage(email: _emailController.text, password: _passwordController.text)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Center(
            child: Container(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  GestureDetector(
                    onTap: _pickImage,
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: _profileImage != null
                          ? FileImage(_profileImage!)
                          : AssetImage('/home/najiya/proj1/images/_.jpeg') as ImageProvider,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Update your profile',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 16),
                  TextField(
                    controller: _nameController,
                    decoration: InputDecoration(labelText: 'Name'),
                  ),
                
                  SizedBox(height: 10,),
                  GestureDetector(
                    onTap: navigateToOrders,
                    child: Container(
                      height: 50, // Set the desired height here
                     alignment: Alignment.centerLeft,
                    child: Text(
                      'My Orders',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                  ),
                  SizedBox(height: 10,),
                  GestureDetector(
                    onTap: navigateToSettings,
                    child: Text(
                      'Settings',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                  ElevatedButton(
                    onPressed: () {
                      updateProfile(
                        _nameController.text,
                        _emailController.text,
                        _passwordController.text,
                      );
                    },
                    child: Text('Update Profile'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}

class OrdersPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final orders = Provider.of<OrdersProvider>(context).orders;

    return Scaffold(
      appBar: AppBar(
        title: Text('My Orders'),
      ),
      body: orders.isEmpty
          ? Center(child: Text('No orders placed yet.'))
          : ListView.builder(
              itemCount: orders.length,
              itemBuilder: (context, index) {
                final item = orders[index];
                return ListTile(
                  leading: Image.asset(item['image']!),
                  title: Text(item['name']!),
                  subtitle: Text(item['price']!),
                );
              },
            ),
    );
  }
}
