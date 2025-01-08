import 'package:flutter/material.dart';

class SensorsPage extends StatefulWidget {
  @override
  _SensorsPageState createState() => _SensorsPageState();
}

class _SensorsPageState extends State<SensorsPage> {
  // Sensor data (can be dynamically fetched or replaced with Firebase data)
  List<Map<String, dynamic>> sensors = [
    {'name': 'GPS', 'status': 'Inactive'},
    {'name': 'Gas', 'status': 'Inactive'},
    {'name': 'Temperature', 'status': 'Inactive'},
    {'name': 'Ultrasonic', 'status': 'Inactive'},
    {'name': 'PIR', 'status': 'Inactive'},
  ];

  // Toggle sensor status
  void toggleSensorStatus(int index) {
    setState(() {
      sensors[index]['status'] =
          sensors[index]['status'] == 'Inactive' ? 'Active' : 'Inactive';
    });
  }

  @override
  Widget build(BuildContext context) {
    final activeSensors =
        sensors.where((sensor) => sensor['status'] == 'Active').toList();
    final inactiveSensors =
        sensors.where((sensor) => sensor['status'] == 'Inactive').toList();

    return Scaffold(
      backgroundColor: Color(0xFFAADAE9),
      appBar: AppBar(
        title: const Text('Sensors'),
        backgroundColor: Color(0xFFAADAE9),
        elevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Logo and Title
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Image.asset(
                  'assets/image/logo.png',
                  height: 50,
                ),
                const SizedBox(width: 16),
                const Text(
                  'Sensors',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          // Active Sensors Section
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: const Text(
              'Active',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ...activeSensors.map((sensor) {
            int index = sensors.indexOf(sensor);
            return SensorTile(
              name: sensor['name'],
              status: true,
              onToggleStatus: () => toggleSensorStatus(index),
            );
          }).toList(),

          // Inactive Sensors Section
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: const Text(
              'Inactive',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ...inactiveSensors.map((sensor) {
            int index = sensors.indexOf(sensor);
            return SensorTile(
              name: sensor['name'],
              status: false,
              onToggleStatus: () => toggleSensorStatus(index),
            );
          }).toList(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
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
        onTap: (index) {
          // Handle navigation based on the index
          switch (index) {
            case 0:
              Navigator.pushNamed(context, '/home');
              break;
            case 1:
              // Stay on the current page
              break;
            case 2:
              Navigator.pushNamed(context, '/about');
              break;
            case 3:
              Navigator.pushNamed(context, '/account');
              break;
          }
        },
      ),
    );
  }
}

// Sensor Tile Widget
class SensorTile extends StatelessWidget {
  final String name;
  final bool status; // true = active, false = inactive
  final VoidCallback onToggleStatus;

  const SensorTile({
    required this.name,
    required this.status,
    required this.onToggleStatus,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        child: ListTile(
          title: Text(
            name,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          trailing: Icon(
            Icons.circle,
            color: status ? Colors.green : Colors.red,
            size: 16,
          ),
          onTap: onToggleStatus, // Call toggle function on tap
        ),
      ),
    );
  }
}
