import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';

class SensorDetailPage extends StatefulWidget {
  final String sensorName;

  const SensorDetailPage({Key? key, required this.sensorName})
      : super(key: key);

  @override
  _SensorDetailPageState createState() => _SensorDetailPageState();
}

class _SensorDetailPageState extends State<SensorDetailPage> {
  late DatabaseReference _databaseReference;
  Map<String, dynamic>? sensorData;
  bool isLoading = true;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    _databaseReference = FirebaseDatabase.instance
        .ref()
        .child('sensors')
        .child(widget.sensorName.toLowerCase());

    // Start listening to database changes
    _databaseReference.onValue.listen((event) {
      if (event.snapshot.exists) {
        setState(() {
          sensorData = Map<String, dynamic>.from(event.snapshot.value as Map);
          isLoading = false;
          errorMessage = '';
        });
      } else {
        setState(() {
          sensorData = null;
          isLoading = false;
          errorMessage = 'No data available for this sensor.';
        });
      }
    }, onError: (error) {
      setState(() {
        isLoading = false;
        errorMessage =
            'Failed to load data. Please check your network connection.';
      });
      debugPrint("Error: $error");
    });
  }

  @override
  void dispose() {
    // Cancel any active listeners when the widget is disposed
    _databaseReference.onDisconnect();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.sensorName),
        backgroundColor: Color(0xFFAADAE9),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : errorMessage.isNotEmpty
              ? Center(
                  child: Text(errorMessage,
                      style: TextStyle(color: Colors.red, fontSize: 16)))
              : sensorData == null
                  ? Center(child: Text('No data available.'))
                  : Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Sensor Details",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              Divider(thickness: 1.5),
                              ...sensorData!.entries.map((entry) {
                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        entry.key.capitalize(),
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16),
                                      ),
                                      Text(
                                        entry.value.toString(),
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ],
                                  ),
                                );
                              }).toList(),
                              SizedBox(height: 16),
                              Text(
                                "Last Updated: ${DateTime.fromMillisecondsSinceEpoch(sensorData!['lastUpdated'])}",
                                style: TextStyle(
                                    fontSize: 14,
                                    fontStyle: FontStyle.italic,
                                    color: Colors.grey),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
    );
  }
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}
