//import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'orders_provider.dart';
//import 'package:proj1/profile.dar';
//import 'package:proj1/profile.dart';
import 'register.dart';
import 'homepage.dart';


void main() async {
  await Hive.initFlutter();
  await Hive.openBox('DBbox');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(create: (context) => OrdersProvider(),
    child: MaterialApp(home: LoginPage(),),);
   
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool? isChecked = false;
  bool passvisible = false;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final DBbox = Hive.box('DBbox');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.8,
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[Center(
                  child: Image.asset(
                    '/home/najiya/proj1/images/WhatsApp Image 2024-07-21 at 11.09.20 AM.jpeg', 
                    width: 200, 
                    height: 200, 
                  ),
                ),
                SizedBox(height: 16.0),
                Text(
                  'Welcome back',
                  style: TextStyle(fontFamily: 'AutofillHints.impp',color: Color.fromARGB(255, 174, 96, 238),fontSize: 24),
                  textAlign: TextAlign.left,
                  
                ),
                SizedBox(height: 16),
                Text(
                  'Login to your account',
                  style: TextStyle(
                    fontFamily: 'AutofillHints.birthdayDay',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 26),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    hintText: 'Enter your email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                    ),
                     prefixIcon: Icon(Icons.email),
                  ),
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: _passwordController,
                  obscureText: passvisible,
                  decoration: InputDecoration(
                    hintText: 'Enter your password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                     prefixIcon: Icon(Icons.lock),
                    suffixIcon: IconButton(
                      icon: Icon(
                        passvisible ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          passvisible = !passvisible;
                        });
                      },
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                Row(
                  children: <Widget>[
                    Checkbox(
                      value: isChecked,
                      onChanged: (newBool) {
                        setState(() {
                          isChecked = newBool;
                        });
                      },
                    ),
                    Text('Remember me'),
                    Spacer(),
                    TextButton(
                      onPressed: () {
                        // Forgot password logic
                      },
                      child: Text('Forgot Password?'),
                    ),
                  ],
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    // Login logic
                    String email = _emailController.text;
                    String password = _passwordController.text;
                    print('Email: $email, Password: $password, Remember Me: $isChecked');
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => register(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Color.fromARGB(255, 174, 96, 238)),
                  child: Container(
                    width: double.infinity,
                    child: Text(
                      'create account',
                      textAlign: TextAlign.center,style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                ElevatedButton.icon(
                  onPressed: () {
                    String em = _emailController.text;
                    String ps = _passwordController.text;

                    var data = DBbox.get(em);
                    if (data != null) {
                      
                        if (data[1] != ps) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("password error")));
                        } else {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HomePage(email: em, password: ps),
                            ),
                          );
                        }
                      
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("invalid user")));
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    fixedSize: Size(
                      MediaQuery.of(context).size.width * 3,
                      2,
                    ),
                  ),
                  icon: Icon(Icons.login),
                  label: Text('Login now'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}

