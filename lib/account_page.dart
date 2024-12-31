import 'package:flutter/material.dart';

class AccountPage extends StatefulWidget {
  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  Map<String, bool> _isExpanded = {
    "Profile": false,
    "Change Password": false,
    "Forget Password": false,
  };

  final Map<String, String> _descriptions = {
    "Profile": "View and update your profile information here.",
    "Change Password": "Change your account password for security purposes.",
    "Forget Password": "Reset your password if you've forgotten it.",
  };

  // Replace this with the actual email
  final String userEmail = "example@mail.com";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Account'),
        backgroundColor: Color(0xFFAADAE9),
      ),
      body: Column(
        children: [
          // Top section with avatar and email
          Container(
            color: Color(0xFFD1EEF7),
            padding: EdgeInsets.symmetric(vertical: 30),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.blue,
                  child: Text(
                    userEmail[0].toUpperCase(),
                    style: TextStyle(
                      fontSize: 40,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  userEmail,
                  style: TextStyle(fontSize: 18, color: Colors.black87),
                ),
              ],
            ),
          ),
          // List of expandable options
          Expanded(
            child: Container(
              color: Color(0xFFAADAE9),
              child: ListView.builder(
                padding: EdgeInsets.all(16),
                itemCount: _isExpanded.keys.length,
                itemBuilder: (context, index) {
                  String title = _isExpanded.keys.elementAt(index);
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 8),
                    child: Column(
                      children: [
                        ListTile(
                          title: Text(title),
                          trailing: Icon(
                            _isExpanded[title]!
                                ? Icons.keyboard_arrow_up
                                : Icons.keyboard_arrow_down,
                          ),
                          onTap: () {
                            setState(() {
                              _isExpanded[title] = !_isExpanded[title]!;
                            });
                          },
                        ),
                        AnimatedCrossFade(
                          firstChild: Container(),
                          secondChild: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              _descriptions[title]!,
                              style: TextStyle(
                                  fontSize: 16, color: Colors.grey[700]),
                            ),
                          ),
                          crossFadeState: _isExpanded[title]!
                              ? CrossFadeState.showSecond
                              : CrossFadeState.showFirst,
                          duration: Duration(milliseconds: 300),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        currentIndex: 3, // Change this index according to the active page
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
