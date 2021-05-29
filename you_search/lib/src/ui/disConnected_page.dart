import 'package:flutter/material.dart';

class DisConnectedPage extends StatefulWidget {
  @override
  _DisConnectedPageState createState() => _DisConnectedPageState();
}

class _DisConnectedPageState extends State<DisConnectedPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.network_check,
              size: 40,
            ),
            Text('Please Connect to Internet'),
          ],
        ),
      ),
    );
  }
}
