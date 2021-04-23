import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:project_doctor/constants/device_size.dart';
import 'package:project_doctor/services/app_localizations.dart';
import 'package:project_doctor/services/data_model.dart';
import 'package:project_doctor/services/database.dart';
import 'package:project_doctor/services/read_write_path.dart';
import 'package:provider/provider.dart';

class FavoriteListView extends StatefulWidget {
  final Storage storage = Storage();
  @override
  _FavoriteListViewState createState() => _FavoriteListViewState();
}

class _FavoriteListViewState extends State<FavoriteListView> {
  @override
  void initState() {
    super.initState();
    widget.storage
        .readFavorite01()
        .then((value) => setState(() => Favorite.favorite01 = value));
    widget.storage
        .readFavorite02()
        .then((value) => setState(() => Favorite.favorite02 = value));
    widget.storage
        .readFavorite03()
        .then((value) => setState(() => Favorite.favorite03 = value));
    widget.storage
        .readFavorite04()
        .then((value) => setState(() => Favorite.favorite04 = value));
    widget.storage
        .readFavorite05()
        .then((value) => setState(() => Favorite.favorite05 = value));
    widget.storage
        .readFavorite06()
        .then((value) => setState(() => Favorite.favorite06 = value));
    widget.storage
        .readFavorite07()
        .then((value) => setState(() => Favorite.favorite07 = value));
    widget.storage
        .readFavorite08()
        .then((value) => setState(() => Favorite.favorite08 = value));
    widget.storage
        .readFavorite09()
        .then((value) => setState(() => Favorite.favorite09 = value));
    widget.storage
        .readFavorite10()
        .then((value) => setState(() => Favorite.favorite10 = value));
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
          Favorite.favorite10,
        ]);
  }

  @override
  Widget build(BuildContext context) {
    return StreamProvider<QuerySnapshot>.value(
      value: DatabaseService().baghdadDoctorDataProfileStream,
      initialData: null,
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(
            getDeviceTypeI(context, 36, 56, 56, 56),
          ),
          child: AppBar(
            backgroundColor: Colors.deepOrange,
            title: Text(
              AppLocalizations.of(context).translate('preferred'),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: getDeviceTypeI(context, 16, 25, 35, 45),
              ),
            ),
            centerTitle: true,
            iconTheme: IconThemeData(
              color: Colors.white,
            ),
          ),
        ),
        body: Favorite01(),
      ),
    );
  }
}

class Favorite01 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final streamData = Provider.of<QuerySnapshot>(context);
    if (streamData != null) {
      Favorite.favoriteList01 = [];
      for (var doc in streamData.docs) {
        if (Favorite.favoriteIdlist.contains(doc.id.toString())) {
          Favorite.favoriteList01.add(FavoriteListData(
              id: doc.id,
              name: doc.data()['name'],
              speciality: doc.data()['speciality'],
              province: doc.data()['province'],
              phoneNumber: doc.data()['phoneNumber'],
              address: doc.data()['address'],
              workDays01: doc.data()['workDays01'],
              workDays02: doc.data()['workDays02'],
              workDays03: doc.data()['workDays03'],
              lat: doc.data()['lat'],
              lng: doc.data()['lng']));
        }
      }
    }
    return StreamProvider.value(
      value: DatabaseService().babilDoctorDataProfileStream,
      initialData: null,
      child: Favorite02(),
    );
  }
}

class Favorite02 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final streamData = Provider.of<QuerySnapshot>(context);
    if (streamData != null) {
      Favorite.favoriteList02 = [];
      for (var doc in streamData.docs) {
        if (Favorite.favoriteIdlist.contains(doc.id.toString())) {
          Favorite.favoriteList02.add(FavoriteListData(
              id: doc.id,
              name: doc.data()['name'],
              speciality: doc.data()['speciality'],
              province: doc.data()['province'],
              phoneNumber: doc.data()['phoneNumber'],
              address: doc.data()['address'],
              workDays01: doc.data()['workDays01'],
              workDays02: doc.data()['workDays02'],
              workDays03: doc.data()['workDays03'],
              lat: doc.data()['lat'],
              lng: doc.data()['lng']));
        }
      }
    }
    return StreamProvider.value(
      value: DatabaseService().basrahDoctorDataProfileStream,
      initialData: null,
      child: Favorite03(),
    );
  }
}

class Favorite03 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final streamData = Provider.of<QuerySnapshot>(context);
    if (streamData != null) {
      Favorite.favoriteList03 = [];
      for (var doc in streamData.docs) {
        if (Favorite.favoriteIdlist.contains(doc.id.toString())) {
          Favorite.favoriteList03.add(FavoriteListData(
              id: doc.id,
              name: doc.data()['name'],
              speciality: doc.data()['speciality'],
              province: doc.data()['province'],
              phoneNumber: doc.data()['phoneNumber'],
              address: doc.data()['address'],
              workDays01: doc.data()['workDays01'],
              workDays02: doc.data()['workDays02'],
              workDays03: doc.data()['workDays03'],
              lat: doc.data()['lat'],
              lng: doc.data()['lng']));
        }
      }
    }
    return StreamProvider.value(
      value: DatabaseService().erbilDoctorDataProfileStream,
      initialData: null,
      child: Favorite04(),
    );
  }
}

class Favorite04 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final streamData = Provider.of<QuerySnapshot>(context);
    if (streamData != null) {
      Favorite.favoriteList04 = [];
      for (var doc in streamData.docs) {
        if (Favorite.favoriteIdlist.contains(doc.id.toString())) {
          Favorite.favoriteList04.add(FavoriteListData(
              id: doc.id,
              name: doc.data()['name'],
              speciality: doc.data()['speciality'],
              province: doc.data()['province'],
              phoneNumber: doc.data()['phoneNumber'],
              address: doc.data()['address'],
              workDays01: doc.data()['workDays01'],
              workDays02: doc.data()['workDays02'],
              workDays03: doc.data()['workDays03'],
              lat: doc.data()['lat'],
              lng: doc.data()['lng']));
        }
      }
    }
    return StreamProvider.value(
      value: DatabaseService().sulaymaniahDoctorDataProfileStream,
      initialData: null,
      child: Favorite05(),
    );
  }
}

class Favorite05 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final streamData = Provider.of<QuerySnapshot>(context);
    if (streamData != null) {
      Favorite.favoriteList05 = [];
      for (var doc in streamData.docs) {
        if (Favorite.favoriteIdlist.contains(doc.id.toString())) {
          Favorite.favoriteList05.add(FavoriteListData(
              id: doc.id,
              name: doc.data()['name'],
              speciality: doc.data()['speciality'],
              province: doc.data()['province'],
              phoneNumber: doc.data()['phoneNumber'],
              address: doc.data()['address'],
              workDays01: doc.data()['workDays01'],
              workDays02: doc.data()['workDays02'],
              workDays03: doc.data()['workDays03'],
              lat: doc.data()['lat'],
              lng: doc.data()['lng']));
        }
      }
    }
    return StreamProvider.value(
      value: DatabaseService().duhokDoctorDataProfileStream,
      initialData: null,
      child: Favorite06(),
    );
  }
}

class Favorite06 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final streamData = Provider.of<QuerySnapshot>(context);
    if (streamData != null) {
      Favorite.favoriteList06 = [];
      for (var doc in streamData.docs) {
        if (Favorite.favoriteIdlist.contains(doc.id.toString())) {
          Favorite.favoriteList06.add(FavoriteListData(
              id: doc.id,
              name: doc.data()['name'],
              speciality: doc.data()['speciality'],
              province: doc.data()['province'],
              phoneNumber: doc.data()['phoneNumber'],
              address: doc.data()['address'],
              workDays01: doc.data()['workDays01'],
              workDays02: doc.data()['workDays02'],
              workDays03: doc.data()['workDays03'],
              lat: doc.data()['lat'],
              lng: doc.data()['lng']));
        }
      }
    }
    return StreamProvider.value(
      value: DatabaseService().kirkokDoctorDataProfileStream,
      initialData: null,
      child: Favorite07(),
    );
  }
}

class Favorite07 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final streamData = Provider.of<QuerySnapshot>(context);
    if (streamData != null) {
      Favorite.favoriteList07 = [];
      for (var doc in streamData.docs) {
        if (Favorite.favoriteIdlist.contains(doc.id.toString())) {
          Favorite.favoriteList07.add(FavoriteListData(
              id: doc.id,
              name: doc.data()['name'],
              speciality: doc.data()['speciality'],
              province: doc.data()['province'],
              phoneNumber: doc.data()['phoneNumber'],
              address: doc.data()['address'],
              workDays01: doc.data()['workDays01'],
              workDays02: doc.data()['workDays02'],
              workDays03: doc.data()['workDays03'],
              lat: doc.data()['lat'],
              lng: doc.data()['lng']));
        }
      }
    }
    return StreamProvider.value(
      value: DatabaseService().diyalaDoctorDataProfileStream,
      initialData: null,
      child: Favorite08(),
    );
  }
}

class Favorite08 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final streamData = Provider.of<QuerySnapshot>(context);
    if (streamData != null) {
      Favorite.favoriteList08 = [];
      for (var doc in streamData.docs) {
        if (Favorite.favoriteIdlist.contains(doc.id.toString())) {
          Favorite.favoriteList08.add(FavoriteListData(
              id: doc.id,
              name: doc.data()['name'],
              speciality: doc.data()['speciality'],
              province: doc.data()['province'],
              phoneNumber: doc.data()['phoneNumber'],
              address: doc.data()['address'],
              workDays01: doc.data()['workDays01'],
              workDays02: doc.data()['workDays02'],
              workDays03: doc.data()['workDays03'],
              lat: doc.data()['lat'],
              lng: doc.data()['lng']));
        }
      }
    }
    return StreamProvider.value(
      value: DatabaseService().saladinDoctorDataProfileStream,
      initialData: null,
      child: Favorite09(),
    );
  }
}

class Favorite09 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final streamData = Provider.of<QuerySnapshot>(context);
    if (streamData != null) {
      Favorite.favoriteList09 = [];
      for (var doc in streamData.docs) {
        if (Favorite.favoriteIdlist.contains(doc.id.toString())) {
          Favorite.favoriteList09.add(FavoriteListData(
              id: doc.id,
              name: doc.data()['name'],
              speciality: doc.data()['speciality'],
              province: doc.data()['province'],
              phoneNumber: doc.data()['phoneNumber'],
              address: doc.data()['address'],
              workDays01: doc.data()['workDays01'],
              workDays02: doc.data()['workDays02'],
              workDays03: doc.data()['workDays03'],
              lat: doc.data()['lat'],
              lng: doc.data()['lng']));
        }
      }
    }
    return StreamProvider.value(
      value: DatabaseService().ninevehDoctorDataProfileStream,
      initialData: null,
      child: Favorite10(),
    );
  }
}

class Favorite10 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final streamData = Provider.of<QuerySnapshot>(context);
    if (streamData != null) {
      Favorite.favoriteList10 = [];
      for (var doc in streamData.docs) {
        if (Favorite.favoriteIdlist.contains(doc.id.toString())) {
          Favorite.favoriteList10.add(FavoriteListData(
              id: doc.id,
              name: doc.data()['name'],
              speciality: doc.data()['speciality'],
              province: doc.data()['province'],
              phoneNumber: doc.data()['phoneNumber'],
              address: doc.data()['address'],
              workDays01: doc.data()['workDays01'],
              workDays02: doc.data()['workDays02'],
              workDays03: doc.data()['workDays03'],
              lat: doc.data()['lat'],
              lng: doc.data()['lng']));
        }
      }
    }
    return StreamProvider.value(
      value: DatabaseService().anbarDoctorDataProfileStream,
      initialData: null,
      child: Favorite11(),
    );
  }
}

class Favorite11 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final streamData = Provider.of<QuerySnapshot>(context);
    if (streamData != null) {
      Favorite.favoriteList11 = [];
      for (var doc in streamData.docs) {
        if (Favorite.favoriteIdlist.contains(doc.id.toString())) {
          Favorite.favoriteList11.add(FavoriteListData(
              id: doc.id,
              name: doc.data()['name'],
              speciality: doc.data()['speciality'],
              province: doc.data()['province'],
              phoneNumber: doc.data()['phoneNumber'],
              address: doc.data()['address'],
              workDays01: doc.data()['workDays01'],
              workDays02: doc.data()['workDays02'],
              workDays03: doc.data()['workDays03'],
              lat: doc.data()['lat'],
              lng: doc.data()['lng']));
        }
      }
    }

    return StreamProvider.value(
      value: DatabaseService().karbalaDoctorDataProfileStream,
      initialData: null,
      child: Favorite12(),
    );
  }
}

class Favorite12 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final streamData = Provider.of<QuerySnapshot>(context);
    if (streamData != null) {
      Favorite.favoriteList12 = [];
      for (var doc in streamData.docs) {
        if (Favorite.favoriteIdlist.contains(doc.id.toString())) {
          Favorite.favoriteList12.add(FavoriteListData(
              id: doc.id,
              name: doc.data()['name'],
              speciality: doc.data()['speciality'],
              province: doc.data()['province'],
              phoneNumber: doc.data()['phoneNumber'],
              address: doc.data()['address'],
              workDays01: doc.data()['workDays01'],
              workDays02: doc.data()['workDays02'],
              workDays03: doc.data()['workDays03'],
              lat: doc.data()['lat'],
              lng: doc.data()['lng']));
        }
      }
    }
    return StreamProvider.value(
      value: DatabaseService().wasitDoctorDataProfileStream,
      initialData: null,
      child: Favorite13(),
    );
  }
}

class Favorite13 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final streamData = Provider.of<QuerySnapshot>(context);
    Favorite.favoriteList13 = [];
    if (streamData != null) {
      for (var doc in streamData.docs) {
        if (Favorite.favoriteIdlist.contains(doc.id.toString())) {
          Favorite.favoriteList13.add(FavoriteListData(
              id: doc.id,
              name: doc.data()['name'],
              speciality: doc.data()['speciality'],
              province: doc.data()['province'],
              phoneNumber: doc.data()['phoneNumber'],
              address: doc.data()['address'],
              workDays01: doc.data()['workDays01'],
              workDays02: doc.data()['workDays02'],
              workDays03: doc.data()['workDays03'],
              lat: doc.data()['lat'],
              lng: doc.data()['lng']));
        }
      }
    }
    return StreamProvider.value(
      value: DatabaseService().najafDoctorDataProfileStream,
      initialData: null,
      child: Favorite14(),
    );
  }
}

class Favorite14 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final streamData = Provider.of<QuerySnapshot>(context);
    Favorite.favoriteList14 = [];
    if (streamData != null) {
      for (var doc in streamData.docs) {
        if (Favorite.favoriteIdlist.contains(doc.id.toString())) {
          Favorite.favoriteList14.add(FavoriteListData(
              id: doc.id,
              name: doc.data()['name'],
              speciality: doc.data()['speciality'],
              province: doc.data()['province'],
              phoneNumber: doc.data()['phoneNumber'],
              address: doc.data()['address'],
              workDays01: doc.data()['workDays01'],
              workDays02: doc.data()['workDays02'],
              workDays03: doc.data()['workDays03'],
              lat: doc.data()['lat'],
              lng: doc.data()['lng']));
        }
      }
    }
    return StreamProvider.value(
      value: DatabaseService().maysanDoctorDataProfileStream,
      initialData: null,
      child: Favorite15(),
    );
  }
}

class Favorite15 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final streamData = Provider.of<QuerySnapshot>(context);
    if (streamData != null) {
      Favorite.favoriteList15 = [];
      for (var doc in streamData.docs) {
        if (Favorite.favoriteIdlist.contains(doc.id.toString())) {
          Favorite.favoriteList15.add(FavoriteListData(
              id: doc.id,
              name: doc.data()['name'],
              speciality: doc.data()['speciality'],
              province: doc.data()['province'],
              phoneNumber: doc.data()['phoneNumber'],
              address: doc.data()['address'],
              workDays01: doc.data()['workDays01'],
              workDays02: doc.data()['workDays02'],
              workDays03: doc.data()['workDays03'],
              lat: doc.data()['lat'],
              lng: doc.data()['lng']));
        }
      }
    }
    return StreamProvider.value(
      value: DatabaseService().dhiqarDoctorDataProfileStream,
      initialData: null,
      child: Favorite16(),
    );
  }
}

class Favorite16 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final streamData = Provider.of<QuerySnapshot>(context);
    if (streamData != null) {
      Favorite.favoriteList16 = [];
      for (var doc in streamData.docs) {
        if (Favorite.favoriteIdlist.contains(doc.id.toString())) {
          Favorite.favoriteList16.add(FavoriteListData(
              id: doc.id,
              name: doc.data()['name'],
              speciality: doc.data()['speciality'],
              province: doc.data()['province'],
              phoneNumber: doc.data()['phoneNumber'],
              address: doc.data()['address'],
              workDays01: doc.data()['workDays01'],
              workDays02: doc.data()['workDays02'],
              workDays03: doc.data()['workDays03'],
              lat: doc.data()['lat'],
              lng: doc.data()['lng']));
        }
      }
    }
    return StreamProvider.value(
      value: DatabaseService().muthanaDoctorDataProfileStream,
      initialData: null,
      child: Favorite17(),
    );
  }
}

class Favorite17 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final streamData = Provider.of<QuerySnapshot>(context);
    Favorite.favoriteList17 = [];
    if (streamData != null) {
      for (var doc in streamData.docs) {
        if (Favorite.favoriteIdlist.contains(doc.id.toString())) {
          Favorite.favoriteList17.add(FavoriteListData(
              name: doc.data()['name'],
              speciality: doc.data()['speciality'],
              province: doc.data()['province'],
              phoneNumber: doc.data()['phoneNumber'],
              address: doc.data()['address'],
              workDays01: doc.data()['workDays01'],
              workDays02: doc.data()['workDays02'],
              workDays03: doc.data()['workDays03'],
              lat: doc.data()['lat'],
              lng: doc.data()['lng']));
        }
      }
    }
    return StreamProvider.value(
      value: DatabaseService().qadiseyahoctorDataProfileStream,
      initialData: null,
      child: FavoriteListTile(),
    );
  }
}

class FavoriteListTile extends StatefulWidget {
  @override
  _FavoriteListTileState createState() => _FavoriteListTileState();
}

class _FavoriteListTileState extends State<FavoriteListTile> {
  List finalList01 = [];
  List finalList02 = [];
  List finalList03 = [];
  @override
  void initState() {
    super.initState();
    setState(() {
      finalList01 = [
        Favorite.favoriteList01,
        Favorite.favoriteList02,
        Favorite.favoriteList03,
        Favorite.favoriteList04,
        Favorite.favoriteList05,
        Favorite.favoriteList06,
        Favorite.favoriteList07,
        Favorite.favoriteList08,
        Favorite.favoriteList09,
        Favorite.favoriteList10,
        Favorite.favoriteList11,
        Favorite.favoriteList12,
        Favorite.favoriteList13,
        Favorite.favoriteList14,
        Favorite.favoriteList15,
        Favorite.favoriteList16,
        Favorite.favoriteList17,
      ];
    });
    for (List list in finalList01) {
      for (var instance in list) {
        finalList02.add(instance);
      }
    }
    for (var instance in finalList02) {
      if (!finalList03.contains(instance)) {
        finalList03.add(instance);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final searchResultData = Provider.of<QuerySnapshot>(context);
    if (searchResultData != null) {
      Favorite.favoriteList18 = [];
      for (var doc in searchResultData.docs) {
        if (Favorite.favoriteIdlist.contains(doc.id.toString())) {
          Favorite.favoriteList18.add(
            FavoriteListData(
                id: doc.id,
                name: doc.data()['name'],
                province: doc.data()['province'],
                address: doc.data()['address'],
                speciality: doc.data()['speciality'],
                phoneNumber: doc.data()['phoneNumber'],
                lat: doc.data()['lat'],
                lng: doc.data()['lng'],
                workDays01: doc.data()['workDays01'],
                workDays02: doc.data()['workDays02'],
                workDays03: doc.data()['workDays03']),
          );
        }
      }
      for (var instance in finalList03) {
        Favorite.favoriteList18.add(instance);
      }
    }
    return ListView.builder(
      itemCount: searchResultData != null
          ? Favorite.favoriteList18.length != 0
              ? Favorite.favoriteList18.length > 10
                  ? 10
                  : Favorite.favoriteList18.length
              : 1
          : 1,
      itemBuilder: (context, index) {
        return FavoriteTile(
          favoriteList: searchResultData != null
              ? Favorite.favoriteList18.length != 0
                  ? Favorite.favoriteList18[index]
                  : FavoriteListData(
                      name: 'Estate', speciality: 'O', address: 'District')
              : FavoriteListData(
                  name: 'Estate', speciality: 'Offer', address: 'District'),
        );
      },
    );
  }
}

class FavoriteTile extends StatefulWidget {
  final Storage storage = Storage();
  final FavoriteListData favoriteList;
  FavoriteTile({this.favoriteList});
  //static bool isSelected = false;
  @override
  _FavoriteTileState createState() => _FavoriteTileState();
}

class _FavoriteTileState extends State<FavoriteTile> {
  String province = '';
  String district = '';
  String phoneNumber = '';
  String lat = '';
  String lng = '';

  /* Future<File> _writeLastEstate(value) {
    setState(() => estate = value);
    return widget.storage.writeLastEstate(estate);
  }

  Future<File> _writeLastOffer(value) {
    setState(() => offer = value);
    return widget.storage.writeLastOffer(offer);
  }

  Future<File> _writeLastArea(value) {
    setState(() => area = value);
    return widget.storage.writeLastArea(area);
  }

  Future<File> _writeLastLength(value) {
    setState(() => length = value);
    return widget.storage.writeLastLength(length);
  }

  Future<File> _writeLastWidth(value) {
    setState(() => width = value);
    return widget.storage.writeLastWidth(width);
  }

  Future<File> _writeLastProvince(value) {
    setState(() => province = value);
    return widget.storage.writeLastProvince(province);
  }

  Future<File> _writeLastDistrict(value) {
    setState(() => district = value);
    return widget.storage.writeLastDistrict(district);
  }

  Future<File> _writeLastPhoneNumber(value) {
    setState(() => phoneNumber = value);
    return widget.storage.writeLastPhoneNumber(phoneNumber);
  }

  Future<File> _writeLastLat(value) {
    setState(() => lat = value);
    return widget.storage.writeLastLat(lat);
  }

  Future<File> _writeLastLng(value) {
    setState(() => lng = value);
    return widget.storage.writeLastLng(lng);
  }

  Future<File> _writeLastRoom(value) {
    setState(() => room = value);
    return widget.storage.writeLastRoom(room);
  }

  Future<File> _writeLastFloor(value) {
    setState(() => floor = value);
    return widget.storage.writeLastFloor(floor);
  }

  Future<File> _writeLastApartment(value) {
    setState(() => apartment = value);
    return widget.storage.writeLastApartment(apartment);
  }

  Future<File> _writeLastDate(value) {
    setState(() => date = value);
    return widget.storage.writeLastDate(date);
  }

  Future<File> _writeLastPrice(value) {
    setState(() => price = value);
    return widget.storage.writeLastPrice(price);
  }

  Future<File> _writeLastUrls(value) {
    setState(() => urls = value);
    return widget.storage.writeLastUrls(urls);
  } */

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: getDeviceTypeI(context, 5, 10, 15, 20),
        vertical: getDeviceTypeI(context, 10, 20, 15, 20),
      ),
      child: widget.favoriteList.name == 'Estate'
          ? widget.favoriteList.speciality == 'O'
              ? Column(
                  children: [
                    SizedBox(
                      height: getDeviceTypeI(context, 20, 40, 60, 80),
                    ),
                    Center(
                      child: Text(
                        AppLocalizations.of(context).translate('empty list'),
                        style: TextStyle(
                          fontSize: getDeviceTypeI(context, 12, 15, 30, 30),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: getDeviceTypeI(context, 20, 40, 60, 80),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.pushNamed(context, '/favorite list');
                      },
                      icon: Icon(
                        Icons.replay_rounded,
                        color: Colors.black,
                      ),
                    )
                  ],
                )
              : Center(
                  child: SpinKitRing(
                    color: Colors.deepOrange,
                  ),
                )
          : Card(
              margin: EdgeInsets.fromLTRB(
                getDeviceTypeI(context, 1, 2, 8, 10),
                getDeviceTypeI(context, 1, 2, 8, 10),
                getDeviceTypeI(context, 1, 2, 8, 10),
                getDeviceTypeI(context, 1, 2, 8, 10),
              ),
              child: ListTile(
                leading: CircleAvatar(
                  radius: getDeviceTypeI(context, 20, 25, 30, 35),
                  backgroundColor: Colors.deepOrange,
                ),
                title: Text(
                  widget.favoriteList.name,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  AppLocalizations.of(context)
                      .translate(widget.favoriteList.speciality),
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                onTap: () {},
              ),
            ),
    );
  }
}
