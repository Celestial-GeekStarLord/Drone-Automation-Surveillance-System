import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class SensorDetailPage extends StatefulWidget {
  final String sensorName;

  const SensorDetailPage({
    Key? key,
    required this.sensorName,
  }) : super(key: key);

  @override
  _SensorDetailPageState createState() => _SensorDetailPageState();
}

class _SensorDetailPageState extends State<SensorDetailPage> {
  late DatabaseReference _sensorRef;
  Map<String, String> sensorData = {};
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _sensorRef = FirebaseDatabase.instance
        .reference()
        .child('sensors')
        .child('sensor1${widget.sensorName}');

    // Listen for real-time updates
    _sensorRef.onValue.listen((event) {
      if (event.snapshot.value != null && event.snapshot.value is Map) {
        final data = Map<String, String>.from(event.snapshot.value as Map);
        setState(() {
          sensorData = data;
          isLoading = false;
        });
      } else {
        // Handle missing or incorrect data format
        setState(() {
          sensorData = {'Error': 'Invalid or missing data'};
          isLoading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.sensorName),
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
                  widget.sensorName.toUpperCase(),
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),

          // Sensor Data Display
          Expanded(
            child: Container(
              color: Color(0xFFD1EEF7),
              padding: EdgeInsets.all(16),
              child: Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: isLoading
                      ? Center(child: CircularProgressIndicator())
                      : sensorData.isEmpty || sensorData.containsKey('Error')
                          ? Center(
                              child: Text(
                                sensorData['Error'] ??
                                    'No data available for this sensor.',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey,
                                ),
                              ),
                            )
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: sensorData.entries.map((entry) {
                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        entry.key,
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        entry.value,
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ],
                                  ),
                                );
                              }).toList(),
                            ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

extension on FirebaseDatabase {
  DatabaseReference reference() {
    return FirebaseDatabase.instance.reference();
  }
}

extension on FirebaseDatabase {
  reference() {}
}
