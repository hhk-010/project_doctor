import 'package:flutter/material.dart';
import 'package:project_doctor/authorization/05_register.dart';
import 'package:project_doctor/authorization/email_verfication.dart';
import 'package:project_doctor/pages/about_us.dart';
import 'package:project_doctor/pages/doctor_pages/doctor02_clinic.dart';
import 'package:project_doctor/pages/doctor_pages/doctor05.5_update_info2.dart';
import 'package:project_doctor/pages/patient_pages/patient02.5_speciality_result.dart';
import 'package:project_doctor/pages/patient_pages/patient03_get_location.dart';
import 'package:project_doctor/pages/patient_pages/patient04_map.dart';
import 'package:project_doctor/pages/patient_pages/patient06_result_map.dart';
import 'package:project_doctor/pages/home.dart';
import 'package:project_doctor/authorization/01_wrapper.dart';
import 'package:project_doctor/pages/patient_pages/patient01_complain.dart';
import 'package:project_doctor/pages/patient_pages/patient02_risk_factors.dart';
import 'package:project_doctor/pages/doctor_pages/doctor01_form.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:project_doctor/pages/doctor_pages/doctor04_profile.dart';
import 'package:project_doctor/pages/patient_pages/patient05_result.dart';
import 'package:project_doctor/services/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.deepOrange,
  ));
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  static void setLocale(BuildContext context, Locale locale) {
    _MyAppState state = context.findAncestorStateOfType<_MyAppState>();
    state.setLocale(locale);
  }

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale _locale;
  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  void didChangeDependencies() {
    getLocale().then((locale) {
      setState(() {
        this._locale = locale;
      });
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    if (_locale == null) {
      return Container(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else {
      return GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus &&
              currentFocus.focusedChild != null) {
            currentFocus.focusedChild.unfocus();
          }
        },
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Cura',
          builder: (context, navigator) {
            var lang = Localizations.localeOf(context).languageCode;
            return Theme(
              data: ThemeData(
                  fontFamily: lang == 'ar' ? 'noto_arabic' : 'Helvetica'),
              child: navigator,
            );
          },
          theme: ThemeData(
            primaryColor: Colors.deepOrange,
          ),
          locale: _locale,
          supportedLocales: [
            Locale('en', 'US'),
            Locale("ar", "IQ"),
          ],
          localizationsDelegates: [
            AppLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          localeResolutionCallback: (deviceLocale, supportedLocales) {
            for (var locale in supportedLocales) {
              if (locale.languageCode == deviceLocale.languageCode &&
                  locale.countryCode == deviceLocale.countryCode) {
                return deviceLocale;
              }
            }
            return supportedLocales.first;
          },
          initialRoute: '/home',
          routes: {
            '/home': (context) => Home(),
            '/about_us': (context) => AboutUS(),
            '/intermediate': (context) => Intermediate(),
            '/patient_complain': (context) => PatientComplain(),
            '/doctor_form': (context) => DoctorForm(),
            '/doctor_clinic': (context) => ClinicForm(),
            '/doctor_profile': (context) => DoctorProfile(),
            '/patient_risk_factors': (context) => PatientRiskFactors(),
            '/patient_speciality_result': (context) => SpecialityResult(),
            '/patient_get_location': (context) => PatientGetLocation(),
            '/patient_result': (context) => PatientResult(),
            '/patmap': (context) => PatientMap(),
            '/doctorlocate': (context) => PatientResultMap(),
            '/email_verfication': (context) => EmailVerification(),
            '/register': (context) => Register(),
            '/update2': (context) => UpdateInfo2(),
          },
        ),
      );
    }
  }
}
