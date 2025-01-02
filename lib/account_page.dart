import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AccountPage extends StatefulWidget {
  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? _user;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _user = _auth.currentUser;
    if (_user != null) {
      _emailController.text = _user!.email!;
    }
  }

  Future<void> _updateEmail() async {
    try {
      await _user!.verifyBeforeUpdateEmail(_emailController.text);
      await _user!.sendEmailVerification();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content:
                Text('Verification email sent to ${_emailController.text}')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update email: $e')),
      );
    }
  }

  Future<void> _updatePassword() async {
    try {
      await _user!.updatePassword(_passwordController.text);
      await _user!.sendEmailVerification();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
                'Password updated successfully. Verification email sent to ${_user!.email}')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update password: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Account'),
        backgroundColor: Color(0xFFAADAE9),
      ),
      body: Column(
        children: [
          // Top section with avatar and email (D1EEF7 color fully applied)
          Container(
            color: Color(0xFFD1EEF7),
            padding: EdgeInsets.symmetric(vertical: 40),
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.blue,
                  child: Text(
                    _user != null ? _user!.email![0].toUpperCase() : '',
                    style: TextStyle(
                      fontSize: 40,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  _user != null ? _user!.email! : '',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),

          // List of expandable options
          Expanded(
            child: Container(
              color: Color(0xFFAADAE9), // Background for the lower section
              child: ListView(
                padding: EdgeInsets.all(16),
                children: [
                  Card(
                    margin: EdgeInsets.symmetric(vertical: 8),
                    elevation: 2,
                    child: Column(
                      children: [
                        ListTile(
                          title: Text(
                            'Profile',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.black87,
                            ),
                          ),
                          trailing: Icon(Icons.keyboard_arrow_down,
                              color: Colors.black54),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              TextField(
                                controller: _emailController,
                                decoration: InputDecoration(labelText: 'Email'),
                              ),
                              SizedBox(height: 10),
                              ElevatedButton(
                                onPressed: _updateEmail,
                                child: Text('Update Email'),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Card(
                    margin: EdgeInsets.symmetric(vertical: 8),
                    elevation: 2,
                    child: Column(
                      children: [
                        ListTile(
                          title: Text(
                            'Change Password',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.black87,
                            ),
                          ),
                          trailing: Icon(Icons.keyboard_arrow_down,
                              color: Colors.black54),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              TextField(
                                controller: _passwordController,
                                decoration:
                                    InputDecoration(labelText: 'New Password'),
                                obscureText: true,
                              ),
                              SizedBox(height: 10),
                              ElevatedButton(
                                onPressed: _updatePassword,
                                child: Text('Update Password'),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),

      // Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        currentIndex: 3, // Active page index for "Account"
        onTap: (index) {
          if (index == 0) {
            Navigator.pushNamed(context, '/home');
          } else if (index == 1) {
            Navigator.pushNamed(context, '/sensors');
          } else if (index == 2) {
            Navigator.pushNamed(context, '/about');
          }
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.sensors),
            label: 'Sensors',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: 'About',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Account',
          ),
        ],
      ),
    );
  }
}
