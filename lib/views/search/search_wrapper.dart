import 'package:flutter/material.dart';
import 'package:project_doctor/constants/color_style_size.dart';
import 'package:project_doctor/custom_widges/custom_buttons.dart';
import 'package:project_doctor/custom_widges/custom_home.dart';
import 'package:project_doctor/custom_widges/custom_scaffold.dart';
import 'package:project_doctor/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:project_doctor/views/search/search_complain/get_age_complain.dart';
import 'package:project_doctor/views/search/search_history/history_profile.dart';
import 'package:project_doctor/views/search/search_profile/profile_search.dart';

class SearchWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      isAppbar: true,
      title: LocaleKeys.view_buttons_search.tr(),
      action: getAppActions(context),
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          HomeAlignWidgets(
            alignment: Alignment.topCenter,
            padding: EdgeInsets.all(0.0),
            isIcon: false,
            width: MediaQuery.of(context).size.width,
            height: getDeviceType(context, 250, 300, 500, 700),
            asset: getTheme(context) ? 'assets/images/search/search_wrapper_light.png' : 'assets/images/search/search_wrapper_dark.png',
          ),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.only(
                top: getDeviceType(context, 250, 200, 500, 650),
              ),
              child: Container(
                height: getDeviceType(context, 200, 300, 350, 400),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SearchWrapperButtons(
                      title: 'search.name_speciality'.tr(),
                      onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProfileSearchView())),
                    ),
                    SearchWrapperButtons(
                      title: 'search.complain'.tr(),
                      onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => AgeComplainView())),
                    ),
                    SearchWrapperButtons(
                      title: 'search.history'.tr(),
                      onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => SearchHistoryProfile())),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
