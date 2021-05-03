import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import 'package:project_doctor/authorization/04_mcqs_new.dart';
import 'package:project_doctor/authorization/05_register.dart';
import 'package:project_doctor/authorization/email_verfication.dart';
import 'package:project_doctor/authorization/loading.dart';
import 'package:project_doctor/constants.dart';
import 'package:project_doctor/favorite_list/doctor_location_map.dart';
import 'package:project_doctor/favorite_list/favorite_list.dart';
import 'package:project_doctor/favorite_list/patient_location.dart';
import 'package:project_doctor/favorite_list/patient_map.dart';
import 'package:project_doctor/favorite_list/result_view.dart';
import 'package:project_doctor/new_search/new_search.dart';
import 'package:project_doctor/new_search/search_list.dart';
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
import 'package:project_doctor/pages/doctor_pages/doctor04_profile.dart';
import 'package:project_doctor/pages/patient_pages/patient05_result.dart';
import 'package:project_doctor/views/home/home_view.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:stacked_themes/stacked_themes.dart';

class MyApp extends StatelessWidget {
  final FirebaseAnalytics analytics = FirebaseAnalytics();

  @override
  Widget build(BuildContext context) {
    return ThemeBuilder(
      statusBarColorBuilder: (theme) => theme.primaryColor,
      defaultThemeMode: ThemeMode.system,
      lightTheme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
        brightness: Brightness.light,
        backgroundColor: Colors.grey[200],
        primaryColor: const Color(0xFFFD6836),
        fontFamily: getLocale(context) == "en" ? 'Nova' : 'noto_arabic',
        textTheme: TextTheme(
          headline1: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      darkTheme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
        brightness: Brightness.dark,
        backgroundColor: const Color(0xFF1A253D),
        primaryColor: const Color(0xFF0D142D),
        fontFamily: getLocale(context) == "en" ? 'Nova' : 'noto_arabic',
        textTheme: TextTheme(
          headline1: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      builder: (context, lightTheme, darkTheme, themeMode) => GestureDetector(
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
          title: 'Cura Mobile',
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: themeMode,
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          initialRoute: '/home_view',
          routes: {
            '/home_view': (context) => HomeView(),
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
            '/favorite list': (context) => FavoriteListView(),
            '/new search': (context) => NewSearch(),
            '/search listview': (context) => SearchListView(),
            '/search resultview': (context) => SearchResultView(),
            '/patient searchmap': (context) => PatientSearchmap(),
            '/patient location': (context) => PatientLocation(),
            '/doctor location map': (context) => DoctorLocationmap(),
          },
        ),
      ),
    );
  }
}
