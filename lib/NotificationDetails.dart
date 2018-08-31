import 'package:flutter/material.dart';

class NotificationDetailsScreen extends StatelessWidget {
  NotificationDetailsScreen({Key key, this.details}) : super(key: key);
  String details;

  @override
  Widget build(BuildContext context) {
    debugPrint("notification Details");
    return Scaffold(
      appBar: AppBar(
        title: Text("Notification details"),
      ),
      body: Center(
        child: Text(details),
      ),
    );
  }

}