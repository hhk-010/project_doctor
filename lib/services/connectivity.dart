import 'dart:io';

Future<bool> checkConnection() async {
  final result = await InternetAddress.lookup('google.com');
  if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
    return true;
  } else {
    return false;
  }
}
