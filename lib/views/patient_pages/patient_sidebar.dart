import 'package:flutter/material.dart';
import 'package:project_doctor/constants/color_style_size.dart';
import 'package:project_doctor/constants/locale_keys.g.dart';
import 'package:project_doctor/services/data_model.dart';
import 'package:easy_localization/easy_localization.dart';

class PatientSidebar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Container(
        padding: EdgeInsets.symmetric(vertical: getDeviceType(context, 10, 20, 30, 40), horizontal: getDeviceType(context, 10, 20, 30, 40)),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: getDeviceType(context, 60, 70, 80, 90),
              ),
              TextButton.icon(
                onPressed: () {
                  int count = 0;
                  Navigator.popUntil(context, (route) => count++ == 2);
                  Navigator.pushNamed(context, '/patient_complain');
                },
                icon: Icon(
                  Icons.new_releases,
                  color: SelectedPage.complaintSelected ? Colors.deepOrange : Colors.black,
                ),
                label: Text(
                  LocaleKeys.view_new_search_name_search.tr(),
                  style: TextStyle(
                    color: SelectedPage.complaintSelected ? Colors.deepOrange : Colors.black,
                    fontSize: getDeviceType(context, 12, 16, 23, 25),
                  ),
                ),
              ),
              Divider(
                color: Colors.black,
              ),
              TextButton.icon(
                onPressed: () {
                  int count = 0;
                  Navigator.popUntil(context, (route) => count++ == 2);
                  Navigator.pushNamed(context, '/new search');
                },
                icon: Icon(
                  Icons.search,
                  color: SelectedPage.newSearchSelected ? Colors.deepOrange : Colors.black,
                ),
                label: Text(
                  LocaleKeys.view_last_search_name_speciality_search.tr(),
                  style: TextStyle(
                    color: SelectedPage.newSearchSelected ? Colors.deepOrange : Colors.black,
                    fontSize: getDeviceType(context, 12, 16, 23, 25),
                  ),
                ),
              ),
              Divider(
                color: Colors.black,
              ),
              TextButton.icon(
                onPressed: () {
                  int count = 0;
                  Navigator.popUntil(context, (route) => count++ == 2);
                  Navigator.pushNamed(context, '/last_searched_profile');
                },
                icon: Icon(
                  Icons.last_page,
                  color: SelectedPage.lastSearchSelected ? Colors.deepOrange : Colors.black,
                ),
                label: Text(
                  LocaleKeys.view_last_search_last_search.tr(),
                  style: TextStyle(
                    color: SelectedPage.lastSearchSelected ? Colors.deepOrange : Colors.black,
                    fontSize: getDeviceType(context, 12, 16, 23, 25),
                  ),
                ),
              ),
              Divider(
                color: Colors.black,
              ),
              TextButton.icon(
                onPressed: () {
                  int count = 0;
                  Navigator.popUntil(context, (route) => count++ == 2);
                  Navigator.pushNamed(context, '/favorite list');
                },
                icon: Icon(
                  Icons.star,
                  color: SelectedPage.favoriteSelected ? Colors.deepOrange : Colors.black,
                ),
                label: Text(
                  LocaleKeys.view_favorite_list_preferred.tr(),
                  style: TextStyle(
                    color: SelectedPage.favoriteSelected ? Colors.deepOrange : Colors.black,
                    fontSize: getDeviceType(context, 12, 16, 23, 25),
                  ),
                ),
              ),
              Divider(
                color: Colors.black,
              ),
              TextButton.icon(
                onPressed: () {
                  int count = 0;
                  Navigator.popUntil(context, (route) => count++ == 2);
                },
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
                label: Text(
                  LocaleKeys.view_last_search_back.tr(),
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: getDeviceType(context, 12, 16, 23, 25),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
