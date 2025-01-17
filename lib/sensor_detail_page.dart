import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

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

  @override
  void initState() {
    super.initState();
    _databaseReference = FirebaseDatabase.instance
        .ref()
        .child('sensors')
        .child(widget.sensorName.toLowerCase());

    _databaseReference.onValue.listen((event) {
      setState(() {
        sensorData = event.snapshot.value as Map<String, dynamic>?;
        isLoading = false;
      });
    });
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
          : sensorData == null
              ? Center(child: Text('No data available.'))
              : Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: sensorData!.entries.map((entry) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  entry.key,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(entry.value.toString()),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
    );
  }
}
