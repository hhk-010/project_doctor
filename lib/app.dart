import 'package:flutter/material.dart';
import 'package:project_doctor/constants/color_style_size.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:project_doctor/views/home/main_view.dart';
import 'package:stacked_themes/stacked_themes.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ThemeBuilder(
      statusBarColorBuilder: (theme) => theme.primaryColor,
      defaultThemeMode: ThemeMode.system,
      lightTheme: ThemeData(
        canvasColor: Colors.transparent,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        brightness: Brightness.light,
        primaryColor: LightPalette.homeButton1,
        fontFamily: getLocale(context) ? 'Montserrat' : 'noto_arabic',
        scaffoldBackgroundColor: Colors.transparent,
      ),
      darkTheme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
        canvasColor: Colors.transparent,
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
          home: MainView(),
          routes: {
            // '/loading': (context) => Loading(),
            // '/intermediate': (context) => Intermediate(),
            // '/patient_complain': (context) => PatientComplain(),
            // '/doctor_form': (context) => DoctorForm(),
            // '/doctor_clinic': (context) => ClinicForm(),
            // '/doctor_profile': (context) => DoctorProfile(),
            // '/patient_risk_factors': (context) => PatientRiskFactors(),
            // '/patient_speciality_result': (context) => SpecialityResult(),
            // '/patient_get_location': (context) => PatientGetLocation(),
            // '/patient_result': (context) => PatientResult(),
            // '/patmap': (context) => PatientMap(),
            // '/doctorlocate': (context) => PatientResultMap(),
            // '/email_verfication': (context) => EmailVerification(),
            // '/register': (context) => Register(),
            // '/update2': (context) => UpdateInfo2(),
            // '/update_password': (context) => UpdatePassword(),
            // '/last_searched_profile': (context) => LastSearchedDoctor(),
            // '/questions': (context) => QuestionsWidget(),
            // '/pre_delete': (context) => PreDeleteUser(),
            // '/favorite list': (context) => FavoriteListView(),
            // '/new search': (context) => NewSearch(),
            // '/search listview': (context) => SearchListView(),
            // '/search resultview': (context) => SearchResultView(),
            // '/patient searchmap': (context) => PatientSearchmap(),
            // '/patient location': (context) => PatientLocation(),
            // '/doctor location map': (context) => DoctorLocationmap(),
          },
        ),
      ),
    );
  }
}
