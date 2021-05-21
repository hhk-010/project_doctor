// import 'package:device_preview/device_preview.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:project_doctor/app.dart';
import 'package:project_doctor/generated/codegen_loader.g.dart';
import 'package:stacked_themes/stacked_themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await ThemeManager.initialise();
  await Firebase.initializeApp();

  runApp(
    EasyLocalization(
      supportedLocales: [Locale('en'), Locale('ar')],
      path: 'assets/translations',
      fallbackLocale: Locale('en'),
      assetLoader: CodegenLoader(),
      startLocale: Locale('ar'),
      saveLocale: false,
      useOnlyLangCode: true,
      // child: MyApp(),
      child:
          DevicePreview(enabled: !kReleaseMode, builder: (context) => MyApp()),
    ),
  );
}
