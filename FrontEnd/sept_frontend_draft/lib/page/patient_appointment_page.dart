import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'login_page.dart';

class PatientAppointmentPage extends StatefulWidget {
  static String tag = 'Appointment-page';

  @override
  _PatientAppointmentPageState createState() =>
      new _PatientAppointmentPageState();
}

class _PatientAppointmentPageState extends State<PatientAppointmentPage> {
  int sex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            decoration: InputDecoration(hintText: 'Name'),
            onChanged: (value) {
              print(value);
            },
          ),
          TextField(
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
            maxLines: 100,
            minLines: 1,
            decoration: InputDecoration(
                hintText:
                    'Symptoms description (the line needs to be bigger than 1 and less than 100, no number of words limit.)'),
            onChanged: (value) {
              print(value);
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Secret"),
              Radio(
                  value: 0,
                  onChanged: (value) {
                    setState(() {
                      sex = value as int;
                    });
                  },
                  groupValue: sex),
              SizedBox(width: 20),
              Text("Male"),
              Radio(
                  value: 1,
                  onChanged: (value) {
                    setState(() {
                      sex = value as int;
                    });
                  },
                  groupValue: sex),
              SizedBox(width: 20),
              Text("Female"),
              Radio(
                  value: 2,
                  onChanged: (value) {
                    setState(() {
                      sex = value as int;
                    });
                  },
                  groupValue: sex)
            ],
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
            enabled: false,
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
            enabled: false,
            onChanged: (text) {
              setState(() {});
            },
          ),
          Text('Medcine List'),
          ListTile(
            title: Text('Medcine1: ' + 'number'),
          ),
        ])));
  }
}
