import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:oktoast/oktoast.dart';
import 'package:sept_frontend_draft/page/add_medcine.dart';
import 'package:sept_frontend_draft/page/admin_home_page.dart';
import 'package:sept_frontend_draft/page/admin_setting_page.dart';
import 'package:sept_frontend_draft/page/chat_message_entity.dart';
import 'package:sept_frontend_draft/page/chat_room_page.dart';
import 'package:sept_frontend_draft/page/conversation_page.dart';
import 'package:sept_frontend_draft/page/doctor_home_page.dart';
import 'package:sept_frontend_draft/page/patient_home_page.dart';
import 'package:sept_frontend_draft/page/login_page.dart';
import 'package:sept_frontend_draft/page/register_page.dart';
import 'package:sept_frontend_draft/page/doctor_list_page.dart';
import 'package:sept_frontend_draft/page/patient_appointment_page.dart';
import 'package:sept_frontend_draft/page/patient_list_page.dart';
import 'package:sept_frontend_draft/page/doctor_setting_page.dart';
import 'package:sept_frontend_draft/page/doctor_myappointment_page.dart';
import 'package:sept_frontend_draft/page/patient_myappointment_page.dart';
import 'package:sept_frontend_draft/page/doctor_myappointment_page.dart';
import 'package:sept_frontend_draft/utils/sp_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// init and async the SharedPreferences
class Config {
  static Future dispatchRunMainBefore() async {
    WidgetsFlutterBinding.ensureInitialized();
    return await SpUtils().init();
  }
}

void main() async {
  await Config.dispatchRunMainBefore().then((value) {
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  final routes = <String, WidgetBuilder>{
    '/LoginPage': (context) => LoginPage(),
    '/PatientHomePage': (context) => PatientHomePage(),
    '/DoctorHomePage': (context) => PatientHomePage(),
    '/RegisterPage': (context) => RegisterPage(),
    '/DoctorListPage': (context) => DoctorListPage(),
    '/PatientListPage': (context) => PatientListPage(),
    '/AppointmentPage': (context) => PatientAppointmentPage(),
    '/DoctorSettingPage': (context) => DoctorSettingPage(),
    '/DoctorMyAppointmentPage': (context) => DoctorMyAppointmentPage(),
    '/PatientMyAppointmentPage': (context) => PatientMyAppointmentPage(),
    '/DoctorMyAppointmentPage': (context) => DoctorMyAppointmentPage(),
    '/AddMedcinePage': (context) => AddMedcinePage(),
  };

  @override
  Widget build(BuildContext context) {
    return OKToast(
      child: MaterialApp(
        title: 'SEPT-App',
        debugShowCheckedModeBanner: false,
        theme: new ThemeData(
          primarySwatch: Colors.lightBlue,
        ),
        home: fetchMainPage(),
        routes: routes,
        onGenerateRoute: (setting) {
          if (setting.name == AdminHomePage.sName) {
            return CupertinoPageRoute(builder: (context) {
              return const AdminHomePage();
            });
          } else if (setting.name == AdminSettingPage.sName) {
            return CupertinoPageRoute(builder: (context) {
              return AdminSettingPage(
                map: setting.arguments as Map<String, dynamic>,
              );
            });
          } else if (setting.name == ConversationPage.sName) {
            return CupertinoPageRoute(builder: (context) {
              return const ConversationPage();
            });
          } else if (setting.name == ChatRoomPage.sName) {
            return CupertinoPageRoute(builder: (context) {
              return ChatRoomPage(
                  conversationData: setting.arguments as ConversationEntity);
            });
          }
        },
      ),
    );
  }

  /// fetch has login user or not
  Widget fetchMainPage() {
    /// get current user
    final currentUser = SpUtils.getString('user');
    if (currentUser != null && currentUser.isNotEmpty) {
      /// has login user
      String userType = SpUtils.getString('userType');
      if (userType == 'admin') {
        return AdminHomePage();
      } else if (userType == 'doctor') {
        return DoctorHomePage();
      } else {
        return PatientHomePage();
      }
    } else {
      return LoginPage();
    }
  }
}
