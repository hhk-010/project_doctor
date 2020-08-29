import 'package:geolocator/geolocator.dart';

void _getCurrentLocation() async {
  final Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
}

