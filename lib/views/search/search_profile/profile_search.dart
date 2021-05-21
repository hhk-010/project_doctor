import 'package:flutter/material.dart';
import 'package:project_doctor/constants/color_style_size.dart';
import 'package:project_doctor/custom_widges/custom_buttons.dart';
import 'package:project_doctor/custom_widges/custom_dropdownbutton.dart';
import 'package:project_doctor/custom_widges/custom_flushbar.dart';
import 'package:project_doctor/custom_widges/custom_scaffold.dart';
import 'package:project_doctor/generated/locale_keys.g.dart';
import 'package:project_doctor/services/connectivity.dart';
import 'package:project_doctor/services/data_model.dart';
import 'package:project_doctor/services/database.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:project_doctor/views/search/search_profile/profile_search_result.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class ProfileSearchView extends StatefulWidget {
  @override
  _ProfileSearchViewState createState() => _ProfileSearchViewState();
}

class _ProfileSearchViewState extends State<ProfileSearchView> {
  final RoundedLoadingButtonController _controller = RoundedLoadingButtonController();
  bool _nameSelected = false;
  bool _specialitySelected = false;
  @override
  void initState() {
    super.initState();
    ProfileSearchData.province = null;
    ProfileSearchData.name = '';
    ProfileSearchData.speciality = '';
  }

  @override
  Widget build(BuildContext context) {
    final province = {
      "1": [
        "Erbil",
        LocaleKeys.iraq_provinces_Erbil.tr(),
      ],
      "2": [
        "Al Anbar",
        LocaleKeys.iraq_provinces_Al_Anbar.tr(),
      ],
      "3": [
        "Basra",
        LocaleKeys.iraq_provinces_Basra.tr(),
      ],
      "4": [
        "Al Qadisiyyah",
        LocaleKeys.iraq_provinces_Al_Qadisiyyah.tr(),
      ],
      "5": [
        "Muthanna",
        LocaleKeys.iraq_provinces_Muthanna.tr(),
      ],
      "6": [
        "Najaf",
        LocaleKeys.iraq_provinces_Najaf.tr(),
      ],
      "7": [
        "Babil",
        LocaleKeys.iraq_provinces_Babil.tr(),
      ],
      "8": [
        'Baghdad',
        LocaleKeys.iraq_provinces_Baghdad.tr(),
      ],
      "9": [
        "Duhok",
        LocaleKeys.iraq_provinces_Duhok.tr(),
      ],
      "10": [
        "Diyala",
        LocaleKeys.iraq_provinces_Diyala.tr(),
      ],
      "11": [
        "Dhi Qar",
        LocaleKeys.iraq_provinces_Dhi_Qar.tr(),
      ],
      "12": [
        "Sulaymaniyah",
        LocaleKeys.iraq_provinces_Sulaymaniyah.tr(),
      ],
      "13": [
        "Saladin",
        LocaleKeys.iraq_provinces_Saladin.tr(),
      ],
      "14": [
        "Karbala",
        LocaleKeys.iraq_provinces_Karbala.tr(),
      ],
      "15": [
        "Kirkuk",
        LocaleKeys.iraq_provinces_Kirkuk.tr(),
      ],
      "16": [
        "Maysan",
        LocaleKeys.iraq_provinces_Maysan.tr(),
      ],
      "17": [
        "Nineveh",
        LocaleKeys.iraq_provinces_Nineveh.tr(),
      ],
      "18": [
        "Wasit",
        LocaleKeys.iraq_provinces_Wasit.tr(),
      ],
    };
    final Map specialities = {
      "1": ['Internist'.tr(), 'Internist'],
      "2": ['Pediatrician'.tr(), 'Pediatrician'],
      "3": ['Cardiologist'.tr(), 'Cardiologist'],
      "4": ['Pulmonologist'.tr(), 'Pulmonologist'],
      "5": ['Endocrinologist'.tr(), 'Endocrinologist'],
      "6": ['Enterologist'.tr(), 'Enterologist'],
      "7": ['Neurologist'.tr(), 'Neurologist'],
      "8": ['Neurosurgeon'.tr(), 'Neurosurgeon'],
      "9": ['Heamatologist'.tr(), 'Heamatologist'],
      "10": ['Nephrologist'.tr(), 'Nephrologist'],
      "11": ['Rheumatologist'.tr(), 'Rheumatologist'],
      "12": ['Emergency physician'.tr(), 'Emergency physician'],
      "13": ['Dermatologist'.tr(), 'Dermatologist'],
      "14": ['Psychiatrist'.tr(), 'Psychiatrist'],
      "15": ['Gynecologist'.tr(), 'Gynecologist'],
      "16": ['General Surgeon'.tr(), 'General Surgeon'],
      "17": ['Pediatric Surgeon'.tr(), 'Pediatric Surgeon'],
      "18": ['ThoracoVascular Surgeon'.tr(), 'ThoracoVascular Surgeon'],
      "19": ['Orthopaedic Surgeon'.tr(), 'Orthopaedic Surgeon'],
      "20": ['Urosurgeon'.tr(), 'Urosurgeon'],
      "21": ['Plastic Surgeon'.tr(), 'Plastic Surgeon'],
      "22": ['Ophthalmologist'.tr(), 'Ophthalmologist'],
      "23": ['Laryngologist'.tr(), 'Laryngologist'],
    };
    return BaseScaffold(
      title: LocaleKeys.view_buttons_search.tr(),
      isAppbar: true,
      action: getAppActions(context),
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Padding(
            padding: EdgeInsets.only(top: getDeviceType(context, 15, 25, 50, 75)),
            child: Container(
              height: getDeviceType(context, 230, 300, 400, 500),
              width: getDeviceType(context, 250, 300, 400, 500),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    LocaleKeys.view_doctor_province.tr(),
                    style: CustomStyle.getTitleBlack(context),
                  ),
                  Divider(
                    color: Colors.grey,
                    thickness: 2,
                    indent: 75,
                    endIndent: 75,
                  ),
                  CustomDropDownButton(
                    hint: LocaleKeys.view_new_search_governorate.tr(),
                    value: ProfileSearchData.province,
                    onChanged: (value) {
                      setState(() {
                        ProfileSearchData.province = value;
                        DatabaseService.province = value;
                      });
                    },
                    items: [
                      DropdownMenuItem(
                        value: province["1"][0],
                        child: Text(
                          province["1"][1],
                          style: CustomStyle.getSubtitle(context),
                        ),
                      ),
                      DropdownMenuItem(
                        value: province["2"][0],
                        child: Text(
                          province["2"][1],
                          style: CustomStyle.getSubtitle(context),
                        ),
                      ),
                      DropdownMenuItem(
                        value: province["3"][0],
                        child: Text(
                          province["3"][1],
                          style: CustomStyle.getSubtitle(context),
                        ),
                      ),
                      DropdownMenuItem(
                        value: province["4"][0],
                        child: Text(
                          province["4"][1],
                          style: CustomStyle.getSubtitle(context),
                        ),
                      ),
                      DropdownMenuItem(
                        value: province["5"][0],
                        child: Text(
                          province["5"][1],
                          style: CustomStyle.getSubtitle(context),
                        ),
                      ),
                      DropdownMenuItem(
                        value: province["6"][0],
                        child: Text(
                          province["6"][1],
                          style: CustomStyle.getSubtitle(context),
                        ),
                      ),
                      DropdownMenuItem(
                        value: province["7"][0],
                        child: Text(
                          province["7"][1],
                          style: CustomStyle.getSubtitle(context),
                        ),
                      ),
                      DropdownMenuItem(
                        value: province["8"][0],
                        child: Text(
                          province["8"][1],
                          style: CustomStyle.getSubtitle(context),
                        ),
                      ),
                      DropdownMenuItem(
                        value: province["9"][0],
                        child: Text(
                          province["9"][1],
                          style: CustomStyle.getSubtitle(context),
                        ),
                      ),
                      DropdownMenuItem(
                        value: province["10"][0],
                        child: Text(
                          province["10"][1],
                          style: CustomStyle.getSubtitle(context),
                        ),
                      ),
                      DropdownMenuItem(
                        value: province["11"][0],
                        child: Text(
                          province["11"][1],
                          style: CustomStyle.getSubtitle(context),
                        ),
                      ),
                      DropdownMenuItem(
                        value: province["12"][0],
                        child: Text(
                          province["12"][1],
                          style: CustomStyle.getSubtitle(context),
                        ),
                      ),
                      DropdownMenuItem(
                        value: province["13"][0],
                        child: Text(
                          province["13"][1],
                          style: CustomStyle.getSubtitle(context),
                        ),
                      ),
                      DropdownMenuItem(
                        value: province["14"][0],
                        child: Text(
                          province["14"][1],
                          style: CustomStyle.getSubtitle(context),
                        ),
                      ),
                      DropdownMenuItem(
                        value: province["15"][0],
                        child: Text(
                          province["15"][1],
                          style: CustomStyle.getSubtitle(context),
                        ),
                      ),
                      DropdownMenuItem(
                        value: province["16"][0],
                        child: Text(
                          province["16"][1],
                          style: CustomStyle.getSubtitle(context),
                        ),
                      ),
                      DropdownMenuItem(
                        value: province["17"][0],
                        child: Text(
                          province["17"][1],
                          style: CustomStyle.getSubtitle(context),
                        ),
                      ),
                      DropdownMenuItem(
                        value: province["18"][0],
                        child: Text(
                          province["18"][1],
                          style: CustomStyle.getSubtitle(context),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    decoration: CustomStyle.box,
                    child: Column(
                      children: [
                        CheckboxListTile(
                          activeColor: LightPalette.button,
                          title: Text(
                            LocaleKeys.view_new_search_name_search.tr(),
                            style: CustomStyle.getSubtitle(context),
                          ),
                          value: _nameSelected,
                          onChanged: (val) => setState(() {
                            _nameSelected = !_nameSelected;
                            ProfileSearchData.nameSelected = _nameSelected;
                            if (_specialitySelected) {
                              _specialitySelected = !_specialitySelected;
                              ProfileSearchData.speciality = '';
                            }
                          }),
                        ),
                        CheckboxListTile(
                          activeColor: LightPalette.button,
                          title: Text(
                            LocaleKeys.view_new_search_speciality_search.tr(),
                            style: CustomStyle.getSubtitle(context),
                          ),
                          value: _specialitySelected,
                          onChanged: (val) => setState(() {
                            _specialitySelected = !_specialitySelected;
                            ProfileSearchData.specialitySelected = _specialitySelected;
                            if (_nameSelected) {
                              _nameSelected = !_nameSelected;
                              ProfileSearchData.name = '';
                            }
                          }),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.only(top: getDeviceType(context, 40, 40, 50, 50)),
              child: Container(
                height: getDeviceType(context, 50, 60, 70, 80),
                width: getDeviceType(context, 250, 300, 400, 500),
                child: Column(
                  children: [
                    _nameSelected
                        ? Container(
                            height: getDeviceType(context, 40, 50, 60, 70),
                            child: TextField(
                              onChanged: (val) {
                                setState(() => ProfileSearchData.name = val);
                              },
                              keyboardType: TextInputType.emailAddress,
                              decoration: CustomStyle.getInputDecoration(context).copyWith(
                                hintText: LocaleKeys.view_new_search_enter_name.tr(),
                                suffixIcon: Icon(
                                  Icons.search,
                                  color: Colors.deepOrange,
                                ),
                              ),
                            ),
                          )
                        : Container(),
                    _specialitySelected
                        ? CustomDropDownButton(
                            hint: LocaleKeys.view_doctor_speciality.tr(),
                            value: ProfileSearchData.speciality == '' ? null : ProfileSearchData.speciality,
                            onChanged: (val) => setState(() => ProfileSearchData.speciality = val),
                            items: [
                              DropdownMenuItem(
                                value: specialities['1'][1],
                                child: Text(
                                  specialities['1'][0],
                                  style: CustomStyle.getSubtitle(context),
                                ),
                              ),
                              DropdownMenuItem(
                                value: specialities["2"][1],
                                child: Text(
                                  specialities["2"][0],
                                  style: CustomStyle.getSubtitle(context),
                                ),
                              ),
                              DropdownMenuItem(
                                value: specialities["3"][1],
                                child: Text(
                                  specialities["3"][0],
                                  style: CustomStyle.getSubtitle(context),
                                ),
                              ),
                              DropdownMenuItem(
                                value: specialities["4"][1],
                                child: Text(specialities["4"][0], style: CustomStyle.getSubtitle(context)),
                              ),
                              DropdownMenuItem(
                                value: specialities["5"][1],
                                child: Text(specialities["5"][0], style: CustomStyle.getSubtitle(context)),
                              ), //5
                              DropdownMenuItem(
                                value: specialities["6"][1],
                                child: Text(specialities["6"][0], style: CustomStyle.getSubtitle(context)),
                              ),
                              DropdownMenuItem(
                                value: specialities["7"][1],
                                child: Text(specialities["7"][0], style: CustomStyle.getSubtitle(context)),
                              ),
                              DropdownMenuItem(
                                value: specialities["8"][1],
                                child: Text(specialities["8"][0], style: CustomStyle.getSubtitle(context)),
                              ),
                              DropdownMenuItem(
                                value: specialities["9"][1],
                                child: Text(specialities["9"][0], style: CustomStyle.getSubtitle(context)),
                              ),
                              DropdownMenuItem(
                                value: specialities["10"][1],
                                child: Text(specialities["10"][0], style: CustomStyle.getSubtitle(context)),
                              ), //10
                              DropdownMenuItem(
                                value: specialities["11"][1],
                                child: Text(specialities["11"][0], style: CustomStyle.getSubtitle(context)),
                              ),
                              DropdownMenuItem(
                                value: specialities["12"][1],
                                child: Text(specialities["12"][0], style: CustomStyle.getSubtitle(context)),
                              ),
                              DropdownMenuItem(
                                value: specialities["13"][1],
                                child: Text(specialities['13'][0], style: CustomStyle.getSubtitle(context)),
                              ),
                              DropdownMenuItem(
                                value: specialities["14"][1],
                                child: Text(specialities["14"][0], style: CustomStyle.getSubtitle(context)),
                              ),
                              DropdownMenuItem(
                                value: specialities["15"][1],
                                child: Text(specialities["15"][0], style: CustomStyle.getSubtitle(context)),
                              ), //15
                              DropdownMenuItem(
                                value: specialities["16"][1],
                                child: Text(specialities["16"][0], style: CustomStyle.getSubtitle(context)),
                              ),
                              DropdownMenuItem(
                                value: specialities["17"][1],
                                child: Text(specialities["17"][0], style: CustomStyle.getSubtitle(context)),
                              ),
                              DropdownMenuItem(
                                value: specialities["18"][1],
                                child: Text(specialities["18"][0], style: CustomStyle.getSubtitle(context)),
                              ),
                              DropdownMenuItem(
                                value: specialities["19"][1],
                                child: Text(specialities["19"][0], style: CustomStyle.getSubtitle(context)),
                              ),
                              DropdownMenuItem(
                                value: specialities["20"][1],
                                child: Text(specialities["20"][0], style: CustomStyle.getSubtitle(context)),
                              ), //20
                              DropdownMenuItem(
                                value: specialities["21"][1],
                                child: Text(specialities["21"][0], style: CustomStyle.getSubtitle(context)),
                              ),
                              DropdownMenuItem(
                                value: specialities["22"][1],
                                child: Text(specialities["22"][0], style: CustomStyle.getSubtitle(context)),
                              ),
                              DropdownMenuItem(
                                value: specialities["23"][1],
                                child: Text(specialities["23"][0], style: CustomStyle.getSubtitle(context)),
                              )
                            ],
                          )
                        : Container()
                  ],
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(bottom: getDeviceType(context, 50, 100, 150, 200)),
              child: CustomLoadingButton(
                  title: LocaleKeys.view_buttons_search.tr(),
                  controller: _controller,
                  onPressed: () async {
                    if (!await isInternet())
                      getFlushbar(context, LocaleKeys.error_snack_connectivity.tr(), _controller);
                    else {
                      if (ProfileSearchData.province == null)
                        getFlushbar(context, LocaleKeys.view_new_search_select_province.tr(), _controller);
                      else {
                        if (ProfileSearchData.name.isNotEmpty || ProfileSearchData.speciality.isNotEmpty) {
                          await getSuccess(_controller);
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => SearchListView()));
                        } else
                          getFlushbar(context, LocaleKeys.view_new_search_enter_name_speciality.tr(), _controller);
                      }
                    }
                  }),
            ),
          ),
        ],
      ),
    );
  }
}
