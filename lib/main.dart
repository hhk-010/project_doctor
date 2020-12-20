// import 'package:device_preview/device_preview.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:project_doctor/authorization/04_mcqs_new.dart';
import 'package:project_doctor/authorization/05_register.dart';
import 'package:project_doctor/authorization/email_verfication.dart';
import 'package:project_doctor/authorization/loading.dart';
import 'package:project_doctor/pages/Support.dart';
import 'package:project_doctor/pages/doctor_pages/doctor02_clinic.dart';
import 'package:project_doctor/pages/doctor_pages/doctor05.5_update_clinic.dart';
import 'package:project_doctor/pages/doctor_pages/doctor07_update_password.dart';
import 'package:project_doctor/pages/doctor_pages/validate_user.dart';
import 'package:project_doctor/pages/last_searched/Profile.dart';
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
  await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.deepOrange,
    ),
  );

  runApp(MyApp());

  // runApp(
  //   DevicePreview(enabled: !kReleaseMode, builder: (context) => MyApp()),
  // );
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

  FirebaseAnalytics analytics = FirebaseAnalytics();

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
          if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
            FocusManager.instance.primaryFocus.unfocus();
          }
        },
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          navigatorObservers: [
            FirebaseAnalyticsObserver(analytics: analytics),
          ],

          title: 'Cura',
          // builder: DevicePreview.appBuilder,
          builder: (context, navigator) {
            var lang = Localizations.localeOf(context).languageCode;
            return Theme(
              data: ThemeData(fontFamily: lang == 'ar' ? 'noto_arabic' : 'Helvetica'),
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
              if (locale.languageCode == deviceLocale.languageCode && locale.countryCode == deviceLocale.countryCode) {
                return deviceLocale;
              }
            }
            return supportedLocales.first;
          },
          initialRoute: '/home',
          routes: {
            '/home': (context) => Home(),
            '/support': (context) => Support(),
            '/loading': (context) => Loading(),
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
            '/update_password': (context) => UpdatePassword(),
            '/last_searched_profile': (context) => LastSearchedDoctor(),
            '/questions': (context) => QuestionsWidget(),
            '/pre_delete': (context) => PreDeleteUser(),
          },
        ),
      );
    }
  }
}
