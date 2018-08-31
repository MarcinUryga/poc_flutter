import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_messaging_flutter/CustomButton.dart';
import 'package:firebase_messaging_flutter/FadeApp.dart';
import 'package:firebase_messaging_flutter/NotificationDetails.dart';
import 'package:firebase_messaging_flutter/SampleAppPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'PoC Flutter',
      home: new MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  PageController _pageController;
  int _page = 0;

  FirebaseMessaging firebaseMessaging = new FirebaseMessaging();
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();
    debugPrint("initState");
    _pageController = PageController();

    var androidInitSettings =
        new AndroidInitializationSettings('mipmap/ic_launcher');
    var iosInitSettings = new IOSInitializationSettings();
    var initSettings =
        new InitializationSettings(androidInitSettings, iosInitSettings);
    flutterLocalNotificationsPlugin.initialize(initSettings,
        selectNotification: onSelectNotification);
    firebaseMessaging.configure(
      onLaunch: (Map<String, dynamic> msg) {
        msg.keys.first.replaceFirst("0", "on launch");
        var _msg = msg;
        showNotification(_msg);
        print("onLaunch called ${(msg)}");
      },
      onResume: (Map<String, dynamic> msg) {
        print("onResume called ${(msg)}");
      },
      onMessage: (Map<String, dynamic> msg) {
        debugPrint("onMessage");
        showNotification(msg);
        print(" onMessage called ${(msg)}");
      },
    );
    firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(sound: true, alert: true, badge: true));
    firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings setting) {
      print('IOS Setting Registed');
    });
    firebaseMessaging.getToken().then((token) {
      update(token);
    });
  }

  showNotification(Map<String, dynamic> msg) async {
    var android = new AndroidNotificationDetails(
      'sdffds dsffds',
      "CHANNLE NAME",
      "channelDescription",
    );
    var iOS = new IOSNotificationDetails();
    await flutterLocalNotificationsPlugin.show(
        0, "PoC Flutter", "Body", new NotificationDetails(android, iOS),
        payload: msg.toString());
  }

  Future onSelectNotification(String payload) {
    debugPrint("payload : $payload");
    debugPrint("onSelectNotification");
//    _showSnackBar(context);
    String text = "";
    if (payload != null) {
      var details = payload.replaceAll("{", "").replaceAll("}", "").split(",");
      details.forEach((detail) {
        text += detail + "\n";
      });
    }
    showDialog(
      context: context,
      builder: (_) => new AlertDialog(
            title: new Text('Notification'),
            content: new Text(text),
          ),
    );
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => NotificationDetailsScreen(details: text)));
  }

  update(String token) {
    print(token);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PageView(
          children: [
            Container(child: SampleAppPage()),
            Container(child: MyFadeTest(title: 'Fade Demo')),
            Container(child: SampleCustomButtonApp())
          ],
          controller: _pageController,
          onPageChanged: onPageChanges,
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.update), title: Text("changable views")),
            BottomNavigationBarItem(
                icon: Icon(Icons.brush), title: Text("changable views")),
            BottomNavigationBarItem(
                icon: Icon(Icons.view_agenda), title: Text("changable views")),
          ],
          onTap: navigationTapped,
          currentIndex: _page,
        ));
  }

  void navigationTapped(int page) {
    _pageController.animateToPage(page,
        duration: const Duration(milliseconds: 300), curve: Curves.ease);
  }

  void onPageChanges(int page) {
    setState(() {
      this._page = page;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }
}
