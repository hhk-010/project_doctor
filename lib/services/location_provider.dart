import 'package:flutter/material.dart';
import 'package:project_doctor/services/location_bloc.dart';
export 'package:project_doctor/services/location_bloc.dart';

class LocationProvider extends InheritedWidget {
  final LocationBloc bloc;

  LocationProvider({Key key, Widget child})
      : bloc = LocationBloc(),
        super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }

  static LocationBloc of(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType() as LocationProvider).bloc;
  }
}