import 'package:flutter/material.dart';
import 'sensor_detail_page.dart';

class SensorsPage extends StatefulWidget {
  @override
  _SensorsPageState createState() => _SensorsPageState();
}

class _SensorsPageState extends State<SensorsPage> {
  // Sensor data for the detail page
  final Map<String, Map<String, String>> sensors = {
    "GPS": {
      "Live location": "37.7749° N, 122.4194° W",
      "Latitude": "37.7749° N",
      "Longitude": "122.4194° W",
    },
    "Gas": {
      "Gas Level": "Moderate",
      "Detection": "No hazardous gas",
    },
    "Temperature": {
      "Current Temp": "24°C",
      "Threshold": "30°C",
    },
    "US": {
      "Ultrasonic Value": "15 cm",
      "Status": "Clear Path",
    },
    "PIR": {
      "Motion Detected": "No",
      "Alert": "Inactive",
    },
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sensors'),
        backgroundColor: Color(0xFFAADAE9),
      ),
      body: Column(
        children: [
          // Header
          Container(
            padding: EdgeInsets.symmetric(vertical: 20),
            color: Color(0xFFAADAE9),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/image/logo.png',
                  height: 40,
                ),
                SizedBox(width: 10),
                Text(
                  "Sensors",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              color: Color(0xFFAADAE9),
              child: ListView.builder(
                padding: EdgeInsets.all(16),
                itemCount: sensors.keys.length,
                itemBuilder: (context, index) {
                  String sensorName = sensors.keys.elementAt(index);
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      title: Text(
                        sensorName.toUpperCase(),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      trailing: Icon(Icons.arrow_forward),
                      onTap: () {
                        // Navigate to detail page with sensor data
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SensorDetailPage(
                              sensorName: sensorName,
                              sensorData: sensors[sensorName]!,
                            ),
                          ),
                        );
                      },
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
        currentIndex: 1,
        onTap: (index) {
          if (index == 0) {
            Navigator.pushNamed(context, '/home');
          } else if (index == 2) {
            Navigator.pushNamed(context, '/about');
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
