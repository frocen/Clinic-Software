import 'dart:io';
import 'package:flutter/material.dart';
import 'login_page.dart';
import 'register_page.dart';
import 'patient_home_page.dart';
import 'patient_appointment_page.dart';

class PatientMyAppointmentPage extends StatefulWidget {
  static String tag = 'doctorList-page';

  @override
  _PatientMyAppointmentPageState createState() =>
      new _PatientMyAppointmentPageState();
}

class _PatientMyAppointmentPageState extends State<PatientMyAppointmentPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 1,
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.green,
              title: Text('Doctor-InformationPage'),
              centerTitle: true,
              actions: <Widget>[
                IconButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/LoginPage');
                    },
                    icon: Icon(Icons.login))
              ],
            ),
            body: TabBarView(children: <Widget>[
              ListView(children: <Widget>[
                ListTile(
                  title: Text('Doctor1: ' + 'Date'),
                  trailing: Icon(Icons.check_circle),
                  onTap: () => {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return PatientAppointmentPage();
                    })),
                  },
                ),
                Divider(),
              ]),
            ])));
  }
}
