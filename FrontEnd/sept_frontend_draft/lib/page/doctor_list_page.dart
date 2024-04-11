import 'dart:io';
import 'package:flutter/material.dart';
import 'login_page.dart';
import 'register_page.dart';
import 'patient_home_page.dart';

class DoctorListPage extends StatefulWidget {
  static String tag = 'doctorList-page';

  @override
  _DoctorListPageState createState() => new _DoctorListPageState();
}

class _DoctorListPageState extends State<DoctorListPage> {
  void _showCallPhoneDialog() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Attention'),
            content: Text('Are you sure to booking?'),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('No'),
              ),
              FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                textColor: Colors.red,
                child: Text('Yes'),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
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
            bottomNavigationBar: Container(
              decoration: BoxDecoration(color: Colors.green),
              height: 50,
              child: TabBar(
                labelStyle: TextStyle(height: 0, fontSize: 10),
                tabs: <Widget>[
                  Tab(
                    icon: Icon(Icons.medical_information),
                    text: 'Doctor Information',
                  ),
                  Tab(
                    icon: Icon(Icons.calendar_month_outlined),
                    text: 'Appointment',
                  ),
                ],
              ),
            ),
            body: TabBarView(children: <Widget>[
              ListView(children: <Widget>[
                TextField(
                  enabled: false,
                  decoration: InputDecoration(hintText: 'Doctor1'),
                  onChanged: (value) {
                    print(value);
                  },
                ),
                TextField(
                  enabled: false,
                  decoration: InputDecoration(hintText: 'Male'),
                  onChanged: (value) {
                    print(value);
                  },
                ),
                TextField(
                  enabled: false,
                  decoration: InputDecoration(
                      hintText: 'pediatric, otorhinolaryngology'),
                  onChanged: (value) {
                    print(value);
                  },
                ),
                TextField(
                  enabled: false,
                  decoration: InputDecoration(
                      hintText: 'More information of the doctor'),
                  onChanged: (value) {
                    print(value);
                  },
                ),
              ]),
              ListView(children: <Widget>[
                ListTile(
                  title: Text('Doctor1: ' + 'Date'),
                  trailing: Icon(Icons.add_circle),
                  onTap: () => {_showCallPhoneDialog()},
                ),
                Divider(),
              ]),
            ])));
  }
}
