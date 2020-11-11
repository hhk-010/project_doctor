import 'package:flutter/material.dart';
import 'package:project_doctor/constants/theme.dart';
import 'package:project_doctor/services/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:weekday_selector/weekday_selector.dart';
import 'dart:ui';
import 'doctor03_map.dart';
import 'package:intl/date_symbols.dart';

class ClinicForm extends StatefulWidget {
  final String email;
  final String password;
  final String name;
  final String speciality;
  final String phoneNumber;
  final String province;

  ClinicForm(
      {this.email,
      this.password,
      this.name,
      this.phoneNumber,
      this.speciality,
      this.province});

  @override
  _ClinicFormState createState() => _ClinicFormState(
      email: email,
      password: password,
      name: name,
      speciality: speciality,
      phoneNumber: phoneNumber,
      province: province);
}

final _formKey = GlobalKey<FormState>();
// const String apiKey = 'ApiKey';
String currentaddress = '';
String currentVacationDays = '';
List currentListVacationDays = [];
String currentworkinghours = '';

// print int as days for weekday selector widget
List<bool> workDays = List.filled(7, false);
List boolToStringDays(BuildContext context, List workDays) {
  return [
    workDays[0] ? AppLocalizations.of(context).translate('sunday') : null,
    workDays[1] ? AppLocalizations.of(context).translate('monday') : null,
    workDays[2] ? AppLocalizations.of(context).translate('tuesday') : null,
    workDays[3] ? AppLocalizations.of(context).translate('wednesday') : null,
    workDays[4] ? AppLocalizations.of(context).translate('thursday') : null,
    workDays[5] ? AppLocalizations.of(context).translate('friday') : null,
    workDays[6] ? AppLocalizations.of(context).translate('saturday') : null,
  ];
}

TextDirection getTextDirection(Locale locale) {
  const rtlLanguages = ['ar'];
  return rtlLanguages.contains(locale.languageCode)
      ? TextDirection.rtl
      : TextDirection.ltr;
}

class _ClinicFormState extends State<ClinicForm> {
  String email;
  String password;
  String name;
  String speciality;
  String phoneNumber;
  String province;
  // final _places = GoogleMapsPlaces(apiKey: apiKey);

  _ClinicFormState({
    this.email,
    this.password,
    this.name,
    this.speciality,
    this.phoneNumber,
    this.province,
  });

  @override
  Widget build(BuildContext context) {
    // final bloc = LocationProvider.of(context);
    final locale = Localizations.localeOf(context);
    final textDirection = getTextDirection(locale);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        title: FittedBox(
          fit: BoxFit.fitWidth,
          child: Text(
            AppLocalizations.of(context).translate('doctor_form'),
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 75, horizontal: 50),
        child: Form(
          key: _formKey,
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // _searchField(context, bloc),
                // _buildLocation(bloc),
                TextFormField(
                  validator: (val) => val.isEmpty
                      ? AppLocalizations.of(context)
                          .translate('address_validator')
                      : null,
                  onChanged: (val) => setState(() => currentaddress = val),
                  decoration: textInputdecoration.copyWith(
                      hintText: AppLocalizations.of(context)
                          .translate('detailed_address'),
                      labelText: AppLocalizations.of(context)
                          .translate('detailed_address')),
                ),
                Spacer(),
                Container(
                  decoration: boxDecorationDoctor,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppLocalizations.of(context).translate(
                            'work_days',
                          ),
                          textAlign: TextAlign.right,
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        WeekdaySelector(
                          onChanged: (int day) {
                            setState(() {
                              final index = day % 7;
                              workDays[index] = !workDays[index];
                              currentListVacationDays =
                                  boolToStringDays(context, workDays);
                              currentListVacationDays
                                  .removeWhere((value) => value == null);
                              currentVacationDays =
                                  currentListVacationDays.join(', ');
                              print(workDays);
                              print(currentVacationDays);
                            });
                          },
                          values: workDays,
                          firstDayOfWeek: DateTime.sunday,
                          shortWeekdays: [
                            AppLocalizations.of(context).translate('sun'),
                            AppLocalizations.of(context).translate('mon'),
                            AppLocalizations.of(context).translate('tue'),
                            AppLocalizations.of(context).translate('wed'),
                            AppLocalizations.of(context).translate('thu'),
                            AppLocalizations.of(context).translate('fri'),
                            AppLocalizations.of(context).translate('sat'),
                          ],
                          weekdays: [
                            AppLocalizations.of(context).translate('sunday'),
                            AppLocalizations.of(context).translate('monday'),
                            AppLocalizations.of(context).translate('tuesday'),
                            AppLocalizations.of(context)
                                .translate('wednesday'),
                            AppLocalizations.of(context)
                                .translate('thursday'),
                            AppLocalizations.of(context).translate('friday'),
                            AppLocalizations.of(context)
                                .translate('saturday'),
                          ],
                          textDirection: textDirection,
                          fillColor: Colors.white,
                          selectedFillColor: Colors.deepOrange,
                          selectedElevation: 0,
                          elevation: 5,
                          selectedShape: CircleBorder(
                            side: BorderSide(color: Colors.black, width: 1),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                Spacer(),
                TextFormField(
                  validator: (val) => val.isEmpty
                      ? AppLocalizations.of(context)
                          .translate('work_validator')
                      : null,
                  onChanged: (val) =>
                      setState(() => currentworkinghours = val),
                  decoration: textInputdecoration.copyWith(
                    hintText:
                        AppLocalizations.of(context).translate('work_hour'),
                    labelText:
                        AppLocalizations.of(context).translate('work_hour'),
                  ),
                ),
                Spacer(
                  flex: 6,
                ),
                Row(
                  children: [
                    Text(
                      AppLocalizations.of(context)
                          .translate('location_setup'),
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Icon(
                      Icons.arrow_downward,
                      size: 20,
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                ButtonTheme(
                  minWidth: double.infinity,
                  child: RaisedButton.icon(
                    color: Colors.deepOrange,
                    icon: Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(80.0)),
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        if (currentaddress != '' &&
                            currentVacationDays != '' &&
                            currentworkinghours != '') {
                          await Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => DocMap(
                                email: email,
                                password: password,
                                name: name,
                                speciality: speciality,
                                phone: phoneNumber,
                                province: province,
                                address: currentaddress,
                                vacation: currentVacationDays,
                                workinghours: currentworkinghours,
                              ),
                            ),
                          );
                        }
                      }
                    },
                    label: Text(
                      AppLocalizations.of(context).translate('google_map'),
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Widget _searchField(BuildContext context, LocationBloc bloc) {
  //   return LocationProvider(
  //     child: StreamBuilder(
  //       stream: bloc.locationString,
  //       builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
  //         var _controller = TextEditingController();
  //         _controller.text = snapshot.data;
  //         return TextField(
  //           controller: _controller,
  //           decoration: InputDecoration(hintText: "Search"),
  //           onTap: () async {
  //             Prediction p = await PlacesAutocomplete.show(
  //               context: context,
  //               apiKey: apiKey,
  //               mode: Mode.overlay,
  //               language: "en",
  //             );

  //             PlacesDetailsResponse response =
  //                 await _places.getDetailsByPlaceId(p.placeId);
  //             var location = response.result.geometry.location;
  //             var latLng = LatLng(location.lat, location.lng);
  //             bloc.changeLocationString(response.result.formattedAddress);
  //             bloc.changeLocationLatLng(latLng);
  //           },
  //         );
  //       },
  //     ),
  //   );
  // }

  // Widget _buildLocation(LocationBloc bloc) {
  //   return StreamBuilder(
  //     stream: bloc.locationLatLng,
  //     builder: (BuildContext context, AsyncSnapshot<LatLng> snapshot) {
  //       return Column(
  //         children: <Widget>[
  //           Row(
  //             children: <Widget>[
  //               Container(
  //                 width: 80,
  //                 child: Text('latitude: '),
  //               ),
  //               Text('${snapshot.hasData ? snapshot.data.latitude : ''}')
  //             ],
  //           ),
  //           Row(
  //             children: <Widget>[
  //               Container(
  //                 width: 80,
  //                 child: Text('longitude: '),
  //               ),
  //               Text('${snapshot.hasData ? snapshot.data.longitude : ''}')
  //             ],
  //           )
  //         ],
  //       );
  //     },
  //   );
  // }
}
