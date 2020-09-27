// import 'dart:io';

//   bool _isInternet = true;
//   checkInternet() async {
//     try {
//       final response = await InternetAddress.lookup('example.com');
//       if (response.isNotEmpty && response[0].rawAddress.isNotEmpty) {
//         _isInternet = true; // internet
//         setState(() {});
//       }
//     } on SocketException catch (_) {
//       _isInternet = false; // no internet
//       setState(() {});
//     }
//   }

//   @override
//   void initState() {
//     checkInternet();
//     super.initState();
//   }
