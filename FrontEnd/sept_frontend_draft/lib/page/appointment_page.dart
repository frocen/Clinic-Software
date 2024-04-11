import 'dart:io';
import 'package:flutter/material.dart';
import 'login_page.dart';

class AppointmentPage extends StatefulWidget {
  static String tag = 'Appointment-page';

  @override
  _AppointmentPageState createState() => new _AppointmentPageState();
}

class _AppointmentPageState extends State<AppointmentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('Appointment-PatientListPage'),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/LoginPage');
              },
              icon: Icon(Icons.login))
        ],
      ),
      body: Text('Appoint Information'),
    );
  }
}
