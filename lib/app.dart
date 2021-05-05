import 'package:flutter/material.dart';
import 'package:project_doctor/constants/color_style_size.dart';
import 'package:project_doctor/favorite_list/doctor_location_map.dart';
import 'package:project_doctor/favorite_list/favorite_list.dart';
import 'package:project_doctor/favorite_list/patient_location.dart';
import 'package:project_doctor/favorite_list/patient_map.dart';
import 'package:project_doctor/favorite_list/result_view.dart';
import 'package:project_doctor/new_search/new_search.dart';
import 'package:project_doctor/new_search/search_list.dart';
import 'package:project_doctor/pages/doctor_pages/doctor02_clinic.dart';
import 'package:project_doctor/pages/doctor_pages/doctor05.5_update_clinic.dart';
import 'package:project_doctor/pages/doctor_pages/doctor07_update_password.dart';
import 'package:project_doctor/pages/doctor_pages/validate_user.dart';
import 'package:project_doctor/pages/last_searched/Profile.dart';
import 'package:project_doctor/pages/patient_pages/patient02.5_speciality_result.dart';
import 'package:project_doctor/pages/patient_pages/patient03_get_location.dart';
import 'package:project_doctor/pages/patient_pages/patient04_map.dart';
import 'package:project_doctor/pages/patient_pages/patient06_result_map.dart';
import 'package:project_doctor/pages/patient_pages/patient01_complain.dart';
import 'package:project_doctor/pages/patient_pages/patient02_risk_factors.dart';
import 'package:project_doctor/pages/doctor_pages/doctor01_form.dart';
import 'package:project_doctor/pages/doctor_pages/doctor04_profile.dart';
import 'package:project_doctor/pages/patient_pages/patient05_result.dart';
import 'package:project_doctor/views/home/home_view.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:project_doctor/views/profile/authorization/sign_wrapper.dart';
import 'package:project_doctor/views/profile/authorization/mcqs.dart';
import 'package:project_doctor/views/profile/authorization/sign_up.dart';
import 'package:project_doctor/views/profile/authorization/email_verfication.dart';
import 'package:stacked_themes/stacked_themes.dart';

import 'views/profile/authorization/loading.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ThemeBuilder(
      statusBarColorBuilder: (theme) => theme.primaryColor,
      defaultThemeMode: ThemeMode.system,
      lightTheme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
        brightness: Brightness.light,
        primaryColor: LightPalette.homeButton1,
        fontFamily: getLocale(context) ? 'Montserrat' : 'noto_arabic',
        scaffoldBackgroundColor: Colors.transparent,
      ),
      darkTheme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
        brightness: Brightness.dark,
        primaryColor: DarkPalette.background1,
        fontFamily: getLocale(context) ? 'Montserrat' : 'noto_arabic',
        scaffoldBackgroundColor: Colors.transparent,
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
          title: 'Cura Mobile',
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: themeMode,
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          home: HomeView(),
          routes: {
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
