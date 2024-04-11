import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sept_frontend_draft/page/add_medcine.dart';
import 'login_page.dart';

class DoctorAppointmentPage extends StatefulWidget {
  static String tag = 'Appointment-page';

  @override
  _DoctorAppointmentPageState createState() =>
      new _DoctorAppointmentPageState();
}

class _DoctorAppointmentPageState extends State<DoctorAppointmentPage> {
  int sex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('Appointment(Cases)Page'),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/LoginPage');
              },
              icon: Icon(Icons.login))
        ],
      ),
      body: Center(
          child: Column(children: <Widget>[
        Text('Patient inforamtion'),
        TextField(
          enabled: false,
          decoration: InputDecoration(hintText: 'Name'),
          onChanged: (value) {
            print(value);
          },
        ),
        TextField(
          enabled: false,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(hintText: 'Age'),
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(3)
          ],
          onChanged: (value) {
            print(value);
          },
        ),
        TextField(
          enabled: false,
          maxLines: 100,
          minLines: 1,
          decoration: InputDecoration(
              hintText:
                  'Symptoms description (the line needs to be bigger than 1 and less than 100, no number of words limit.)'),
          onChanged: (value) {
            print(value);
          },
        ),
        TextField(
          decoration: InputDecoration(hintText: 'Gender: Male'),
          enabled: false,
          onChanged: (value) {
            print(value);
          },
        ),
        TextField(
          decoration: InputDecoration(hintText: 'doctor1'),
          enabled: false,
          onChanged: (value) {
            print(value);
          },
        ),
        Text('Case'),
        TextField(
          decoration: InputDecoration(
              hintText:
                  'Text of the Cases writen by doctor1, the line needs to be bigger than 1 and less than 100, no number of words limit. Only doctor can edit it.'),
          maxLines: 100,
          minLines: 1,
          onChanged: (text) {
            setState(() {});
          },
        ),
        Text('Report'),
        TextField(
          decoration: InputDecoration(
              hintText:
                  'Report, the line needs to be bigger than 1 and less than 100, no number of words limit. Only doctor can edit it.'),
          maxLines: 100,
          minLines: 1,
          onChanged: (text) {
            setState(() {});
          },
        ),
        Text('Medcine List'),
        ListTile(
          title: Text('Medcine1: ' + 'number'),
        ),
      ])),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return AddMedcinePage();
          }));
        },
      ),
    );
  }
}
