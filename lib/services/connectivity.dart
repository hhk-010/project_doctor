import 'package:connectivity/connectivity.dart';
import 'package:data_connection_checker/data_connection_checker.dart';

Future<bool> isInternet() async {
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.mobile) {
    if (await DataConnectionChecker().hasConnection) {
      return Future<bool>.value(true);
    } else {
      return Future<bool>.value(false);
    }
  } else if (connectivityResult == ConnectivityResult.wifi) {
    if (await DataConnectionChecker().hasConnection) {
      return Future<bool>.value(true);
    } else {
      return Future<bool>.value(false);
    }
  } else {
    return Future<bool>.value(false);
  }
}

