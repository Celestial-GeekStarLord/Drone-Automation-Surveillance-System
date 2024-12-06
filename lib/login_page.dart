import 'package:flutter/material.dart';
import 'register_page.dart'; // Import register_page.dart

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Welcome back',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: TextField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person),
                    hintText: 'Username',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.lock),
                    hintText: 'Password',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Checkbox(value: false, onChanged: (value) {}),
                  Text('Remember me'),
                  Spacer(),
                  TextButton(onPressed: () {}, child: Text('Forgot password?')),
                ],
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  // Navigate to HomePage after login
                  Navigator.pushReplacementNamed(context, '/home');
                },
                child: Text('Login'),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Not an account?"),
                  TextButton(
                    onPressed: () {
                      // Navigate to RegisterPage when "Sign up here" is clicked
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => RegisterPage()),
                      );
                    },
                    child: Text('Sign up here'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
