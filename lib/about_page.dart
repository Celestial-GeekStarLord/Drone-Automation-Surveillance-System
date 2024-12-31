import 'package:flutter/material.dart';

class AboutPage extends StatefulWidget {
  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  Map<String, bool> _isExpanded = {
    "How to use": false,
    "Hardware in use": false,
    "Description": false,
    "Warning": false,
    "Terms and Conditions": false,
    "Feedback": false,
  };

  final Map<String, String> _descriptions = {
    "How to use":
        "This app allows you to monitor drone detections in real-time. Connect the drone to view live data and receive notifications.",
    "Hardware in use":
        "Our system utilizes a Raspberry Pi, camera modules, and advanced AI for weapon and human detection.",
    "Description":
        "DASS (Drone Automation Surveillance System) provides efficient and real-time surveillance using AI-powered drones.",
    "Warning":
        "Ensure proper safety while operating the drone. Follow all legal and regulatory guidelines for usage.",
    "Terms and Conditions":
        "By using this app, you agree to the terms and conditions specified for the usage of drones and software.",
    "Feedback": "We value your feedback! Please send us your thoughts and suggestions to improve the app.",
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About'),
        backgroundColor: Color(0xFFAADAE9),
      ),
      body: Container(
        color: Color(0xFFAADAE9), // Setting the background color
        child: Column(
          children: [
            SizedBox(height: 20), // Space above the logo
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/image/logo.png',
                    height: 100,
                    width: 100,
                  ),
                  SizedBox(height: 10), // Add some space between the image and the text
                  Text(
                    'DASS',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20), // Space below the logo
            Expanded(
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
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        currentIndex: 2, // Change this index according to the active page
        onTap: (index) {
          if (index == 0) {
            Navigator.pushNamed(context, '/home');
          } else if (index == 1) {
            Navigator.pushNamed(context, '/sensors');
          } else if (index == 3) {
            Navigator.pushNamed(context, '/account');
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
