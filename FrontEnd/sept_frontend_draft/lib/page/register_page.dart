import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:sept_frontend_draft/network/base_request.dart';
import 'patient_home_page.dart';
import 'login_page.dart';

//注册界面
class RegisterPage extends StatefulWidget {
  static String tag = 'register-page';

  @override
  _RegisterPageState createState() => new _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  Map<String, dynamic> map = {};

  void register() async {
    if (map.values.isEmpty) {
      ///not input anything
      showToast('Please input id or password');
      return;
    }

    try {
      final response = await BaseRequest().post(
        'http://localhost:8080/Patient',
        queryParameters: map,
      );

      Navigator.pop(context);
      print(response);
    } catch (e) {
      showToast(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final id = TextFormField(
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      initialValue: '',
      onChanged: (value) {
        map['id'] = value;
      },
      decoration: InputDecoration(
          hintText: 'User ID',
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );

    final name = TextFormField(
      keyboardType: TextInputType.name,
      autofocus: false,
      initialValue: '',
      onChanged: (value) {
        map['name'] = value;
      },
      decoration: InputDecoration(
          hintText: 'Name',
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );

    final password = TextFormField(
      autofocus: false,
      initialValue: '',
      obscureText: true,
      onChanged: (value) {
        map['password'] = value;
      },
      keyboardType: TextInputType.visiblePassword,
      decoration: InputDecoration(
          hintText: 'Password',
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );

    final registerButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        borderRadius: BorderRadius.circular(30.0),
        shadowColor: Colors.lightBlueAccent.shade100,
        elevation: 5.0,
        child: MaterialButton(
          minWidth: 200.0,
          height: 42.0,
          onPressed: () {
            register();
          },
          color: Colors.green,
          child: Text(
            'Create',
            style: TextStyle(color: Colors.white, fontSize: 20.0),
          ),
        ),
      ),
    );

    final forgotLabel = FlatButton(
      child: Text(
        'Alreadey have an Account',
        style: TextStyle(color: Colors.black54, fontSize: 18.0),
      ),
      onPressed: () {
        Navigator.pop(context);
      },
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
            name,
            SizedBox(
              height: 8.0,
            ),
            password,
            SizedBox(
              height: 24.0,
            ),
            registerButton,
            forgotLabel
          ],
        ),
      ),
    );
  }
}
