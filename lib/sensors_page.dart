import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import './sensor_detail_page.dart';

class SensorsPage extends StatefulWidget {
  @override
  _SensorsPageState createState() => _SensorsPageState();
}

class _SensorsPageState extends State<SensorsPage> {
  late DatabaseReference _databaseReference;
  Map<String, String> sensorStatuses = {};
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _databaseReference = FirebaseDatabase.instance.ref().child('sensors');

    // Listen for updates for each sensor
    _databaseReference.onValue.listen((event) {
      if (event.snapshot.value != null && event.snapshot.value is Map) {
        final data = Map<String, dynamic>.from(event.snapshot.value as Map);

        // Update sensor statuses based on the data changes
        setState(() {
          sensorStatuses = {
            for (var key in data.keys)
              key: data[key] != null && data[key]['isUpdating'] == true
                  ? 'Active'
                  : 'Inactive'
          };
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sensors'),
        backgroundColor: Color(0xFFAADAE9),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              padding: const EdgeInsets.all(8.0),
              itemCount: sensorStatuses.length,
              itemBuilder: (context, index) {
                final sensorName = sensorStatuses.keys.elementAt(index);
                final sensorStatus = sensorStatuses[sensorName]!;
                return ListTile(
                  title: Text(sensorName),
                  subtitle: Text(sensorStatus),
                  trailing: Icon(
                    sensorStatus == 'Active'
                        ? Icons.check_circle
                        : Icons.cancel,
                    color: sensorStatus == 'Active' ? Colors.green : Colors.red,
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SensorDetailPage(
                          sensorName: sensorName,
                        ),
                      ),
                    );
                  },
                );
              },
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
