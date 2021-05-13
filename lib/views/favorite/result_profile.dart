import 'dart:io';
import 'package:flutter/material.dart';
import 'package:project_doctor/constants/color_style_size.dart';
import 'package:project_doctor/custom_widges/custom_buttons.dart';
import 'package:project_doctor/custom_widges/custom_flushbar.dart';
import 'package:project_doctor/custom_widges/custom_profile.dart';
import 'package:project_doctor/custom_widges/custom_scaffold.dart';
import 'package:project_doctor/generated/locale_keys.g.dart';
import 'package:project_doctor/services/data_model.dart';
import 'package:project_doctor/services/read_write_path.dart';
import 'package:project_doctor/views/favorite/result_map.dart';
import 'package:project_doctor/views/favorite/favorite_list.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class FavoriteProfileResultView extends StatefulWidget {
  final Storage storage = Storage();
  @override
  _FavoriteProfileResultViewState createState() => _FavoriteProfileResultViewState();
}

class _FavoriteProfileResultViewState extends State<FavoriteProfileResultView> {
  final RoundedLoadingButtonController _controller = RoundedLoadingButtonController();
  String favored01 = '';
  String favored02 = '';
  String favored03 = '';
  String favored04 = '';
  String favored05 = '';
  String favored06 = '';
  String favored07 = '';
  String favored08 = '';
  String favored09 = '';
  String favored10 = '';

  Future<File> _writeFavorite01(String value) {
    setState(() => favored01 = value);
    return widget.storage.writeFavorite01(favored01);
  }

  Future<File> _writeFavorite02(String value) {
    setState(() => favored02 = value);
    return widget.storage.writeFavorite02(favored02);
  }

  Future<File> _writeFavorite03(String value) {
    setState(() => favored03 = value);
    return widget.storage.writeFavorite03(favored03);
  }

  Future<File> _writeFavorite04(String value) {
    setState(() => favored04 = value);
    return widget.storage.writeFavorite04(favored04);
  }

  Future<File> _writeFavorite05(String value) {
    setState(() => favored05 = value);
    return widget.storage.writeFavorite05(favored05);
  }

  Future<File> _writeFavorite06(String value) {
    setState(() => favored06 = value);
    return widget.storage.writeFavorite06(favored06);
  }

  Future<File> _writeFavorite07(String value) {
    setState(() => favored07 = value);
    return widget.storage.writeFavorite07(favored07);
  }

  Future<File> _writeFavorite08(String value) {
    setState(() => favored08 = value);
    return widget.storage.writeFavorite08(favored08);
  }

  Future<File> _writeFavorite09(String value) {
    setState(() => favored09 = value);
    return widget.storage.writeFavorite09(favored09);
  }

  Future<File> _writeFavorite10(String value) {
    setState(() => favored10 = value);
    return widget.storage.writeFavorite10(favored10);
  }

 
  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      title: LocaleKeys.view_search_result_list_doctor_info.tr(),
      isAppbar: true,
      action: IconButton(
        onPressed: () async {
          await widget.storage.readFavorite01().then((value) => setState(() => Favorite.favorite01 = value));
          await widget.storage.readFavorite02().then((value) => setState(() => Favorite.favorite02 = value));
          await widget.storage.readFavorite03().then((value) => setState(() => Favorite.favorite03 = value));
          await widget.storage.readFavorite04().then((value) => setState(() => Favorite.favorite04 = value));
          await widget.storage.readFavorite05().then((value) => setState(() => Favorite.favorite05 = value));
          await widget.storage.readFavorite06().then((value) => setState(() => Favorite.favorite06 = value));
          await widget.storage.readFavorite07().then((value) => setState(() => Favorite.favorite07 = value));
          await widget.storage.readFavorite08().then((value) => setState(() => Favorite.favorite08 = value));
          await widget.storage.readFavorite09().then((value) => setState(() => Favorite.favorite09 = value));
          await widget.storage.readFavorite10().then((value) => setState(() => Favorite.favorite10 = value));
          setState(() => Favorite.favoriteIdlist = [
                Favorite.favorite01,
                Favorite.favorite02,
                Favorite.favorite03,
                Favorite.favorite04,
                Favorite.favorite05,
                Favorite.favorite06,
                Favorite.favorite07,
                Favorite.favorite08,
                Favorite.favorite09,
                Favorite.favorite10
              ]);
          if (!FavoriteTile.favoriteListSelected) {
            if (Favorite.favoriteIdlist.contains(SearchResultData.id.toString())) {
              getFlushbar(context, LocaleKeys.view_patient_added_previously.tr(), _controller);
            } else {
              await _writeFavorite01(SearchResultData.id.toString());
              await _writeFavorite02(Favorite.favorite01);
              await _writeFavorite03(Favorite.favorite02);
              await _writeFavorite04(Favorite.favorite03);
              await _writeFavorite05(Favorite.favorite04);
              await _writeFavorite06(Favorite.favorite05);
              await _writeFavorite07(Favorite.favorite06);
              await _writeFavorite08(Favorite.favorite07);
              await _writeFavorite09(Favorite.favorite08);
              await _writeFavorite10(Favorite.favorite09);
              getFlushbar(context, LocaleKeys.view_patient_added_successfully.tr(), _controller);

            }
          } else {
            int count = 1;
            for (String id in Favorite.favoriteIdlist) {
              if (SearchResultData.id.toString() == id) {
                if (count == 1) {
                  await _writeFavorite01('');
                } else if (count == 2) {
                  await _writeFavorite02('');
                } else if (count == 3) {
                  await _writeFavorite03('');
                } else if (count == 4) {
                  await _writeFavorite04('');
                } else if (count == 5) {
                  await _writeFavorite05('');
                } else if (count == 6) {
                  await _writeFavorite06('');
                } else if (count == 7) {
                  await _writeFavorite07('');
                } else if (count == 8) {
                  await _writeFavorite08('');
                } else if (count == 9) {
                  await _writeFavorite09('');
                } else if (count == 10) {
                  await _writeFavorite10('');
                }
              }
              count++;
            }
              getFlushbar(context, LocaleKeys.view_search_result_list_removed_successfully.tr(), _controller);
            
          }
        },
        icon: Icon(
          FavoriteTile.favoriteListSelected ? Icons.star_border : Icons.star,
          color: Colors.white,
        ),
      ),
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Positioned(
            top: 50,
            child: Container(
              height: 600,
              width: 350,
              decoration: CustomStyle.box,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              child: ListView(
                children: [
                  Container(
                    height: 200,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.deepOrange,
                          radius: 50,
                          backgroundImage: AssetImage('assets/images/doctor.png'),
                        ),
                        Text(
                          SearchResultData.name,
                          style: CustomStyle.getTitleBlack(context).copyWith(fontFamily: 'noto_arabic'),
                        ),
                        Text(
                          (SearchResultData.province).tr(),
                          style: CustomStyle.getFooter(context),
                        ),
                        Divider(
                          color: Colors.grey[600],
                          thickness: 3,
                          indent: 25,
                          endIndent: 25,
                        ),
                      ],
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomProfileColumn(
                        title: LocaleKeys.view_doctor_speciality.tr(),
                        content: (SearchResultData.speciality).tr(),
                      ),
                      CustomProfilePhoneCalling(
                        title: LocaleKeys.view_doctor_phoneNumber.tr(),
                        content: SearchResultData.phoneNumber,
                      ),
                      CustomProfileColumn(
                        title: LocaleKeys.view_doctor_clinic_address.tr(),
                        content: SearchResultData.address,
                      ),
                      CustomProfileColumn2(
                        title: LocaleKeys.view_doctor_clinic_work.tr(),
                        content: SearchResultData.workDays01.toString(),
                      ),
                      SearchResultData.firstDay.isEmpty
                          ? SizedBox(
                              height: 5,
                            )
                          : CustomProfileColumn2(
                              title: LocaleKeys.view_doctor_another_clinic_work.tr(),
                              content: SearchResultData.firstDay +
                                  " " +
                                  SearchResultData.firstTime +
                                  '\n' +
                                  SearchResultData.secondDay +
                                  " " +
                                  SearchResultData.secondTime,
                            ),
                      CustomProfileColumn(
                        title: LocaleKeys.view_patient_result_distances.tr(),
                        content: SearchResultData.distance.toString() + " " + LocaleKeys.view_patient_result_km.tr(),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 40),
              child: BaseButton(
                title: 'view_patient_result.doctor_locat'.tr(),
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => FavoriteMapResultView()),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
