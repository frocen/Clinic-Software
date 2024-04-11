import 'dart:io';
import 'package:flutter/material.dart';
import 'package:sept_frontend_draft/page/conversation_page.dart';
import 'login_page.dart';
import 'register_page.dart';
import 'doctor_list_page.dart';
import 'patient_myappointment_page.dart';

class PatientHomePage extends StatefulWidget {
  static String tag = 'Patient-home-page';

  @override
  _PatientHomePageState createState() => new _PatientHomePageState();
}

class _PatientHomePageState extends State<PatientHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('Patient-HomePage(choose doctor)'),
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
            accountName: Text('Quanzhong Liu'),
            accountEmail: Text('patient01@sept.com'),
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
            onTap: () => {},
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
            title: Text('My appointment'),
            trailing: Icon(Icons.calendar_month),
            onTap: () => {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return PatientMyAppointmentPage();
              })),
            },
          ),
          Divider(),
          ListTile(
            title: Text('exit'),
            trailing: Icon(Icons.exit_to_app),
            onTap: () => {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return LoginPage();
              })),
              Divider(),
            },
          ),
        ],
      )),
      body: new ListView(children: <Widget>[
        ListTile(
          title: Text('Doctor1: ' + 'Doctor Informations'),
          trailing: Icon(Icons.arrow_right),
          onTap: () => {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return DoctorListPage();
            }))
          },
        ),
        Divider(),
      ]),
    );
  }
}


/*class HomePage extends StatelessWidget {
  static String tag = "home-page";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'home-page',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: _HomePage(),
    );
  }
}

class _HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HomePage(choose doctor)'),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/HomePage');
              },
              icon: Icon(Icons.exit_to_app))
        ],
      ),
      drawer: Drawer(
          child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text('Quanzhong Liu'),
            accountEmail: Text('patient01@sept.com'),
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
            onTap: () => {},
          ),
          ListTile(
            title: Text('message'),
            trailing: Icon(Icons.send),
            onTap: () => {},
          ),
          Divider(),
          ListTile(
            title: Text('exit'),
            trailing: Icon(Icons.exit_to_app),
            onTap: () => {
              // 使用 Navigator 跳转页面
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return RegisterPage();
              })),
              Divider(),
            },
          ),
        ],
      )),
      body: Center(
        child: RaisedButton(
          child: Text("choose doctor"),
          onPressed: () {
            Navigator.pushNamed(context, "/DoctorPage");
          },
        ),
      ),

      //body: new ListView(children: <Widget>[
      //ListTile(
      //title: Text('Doctor1: ' + 'doctor information'),
      //trailing: Icon(Icons.arrow_right),
      //onTap: () => {
      //Navigator.push(context, MaterialPageRoute(builder: (context) {
      //return DoctorPage();
      //}))
      //},
      //),
      //Divider(),
      //]),
    );
  }
}
*/
