import 'dart:io';
import 'package:flutter/material.dart';
import 'login_page.dart';
import 'register_page.dart';
import 'patient_home_page.dart';

class DoctorMyAppointmentPage extends StatefulWidget {
  static String tag = 'DoctorMyAppointment-page';

  @override
  _DoctorMyAppointmentPageState createState() =>
      new _DoctorMyAppointmentPageState();
}

class _DoctorMyAppointmentPageState extends State<DoctorMyAppointmentPage> {
  void _showCallPhoneDialog() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Attention'),
            content: Text('Are you sure to accept?'),
            actions: <Widget>[
              FlatButton(
                onPressed: () => {
                  /*Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return DoctorListPage();
                  }))*/
                },
                textColor: Colors.red,
                child: Text('Refuse'),
              ),
              FlatButton(
                onPressed: () {
                  /*Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return DoctorListPage();
                  }));*/
                },
                textColor: Colors.blue,
                child: Text('Accept'),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 1,
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.green,
              title: Text('Doctor-MyAppointmentPage'),
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
                  title: Text('Date1: ' + 'Patient1'),
                  trailing: Icon(Icons.add_circle),
                  onTap: () => {_showCallPhoneDialog()},
                ),
                Divider(),
              ]),
            ])));
  }
}
