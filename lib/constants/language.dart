import 'package:flutter/cupertino.dart';
import 'package:project_doctor/services/app_localizations.dart';

class Language {
  final int id;
  final String name;
  final String languageCode;

  Language(this.id, this.name, this.languageCode);

  static List<Language> languageList(BuildContext context) {
    return <Language>[
      Language(1, AppLocalizations.of(context).translate('english'), 'en'),
      Language(2, AppLocalizations.of(context).translate('arabic'), 'ar'),
    ];
  }
}
