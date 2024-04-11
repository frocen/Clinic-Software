import 'dart:io';
import 'package:flutter/material.dart';
import 'package:sept_frontend_draft/page/conversation_page.dart';
import 'package:sept_frontend_draft/utils/sp_utils.dart';
import 'login_page.dart';
import 'patient_list_page.dart';
import 'register_page.dart';
import 'doctor_setting_page.dart';
import 'doctor_myappointment_page.dart';
import 'package:intl/intl.dart';
//import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class DoctorHomePage extends StatefulWidget {
  static String tag = 'Doctor-home-page';

  @override
  _DoctorHomePageState createState() => new _DoctorHomePageState();
}

class _DoctorHomePageState extends State<DoctorHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: Text('Doctor-HomePage(choose patient)'),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/LoginPage');
                },
                icon: Icon(Icons.login))
          ],
        ),
        drawer: Drawer(
            child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text('Yezi'),
              accountEmail: Text('Doctor01@sept.com'),
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage(''),
              ),
            ),
            ListTile(
              title: Text('feedbcak'),
              trailing: Icon(Icons.feedback),
              onTap: () => {},
            ),
            ListTile(
              title: Text('settings'),
              trailing: Icon(Icons.settings),
              onTap: () => {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return DoctorSettingPage();
                })),
              },
            ),
            ListTile(
              title: Text('message'),
              trailing: Icon(Icons.send),
              onTap: () {
                ///chat UI
                Navigator.pushNamed(context, ConversationPage.sName);
              },
            ),
            ListTile(
              title: Text('My appointments'),
              trailing: Icon(Icons.calendar_month),
              onTap: () => {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return DoctorMyAppointmentPage();
                })),
              },
            ),
            Divider(),
            ListTile(
              title: Text('exit'),
              trailing: Icon(Icons.exit_to_app),
              onTap: () {
                SpUtils.clear();
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) {
                  return LoginPage();
                }));
              },
            ),
          ],
        )),
        body: Center(
            child: Column(children: <Widget>[
          ListTile(
            title: Text('Appointment-Number ' + 'Appointment-Date'),
            trailing: Icon(Icons.arrow_right),
            onTap: () => {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return PatientListPage();
              }))
            },
          ),
          Divider(),

          //new buttonText starts
          /*TextButton(
              onPressed: () {
                DatePicker.showDatePicker(context,
                    showTitleActions: true,
                    minTime: DateTime(2018, 3, 5),
                    maxTime: DateTime(2019, 6, 30),
                    theme: DatePickerTheme(
                        headerColor: Colors.grey,
                        backgroundColor: Colors.green,
                        itemStyle: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                        doneStyle:
                            TextStyle(color: Colors.white, fontSize: 16)),
                    onChanged: (date) {
                  print('change $date in time zone ' +
                      date.timeZoneOffset.inHours.toString());
                }, onConfirm: (date) {
                  print('confirm $date');
                }, currentTime: DateTime.now(), locale: LocaleType.en);
              },
              child: Text(
                'Date with theme',
                style: TextStyle(color: Colors.green),
              )),*/
          //new buttonText ends.
        ])),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () async {
            var result = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2020),
                lastDate: DateTime(2025));
            String dateStr = DateFormat('yyyy-MM-dd HH:mm:ss').format(result!);
            print('$dateStr');
          },
          /*onPressed: () {
            Navigator.pushNamed(context, '/SetAppointmentPage');
          },
          backgroundColor: Colors.green,
          tooltip: 'Increment',
          child: const Icon(Icons.add),*/
        ));
  }
}
