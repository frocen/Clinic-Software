import 'dart:io';
import 'package:flutter/material.dart';
import 'login_page.dart';
import 'register_page.dart';
import 'doctor_home_page.dart';
import 'doctor_appointment_page.dart';

class PatientListPage extends StatefulWidget {
  static String tag = 'patientList-page';

  @override
  _PatientListPageState createState() => new _PatientListPageState();
}

class _PatientListPageState extends State<PatientListPage> {
  List<String> names = [
    "Appointment-Date Patient1",
    "Appointment-Date Patient2",
    "Appointment-Date Patient3",
    "Appointment-Date Patient4",
    "Appointment-Date Patient5",
    "Appointment-Date Patient6",
    "Appointment-Date Patient7",
    "Appointment-Date Patient8",
    "Appointment-Date Patient9",
    "Appointment-Date Patient10",
  ];

  @override
  Widget build(BuildContext context) {
    return ReorderableListView(
      header: AppBar(
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
      children: names.map(_buildCard).toList(),
      onReorder: _onReorder,
    );
  }

  Widget _buildCard(String name) {
    return SizedBox(
        key: ObjectKey(name),
        height: 100,
        child: GestureDetector(
          onTap: () => {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return DoctorAppointmentPage();
            }))
          },
          child: Card(
            color: Colors.grey,
            child: Center(
              child: Text(
                '$name',
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ));
  }

  _onReorder(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) newIndex = newIndex - 1;
    var name = names.removeAt(oldIndex);
    names.insert(newIndex, name);
    setState(() {});
  }
}
