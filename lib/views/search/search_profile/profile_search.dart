import 'package:flutter/material.dart';
import 'package:project_doctor/constants/color_style_size.dart';
import 'package:project_doctor/custom_widges/custom_button.dart';
import 'package:project_doctor/custom_widges/custom_dropdownbutton.dart';
import 'package:project_doctor/custom_widges/custom_flushbar.dart';
import 'package:project_doctor/custom_widges/custom_scaffold.dart';
import 'package:project_doctor/generated/locale_keys.g.dart';
import 'package:project_doctor/services/connectivity.dart';
import 'package:project_doctor/services/data_model.dart';
import 'package:project_doctor/services/database.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:project_doctor/views/search/search_profile/search_list.dart';
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
    SelectedPage.complaintSelected = false;
    SelectedPage.favoriteSelected = false;
    SelectedPage.lastSearchSelected = false;
    SelectedPage.newSearchSelected = true;
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
      "1": [LocaleKeys.medical_specialty_Internist.tr(), 'Internist'],
      "2": [LocaleKeys.medical_specialty_Pediatrician.tr(), 'Pediatrician'],
      "3": [LocaleKeys.medical_specialty_Cardiologist.tr(), 'Cardiologist'],
      "4": [LocaleKeys.medical_specialty_Pulmonologist.tr(), 'Pulmonologist'],
      "5": [LocaleKeys.medical_specialty_Endocrinologist.tr(), 'Endocrinologist'],
      "6": [LocaleKeys.medical_specialty_Enterologist.tr(), 'Enterologist'],
      "7": [LocaleKeys.medical_specialty_Neurologist.tr(), 'Neurologist'],
      "8": [LocaleKeys.medical_specialty_Neurosurgeon.tr(), 'Neurosurgeon'],
      "9": [LocaleKeys.medical_specialty_Heamatologist.tr(), 'Heamatologist'],
      "10": [LocaleKeys.medical_specialty_Nephrologist.tr(), 'Nephrologist'],
      "11": [LocaleKeys.medical_specialty_Rheumatologist.tr(), 'Rheumatologist'],
      "12": [LocaleKeys.medical_specialty_Emergency_physician.tr(), 'Emergency physician'],
      "13": [LocaleKeys.medical_specialty_Dermatologist.tr(), 'Dermatologist'],
      "14": [LocaleKeys.medical_specialty_Psychiatrist.tr(), 'Psychiatrist'],
      "15": [LocaleKeys.medical_specialty_Gynecologist.tr(), 'Gynecologist'],
      "16": [LocaleKeys.medical_specialty_General_Surgeon.tr(), 'General Surgeon'],
      "17": [LocaleKeys.medical_specialty_Pediatric_Surgeon.tr(), 'Pediatric Surgeon'],
      "18": [LocaleKeys.medical_specialty_ThoracoVascular_Surgeon.tr(), 'ThoracoVascular Surgeon'],
      "19": [LocaleKeys.medical_specialty_Orthopaedic_Surgeon.tr(), 'Orthopaedic Surgeon'],
      "20": [LocaleKeys.medical_specialty_Urosurgeon.tr(), 'Urosurgeon'],
      "21": [LocaleKeys.medical_specialty_Plastic_Surgeon.tr(), 'Plastic Surgeon'],
      "22": [LocaleKeys.medical_specialty_Ophthalmologist.tr(), 'Ophthalmologist'],
      "23": [LocaleKeys.medical_specialty_Laryngologist.tr(), 'Laryngologist'],
    };
    return BaseScaffold(
      title: LocaleKeys.view_buttons_search.tr(),
      isAppbar: true,
      action: getAppActions(context),
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 50),
            child: Container(
              height: 300,
              width: 300,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    LocaleKeys.view_doctor_province.tr(),
                    style: CStyle.getTitleBlack(context),
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
                          style: CStyle.getSubtitle(context),
                        ),
                      ),
                      DropdownMenuItem(
                        value: province["2"][0],
                        child: Text(
                          province["2"][1],
                          style: CStyle.getSubtitle(context),
                        ),
                      ),
                      DropdownMenuItem(
                        value: province["3"][0],
                        child: Text(
                          province["3"][1],
                          style: CStyle.getSubtitle(context),
                        ),
                      ),
                      DropdownMenuItem(
                        value: province["4"][0],
                        child: Text(
                          province["4"][1],
                          style: CStyle.getSubtitle(context),
                        ),
                      ),
                      DropdownMenuItem(
                        value: province["5"][0],
                        child: Text(
                          province["5"][1],
                          style: CStyle.getSubtitle(context),
                        ),
                      ),
                      DropdownMenuItem(
                        value: province["6"][0],
                        child: Text(
                          province["6"][1],
                          style: CStyle.getSubtitle(context),
                        ),
                      ),
                      DropdownMenuItem(
                        value: province["7"][0],
                        child: Text(
                          province["7"][1],
                          style: CStyle.getSubtitle(context),
                        ),
                      ),
                      DropdownMenuItem(
                        value: province["8"][0],
                        child: Text(
                          province["8"][1],
                          style: CStyle.getSubtitle(context),
                        ),
                      ),
                      DropdownMenuItem(
                        value: province["9"][0],
                        child: Text(
                          province["9"][1],
                          style: CStyle.getSubtitle(context),
                        ),
                      ),
                      DropdownMenuItem(
                        value: province["10"][0],
                        child: Text(
                          province["10"][1],
                          style: CStyle.getSubtitle(context),
                        ),
                      ),
                      DropdownMenuItem(
                        value: province["11"][0],
                        child: Text(
                          province["11"][1],
                          style: CStyle.getSubtitle(context),
                        ),
                      ),
                      DropdownMenuItem(
                        value: province["12"][0],
                        child: Text(
                          province["12"][1],
                          style: CStyle.getSubtitle(context),
                        ),
                      ),
                      DropdownMenuItem(
                        value: province["13"][0],
                        child: Text(
                          province["13"][1],
                          style: CStyle.getSubtitle(context),
                        ),
                      ),
                      DropdownMenuItem(
                        value: province["14"][0],
                        child: Text(
                          province["14"][1],
                          style: CStyle.getSubtitle(context),
                        ),
                      ),
                      DropdownMenuItem(
                        value: province["15"][0],
                        child: Text(
                          province["15"][1],
                          style: CStyle.getSubtitle(context),
                        ),
                      ),
                      DropdownMenuItem(
                        value: province["16"][0],
                        child: Text(
                          province["16"][1],
                          style: CStyle.getSubtitle(context),
                        ),
                      ),
                      DropdownMenuItem(
                        value: province["17"][0],
                        child: Text(
                          province["17"][1],
                          style: CStyle.getSubtitle(context),
                        ),
                      ),
                      DropdownMenuItem(
                        value: province["18"][0],
                        child: Text(
                          province["18"][1],
                          style: CStyle.getSubtitle(context),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: getDeviceType(context, 42, 60, 63, 60),
                    decoration: CStyle.box,
                    child: CheckboxListTile(
                      activeColor: LightPalette.button,
                      title: Text(
                        LocaleKeys.view_new_search_name_search.tr(),
                        style: CStyle.getSubtitle(context),
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
                  ),
                  Container(
                    height: getDeviceType(context, 42, 60, 63, 60),
                    decoration: CStyle.box,
                    child: CheckboxListTile(
                      activeColor: LightPalette.button,
                      title: Text(
                        LocaleKeys.view_new_search_speciality_search.tr(),
                        style: CStyle.getSubtitle(context),
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
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.only(top: 250),
              child: Container(
                height: 200,
                width: 300,
                child: Column(
                  children: [
                    _nameSelected
                        ? TextField(
                            onChanged: (val) {
                              setState(() => ProfileSearchData.name = val);
                            },
                            keyboardType: TextInputType.emailAddress,
                            decoration: CStyle.getInputDecoration(context).copyWith(
                              hintText: LocaleKeys.view_new_search_enter_name.tr(),
                              suffixIcon: Icon(
                                Icons.search,
                                color: Colors.deepOrange,
                              ),
                            ),
                          )
                        : Container(),
                    _specialitySelected
                        ? CustomDropDownButton(
                            hint: LocaleKeys.view_doctor_speciality.tr(),
                            onChanged: (val) => setState(() => ProfileSearchData.speciality = val),
                            items: [
                              DropdownMenuItem(
                                value: specialities['1'][1],
                                child: Text(
                                  specialities['1'][0],
                                  style: CStyle.getSubtitle(context),
                                ),
                              ),
                              DropdownMenuItem(
                                value: specialities["2"][1],
                                child: Text(
                                  specialities["2"][0],
                                  style: CStyle.getSubtitle(context),
                                ),
                              ),
                              DropdownMenuItem(
                                value: specialities["3"][1],
                                child: Text(
                                  specialities["3"][0],
                                  style: CStyle.getSubtitle(context),
                                ),
                              ),
                              DropdownMenuItem(
                                value: specialities["4"][1],
                                child: Text(specialities["4"][0], style: CStyle.getSubtitle(context)),
                              ),
                              DropdownMenuItem(
                                value: specialities["5"][1],
                                child: Text(specialities["5"][0], style: CStyle.getSubtitle(context)),
                              ), //5
                              DropdownMenuItem(
                                value: specialities["6"][1],
                                child: Text(specialities["6"][0], style: CStyle.getSubtitle(context)),
                              ),
                              DropdownMenuItem(
                                value: specialities["7"][1],
                                child: Text(specialities["7"][0], style: CStyle.getSubtitle(context)),
                              ),
                              DropdownMenuItem(
                                value: specialities["8"][1],
                                child: Text(specialities["8"][0], style: CStyle.getSubtitle(context)),
                              ),
                              DropdownMenuItem(
                                value: specialities["9"][1],
                                child: Text(specialities["9"][0], style: CStyle.getSubtitle(context)),
                              ),
                              DropdownMenuItem(
                                value: specialities["10"][1],
                                child: Text(specialities["10"][0], style: CStyle.getSubtitle(context)),
                              ), //10
                              DropdownMenuItem(
                                value: specialities["11"][1],
                                child: Text(specialities["11"][0], style: CStyle.getSubtitle(context)),
                              ),
                              DropdownMenuItem(
                                value: specialities["12"][1],
                                child: Text(specialities["12"][0], style: CStyle.getSubtitle(context)),
                              ),
                              DropdownMenuItem(
                                value: specialities["13"][1],
                                child: Text(specialities['13'][0], style: CStyle.getSubtitle(context)),
                              ),
                              DropdownMenuItem(
                                value: specialities["14"][1],
                                child: Text(specialities["14"][0], style: CStyle.getSubtitle(context)),
                              ),
                              DropdownMenuItem(
                                value: specialities["15"][1],
                                child: Text(specialities["15"][0], style: CStyle.getSubtitle(context)),
                              ), //15
                              DropdownMenuItem(
                                value: specialities["16"][1],
                                child: Text(specialities["16"][0], style: CStyle.getSubtitle(context)),
                              ),
                              DropdownMenuItem(
                                value: specialities["17"][1],
                                child: Text(specialities["17"][0], style: CStyle.getSubtitle(context)),
                              ),
                              DropdownMenuItem(
                                value: specialities["18"][1],
                                child: Text(specialities["18"][0], style: CStyle.getSubtitle(context)),
                              ),
                              DropdownMenuItem(
                                value: specialities["19"][1],
                                child: Text(specialities["19"][0], style: CStyle.getSubtitle(context)),
                              ),
                              DropdownMenuItem(
                                value: specialities["20"][1],
                                child: Text(specialities["20"][0], style: CStyle.getSubtitle(context)),
                              ), //20
                              DropdownMenuItem(
                                value: specialities["21"][1],
                                child: Text(specialities["21"][0], style: CStyle.getSubtitle(context)),
                              ),
                              DropdownMenuItem(
                                value: specialities["22"][1],
                                child: Text(specialities["22"][0], style: CStyle.getSubtitle(context)),
                              ),
                              DropdownMenuItem(
                                value: specialities["23"][1],
                                child: Text(specialities["23"][0], style: CStyle.getSubtitle(context)),
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
              padding: const EdgeInsets.only(bottom: 100),
              child: CustomLoadingButton(
                title: LocaleKeys.view_buttons_search.tr(),
                controller: _controller,
                onPressed: () async {
                  if (!await isInternet())
                    getFlushbar(context, LocaleKeys.error_snack_connectivity.tr(), _controller);
                  else if (ProfileSearchData.province == null)
                    getFlushbar(context, LocaleKeys.view_new_search_select_province.tr(), _controller);
                  else if (!_nameSelected && !_specialitySelected)
                    getFlushbar(context, LocaleKeys.view_new_search_enter_name_speciality.tr(), _controller);
                  else
                    getSuccess(_controller);
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => SearchListView()));
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
