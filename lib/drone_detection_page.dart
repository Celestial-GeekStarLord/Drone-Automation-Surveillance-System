import 'package:flutter/material.dart';

class DroneDetectionPage extends StatefulWidget {
  final bool isDroneConnected; // Pass drone connection status
  final List<String> detections; // Pass detection data

  DroneDetectionPage({
    required this.isDroneConnected,
    required this.detections,
  });

  @override
  _DroneDetectionPageState createState() => _DroneDetectionPageState();
}

class _DroneDetectionPageState extends State<DroneDetectionPage> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset(
            'assets/image/homebg.jpg', // Background image
            fit: BoxFit.cover,
          ),
        ),
        Center(
          child: widget.isDroneConnected
              ? widget.detections.isNotEmpty
              ? ListView.builder(
            padding: EdgeInsets.all(16.0),
            itemCount: widget.detections.length,
            itemBuilder: (context, index) {
              return Card(
                color: Colors.blue[100],
                child: ListTile(
                  leading: Icon(
                    Icons.warning,
                    color: Colors.red,
                  ),
                  title: Text(
                    widget.detections[index],
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              );
            },
          )
              : Text(
            "No detections yet.",
            style: TextStyle(fontSize: 18, color: Colors.white),
          )
              : Text(
            "Drone not connected.",
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
        ),
      ],
    );
  }
}
