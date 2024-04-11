import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:sept_frontend_draft/network/base_request.dart';
import 'package:sept_frontend_draft/page/admin_home_page.dart';
import 'package:sept_frontend_draft/utils/sp_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'patient_home_page.dart';
import 'doctor_home_page.dart';
import 'register_page.dart';

class LoginPage extends StatefulWidget {
  static String tag = 'login-page';

  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  /// login params
  Map<String, dynamic> par = {};

  @override
  void initState() {
    super.initState();
  }

  ///login
  void adminLogin() async {
    if (par.values.isEmpty) {
      ///not input anything
      showToast('Please input id or password');
      return;
    }

    try {
      final response = await BaseRequest().post(
        'http://localhost:8080/admin/login',
        queryParameters: par,
      );
      // {'id':'1':'name':'aaa','password':'123'}

      /// storage login user
      SpUtils.putString('user', response['name']);
      SpUtils.putString('userType', 'admin');

      ///dynamic router
      // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
      //   return AdminHomePage();
      // }));

      /// static router
      Navigator.pushReplacementNamed(context, AdminHomePage.sName);
      print(response);
    } catch (e) {
      showToast(e.toString());
    }
  }

  /// doctor login
  void doctorLogin() async {
    if (par.values.isEmpty) {
      ///not input anything
      showToast('Please input id or password');
      return;
    }

    try {
      final response = await BaseRequest().post(
        'http://localhost:8080/Doctor/login',
        queryParameters: par,
      );

      /// storage login user
      SpUtils.putString('user', response['name']);
      //SpUtils.putString('userId', response['id']);
      // final userId = SpUtils.getString('userId');
      SpUtils.putString('userType', 'doctor');

      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return DoctorHomePage();
      }));
    } catch (e) {
      showToast(e.toString());
    }
  }

  void patientLogin() async {
    if (par.values.isEmpty) {
      ///not input anything
      showToast('Please input id or password');
      return;
    }

    try {
      final response = await BaseRequest().post(
        'http://localhost:8080/Patient/login',
        queryParameters: par,
      );

      /// storage login user
      SpUtils.putString('user', response['name']);
      SpUtils.putString('userType', 'patient');

      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return PatientHomePage();
      }));
    } catch (e) {
      showToast(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final email = TextFormField(
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      initialValue: '',
      onChanged: (value) {
        par['id'] = value;
      },
      decoration: InputDecoration(
          hintText: 'User ID',
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );

    final password = TextFormField(
      autofocus: false,
      initialValue: '',
      obscureText: true,
      onChanged: (value) {
        par['password'] = value;
      },
      decoration: InputDecoration(
          hintText: 'Password',
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );

    final loginButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        borderRadius: BorderRadius.circular(30.0),
        shadowColor: Colors.lightBlueAccent.shade100,
        elevation: 5.0,
        child: MaterialButton(
          minWidth: 200.0,
          height: 42.0,
          onPressed: () {
            Navigator.pushNamed(context, '/PatientHomePage');
          },
          color: Colors.green,
          child: Text(
            'Sign in',
            style: TextStyle(color: Colors.white, fontSize: 20.0),
          ),
        ),
      ),
    );

    final forgotLabel = FlatButton(
      child: Text(
        'Register',
        style: TextStyle(color: Colors.black54, fontSize: 18.0),
      ),
      onPressed: () {
        Navigator.pushNamed(context, '/RegisterPage');
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
            email,
            SizedBox(
              height: 8.0,
            ),
            password,
            SizedBox(
              height: 24.0,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    MaterialButton(
                      minWidth: 300.0,
                      height: 42.0,
                      color: Colors.green,
                      child: Text(
                        "Patient-LoginPage",
                        style: TextStyle(color: Colors.white, fontSize: 20.0),
                      ),
                      onPressed: () => patientLogin(),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    MaterialButton(
                      minWidth: 300.0,
                      height: 42.0,
                      color: Colors.green,
                      child: Text(
                        "Doctor-LoginPage",
                        style: TextStyle(color: Colors.white, fontSize: 20.0),
                      ),
                      onPressed: () {
                        /*Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) {
                          return DoctorHomePage();
                        }));*/
                        doctorLogin();
                      },
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    MaterialButton(
                      minWidth: 300.0,
                      height: 42.0,
                      color: Colors.green,
                      child: Text(
                        "Admin-LoginPage",
                        style: TextStyle(color: Colors.white, fontSize: 20.0),
                      ),
                      onPressed: () {
                        adminLogin();
                      },
                    ),
                  ],
                ),
              ],
            ),
            forgotLabel
          ],
        ),
      ),
    );
  }
}
