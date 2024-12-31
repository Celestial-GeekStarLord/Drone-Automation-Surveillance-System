import 'package:flutter/material.dart';

class AccountPage extends StatefulWidget {
  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  // Tracks expanded state for each option
  Map<String, bool> _isExpanded = {
    "Profile": false,
    "Change Password": false,
    "Forget Password": false,
  };

  // Descriptions for each option
  final Map<String, String> _descriptions = {
    "Profile": "View and update your profile information here.",
    "Change Password": "Change your account password for security purposes.",
    "Forget Password": "Reset your password if you've forgotten it.",
  };

  // Replace this with the actual user email
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
                    userEmail[0].toUpperCase(), // First letter of the email
                    style: TextStyle(
                      fontSize: 40,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  userEmail,
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
              child: ListView.builder(
                padding: EdgeInsets.all(16),
                itemCount: _isExpanded.keys.length,
                itemBuilder: (context, index) {
                  String title = _isExpanded.keys.elementAt(index);
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 8),
                    elevation: 2,
                    child: Column(
                      children: [
                        // List item with title and toggle icon
                        ListTile(
                          title: Text(
                            title,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.black87,
                            ),
                          ),
                          trailing: Icon(
                            _isExpanded[title]!
                                ? Icons.keyboard_arrow_up
                                : Icons.keyboard_arrow_down,
                            color: Colors.black54,
                          ),
                          onTap: () {
                            setState(() {
                              _isExpanded[title] = !_isExpanded[title]!;
                            });
                          },
                        ),
                        // Expanded description with animation
                        AnimatedCrossFade(
                          firstChild: SizedBox.shrink(),
                          secondChild: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              _descriptions[title]!,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[700],
                              ),
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
