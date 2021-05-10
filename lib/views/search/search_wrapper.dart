import 'package:flutter/material.dart';
import 'package:project_doctor/constants/color_style_size.dart';
import 'package:project_doctor/custom_widges/custom_buttons.dart';
import 'package:project_doctor/custom_widges/custom_home.dart';
import 'package:project_doctor/custom_widges/custom_scaffold.dart';
import 'package:project_doctor/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
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
            height: 300,
            asset: getTheme(context) ? 'assets/images/search/search_wrapper_light.png' : 'assets/images/search/search_wrapper_dark.png',
          ),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.only(top: 200),
              child: Container(
                height: 300,
                width: 300,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SearchWrapperButtons(
                      title: 'search.name_speciality'.tr(),
                      onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProfileSearchView())),
                    ),
                    SearchWrapperButtons(
                      title: 'search.complain'.tr(),
                      onPressed: null,
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
