import 'dart:io';
import 'package:flutter/material.dart';
import 'login_page.dart';

class DoctorSettingPage extends StatefulWidget {
  static String tag = 'DoctorSetting-page';

  @override
  _DoctorSettingPageState createState() => new _DoctorSettingPageState();
}

class _DoctorSettingPageState extends State<DoctorSettingPage> {
  bool flag = true;

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
        body: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              children: <Widget>[
                Row(children: <Widget>[
                  Text('Auto Accept Appointments'),
                  SizedBox(height: 40),
                  Switch(
                      value: this.flag,
                      onChanged: (value) {
                        setState(() {
                          this.flag = value;
                        });
                      })
                ])
              ],
            )));
  }
}
