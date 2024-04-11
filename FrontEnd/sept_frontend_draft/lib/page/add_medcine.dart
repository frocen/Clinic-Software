import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:sept_frontend_draft/network/base_request.dart';
import 'patient_home_page.dart';
import 'login_page.dart';

class AddMedcinePage extends StatefulWidget {
  static String tag = 'addMedcine-Page';

  @override
  _AddMedcinePageState createState() => new _AddMedcinePageState();
}

class _AddMedcinePageState extends State<AddMedcinePage> {
  Map<String, dynamic> map = {};

  void addMedcine() async {
    /*if (map.values.isEmpty) {
      ///not input anything
      showToast('Please input id or number');
      return;
    }

    try {
      final response = await BaseRequest().post(
        'http://localhost:8080/Medcine',
        queryParameters: map,
      );*/

      Navigator.pop(context);
    /*print(response);
    } catch (e) {
      showToast(e.toString());
    }*/
  }

  @override
  Widget build(BuildContext context) {
    final id = TextFormField(
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      initialValue: '',
      onChanged: (value) {
        map['name'] = value;
      },
      decoration: InputDecoration(
          hintText: 'Medcine Name',
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );

    final number = TextFormField(
      autofocus: false,
      initialValue: '',
      onChanged: (value) {
        map['number'] = value;
      },
      keyboardType: TextInputType.visiblePassword,
      decoration: InputDecoration(
          hintText: 'Number',
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );

    final addButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        borderRadius: BorderRadius.circular(30.0),
        shadowColor: Colors.lightBlueAccent.shade100,
        elevation: 5.0,
        child: MaterialButton(
          minWidth: 200.0,
          height: 42.0,
          onPressed: () {
            addMedcine();
          },
          color: Colors.green,
          child: Text(
            'Add Medcine',
            style: TextStyle(color: Colors.white, fontSize: 20.0),
          ),
        ),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            SizedBox(
              height: 48.0,
            ),
            id,
            SizedBox(
              height: 8.0,
            ),
            number,
            SizedBox(
              height: 24.0,
            ),
            addButton,
          ],
        ),
      ),
    );
  }
}
