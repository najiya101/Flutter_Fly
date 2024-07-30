import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import 'package:proj1/homepage.dart';
import 'package:proj1/main.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // initialRoute: '/',
      // routes: {
      //   '/': (context) => register(),
      //   '/register': (context) => RegisterPage(),
      // },
    );
  }
}

class register extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<register> {
  bool isChecked = false;
  bool _passwordVisible =false;
  bool _passwordVisible1 = false;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _passwordController2 = TextEditingController();
  final DBbox = Hive.box('DBbox');

  void write(String email, String pass) {
    DBbox.put(email, [email, pass]);
  }

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
              children: <Widget>[
                Center(
                  child: Image.asset(
                    '/home/najiya/proj1/images/WhatsApp Image 2024-07-21 at 11.09.20 AM.jpeg', 
                    width: 200, 
                    height: 200, 
                  ),
                ),
                SizedBox(height: 16.0),
                Text(
                  'Register Here!',
                  style: TextStyle(
                      fontFamily: AutofillHints.birthday,
                      fontWeight: FontWeight.w500,
                      color: Color.fromARGB(255, 174, 96, 238),fontSize: 24),
                  textAlign: TextAlign.left,
                ),
                SizedBox(height: 16),
                Text(
                  'Enter your details',
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
                  obscureText: _passwordVisible,
                  decoration: InputDecoration(
                    hintText: 'Enter your password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                     prefixIcon: Icon(Icons.lock),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _passwordVisible ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _passwordVisible = !_passwordVisible;
                        });
                      },
                    ),
                  ),
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: _passwordController2,
                  obscureText: _passwordVisible1,
                  decoration: InputDecoration(
                    hintText: 'Re-enter your password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                     prefixIcon: Icon(Icons.lock),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _passwordVisible1 ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _passwordVisible1 = !_passwordVisible1;
                        });
                      },
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                Row(),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    String email = _emailController.text.trim();
                    String password = _passwordController.text.trim();
                    String confirmPassword =
                        _passwordController2.text.trim();

                    if (password != confirmPassword) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Passwords do not match'),
                          backgroundColor: Colors.red,
                        ),
                      );
                      return;
                    }

                    if (!RegExp(
                            r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
                        .hasMatch(email)) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Invalid email format'),
                          backgroundColor: Colors.red,
                        ),
                      );
                      return;
                    }

                    write(email, password);
                    // Navigate to home page
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomePage(email: email, password: password),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 174, 96, 238),
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                  ),
                  child: Container(
                    width: double.infinity,
                    child: Text(
                      'Register',
                      textAlign: TextAlign.center,style: TextStyle(color: Colors.white)
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                  ),
                  child: Container(
                    width: double.infinity,
                    child: Text(
                      'Back',
                      textAlign: TextAlign.center,style: TextStyle(color: Colors.black)
                    ),
                  ),
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
