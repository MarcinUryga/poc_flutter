import 'package:flutter/material.dart';

class SampleAppPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SampleAppPage();
}

class _SampleAppPage extends State<SampleAppPage> {
  bool toggle = true;

  _getToggleChild(BuildContext context) {
    if (toggle) {
      return Text("Toggle one");
    } else {
      return MaterialButton(onPressed: () {}, child: Text('Toggle two'));
    }
  }

  _toggle() {
    setState(() {
      toggle = !toggle;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sample App"),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Update views',
        onPressed: _toggle,
        child: Icon(Icons.update),
      ),
      body: Builder(
        builder: (context) => Center(child: _getToggleChild(context)),
      ),
    );
  }
}
