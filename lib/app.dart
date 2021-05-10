import 'package:flutter/material.dart';
import 'package:project_doctor/constants/color_style_size.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:project_doctor/views/auth/email_verify.dart';
import 'package:project_doctor/views/auth/questions_view.dart';
import 'package:project_doctor/views/auth/reset_password.dart';
import 'package:project_doctor/views/auth/sign_in.dart';
import 'package:project_doctor/views/auth/sign_up.dart';
import 'package:project_doctor/views/auth/sign_wrapper.dart';
import 'package:project_doctor/views/home/home.dart';
import 'package:project_doctor/views/home/support.dart';
import 'package:project_doctor/views/profile/1_profile_data.dart';
import 'package:project_doctor/views/profile/2_clinic_data.dart';
import 'package:project_doctor/views/profile/3_map_data.dart';
import 'package:project_doctor/views/profile/4_profile.dart';
import 'package:project_doctor/views/profile/5_profile_data_update.dart';
import 'package:project_doctor/views/profile/6_clinic_data_update.dart';
import 'package:project_doctor/views/profile/7_map_data_update.dart';
import 'package:project_doctor/views/profile/delete_profile.dart';
import 'package:project_doctor/views/profile/password_update.dart';
import 'package:project_doctor/views/search/search_profile/profile_search.dart';
import 'package:project_doctor/views/search/search_wrapper.dart';
import 'package:stacked_themes/stacked_themes.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ThemeBuilder(
      statusBarColorBuilder: (theme) => theme.primaryColor,
      defaultThemeMode: ThemeMode.light,
      lightTheme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
        primaryColor: LightPalette.gradientTop,
        brightness: Brightness.light,
        fontFamily: getLocale(context) ? 'Montserrat' : 'noto_arabic',
        scaffoldBackgroundColor: Colors.transparent,
      ),
      darkTheme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
        
        primaryColor: DarkPalette.gradientTop,
        brightness: Brightness.dark,
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
            '/home_view': (context) => HomeView(),
            '/support_view' : (context) => SupportView(),
            '/sign_wrapper' : (context) => Intermediate(),
            '/sign_in_view' : (context) => SignInView(),
            '/sign_up_view' : (context) => SignUpView(),
            '/mcq_view' : (context) => QuestionView(),
            '/email_verify_view' : (context) => EmailVeriyView(),
            '/reset_password_view' : (context) => ResetPasswordView(),
            '/reset_password_view2' : (context) => ResetPasswordView2(),
            '/profile_data_view' : (context) => ProfileDataView(),
            '/clinic_data_view' : (context) => ClinicView(),
            '/map_data_view' : (context) => MapViewStream(),
            '/profile_view' : (context) => ProfileViewHeader(),
            '/profile_update_view' : (context) => UpdateProfileDataView(),
            '/clinic_update_view' : (context) => UpdateClinicView(),
            '/map_update_view' : (context) => UpdateaMapViewStream(),
            '/delete_profile_view' : (context) => DeleteProfileView(),
            '/password_update_view' : (context) => PasswordUpdateView(),
            '/search_wrapper' : (context) => SearchWrapper(),
            '/profile_search' : (context) => ProfileSearchView(),
          },
        ),
      ),
    );
  }
}
