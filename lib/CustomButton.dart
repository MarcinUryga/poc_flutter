import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String label;

  CustomButton(this.label);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(onPressed: () {}, child: Text(label));
  }
}

class SampleCustomButtonApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sample Custom App"),
      ),
      body: Center(
        child: CustomButton("Hello"),
      ),
    );
  }
}