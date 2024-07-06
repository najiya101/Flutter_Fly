import 'package:flutter/material.dart';
import 'register.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool? isChecked = false;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.8,
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Welcome back',
                  style: TextStyle(fontFamily: 'AutofillHints.impp'),
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
                  ),
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Enter your password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4),
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
                  style: ElevatedButton.styleFrom(primary: Colors.green),
                  child: Container( width: double.infinity,
                  child: Text('create account',textAlign: TextAlign.center,),),
                ),
                SizedBox(height: 16.0),
                ElevatedButton.icon(
                  onPressed: () {
                    // Navigate to home page
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginPage(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.black,
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    fixedSize: Size(
                      MediaQuery.of(context).size.width * 2,1, // Null height maintains the button's intrinsic height
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
