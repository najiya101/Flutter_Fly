import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

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
    DBbox.put(email, [email, password]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Profile'),
      // ),
      body: Center(
        child: SingleChildScrollView(
          child: Center(
          child: Container(
            padding: EdgeInsets.all(16.0),
            child: Column(
               //mainAxisAlignment: MainAxisAlignment.center,
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
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    hintText: 'Enter your name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    hintText: 'Enter your email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
               
                ElevatedButton(
                  onPressed: () {
                    String name = _nameController.text.trim();
                    String email = _emailController.text.trim();
                    String password = _passwordController.text.trim();
             
                    updateProfile(name, email, password);
                   
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 174, 96, 238),
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                  ),
                  child: Container(
                    width: double.infinity,
                    child: Text(
                      'Submit',
                      textAlign: TextAlign.center,style: TextStyle(color: Colors.white),
                    ),
                  ),
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

