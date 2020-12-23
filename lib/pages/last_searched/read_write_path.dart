import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class LastSearchedStorage {
  Future<String> get _localPath async {
    final dir = await getApplicationDocumentsDirectory();
    return dir.path;
  }

  Future<File> get _nameFile async {
    final path = await _localPath;
    return File('$path/last_searched_name.txt');
  }

  Future<File> get _specialityFile async {
    final path = await _localPath;
    return File('$path/last_searched_speciality.txt');
  }

  Future<File> get _numberFile async {
    final path = await _localPath;
    return File('$path/last_searched_number.txt');
  }

  Future<File> get _provinceFile async {
    final path = await _localPath;
    return File('$path/last_searched_province.txt');
  }

  Future<File> get _addressFile async {
    final path = await _localPath;
    return File('$path/last_searched_address.txt');
  }

//=============lat to list=============
  Future<File> get _lattFile async {
    final path = await _localPath;
    return File('$path/last_searched_latt.txt');
  }

  Future<File> get _lnggFile async {
    final path = await _localPath;
    return File('$path/last_searched_lngg.txt');
  }

  Future<File> get _work01File async {
    final path = await _localPath;
    return File('$path/last_searched_work01.txt');
  }

  Future<File> get _work02File async {
    final path = await _localPath;
    return File('$path/last_searched_work02.txt');
  }

  Future<File> get _work03File async {
    final path = await _localPath;
    return File('$path/last_searched_work03.txt');
  }

  //-----------read functions------------
  Future<String> readName() async {
    try {
      final file = await _nameFile;

      // Read the file.
      String name = await file.readAsString();

      return name;
    } catch (e) {
      // If encountering an error, return 0.
      return '';
    }
  }

  Future<String> readSpeciality() async {
    try {
      final file = await _specialityFile;

      // Read the file.
      String speciality = await file.readAsString();

      return speciality;
    } catch (e) {
      // If encountering an error, return 0.
      return '';
    }
  }

  Future<String> readNumber() async {
    try {
      final file = await _numberFile;

      // Read the file.
      String number = await file.readAsString();

      return number;
    } catch (e) {
      // If encountering an error, return 0.
      return '0';
    }
  }

  Future<String> readProvince() async {
    try {
      final file = await _provinceFile;

      // Read the file.
      String province = await file.readAsString();

      return province;
    } catch (e) {
      // If encountering an error, return 0.
      return '';
    }
  }

  Future<String> readAddress() async {
    try {
      final file = await _addressFile;

      // Read the file.
      String address = await file.readAsString();

      return address;
    } catch (e) {
      // If encountering an error, return 0.
      return '';
    }
  }

  //===========lat to list============
  Future<double> readLat() async {
    try {
      final file = await _lattFile;

      // Read the file.
      String latt = await file.readAsString();

      return double.parse(latt);
    } catch (e) {
      // If encountering an error, return 0.
      return 33.0;
    }
  }

  Future<double> readLng() async {
    try {
      final file = await _lnggFile;

      // Read the file.
      String _lngg = await file.readAsString();

      return double.parse(_lngg);
    } catch (e) {
      // If encountering an error, return 0.
      return 44.0;
    }
  }

  Future<List> workDays01reader() async {
    try {
      final file = await _work01File;

      // Read the file.
      String workdays01 = await file.readAsString();

      return json.decode(workdays01);
    } catch (e) {
      // If encountering an error, return 0.
      return ["sunday", "monday"];
    }
  }

  Future<List> readWorkDays02() async {
    try {
      final file = await _work02File;

      // Read the file.
      String workdays02 = await file.readAsString();

      return json.decode(workdays02);
    } catch (e) {
      // If encountering an error, return 0.
      return ["tuesday"];
    }
  }

  Future<List> readWorkDays03() async {
    try {
      final file = await _work03File;

      // Read the file.
      String workdays03 = await file.readAsString();

      return json.decode(workdays03);
    } catch (e) {
      // If encountering an error, return 0.
      return ["wednesday"];
    }
  }

  //------------writing the data----------
  Future<File> writeName(String name) async {
    final file = await _nameFile;

    // Write the file.
    return file.writeAsString(name);
  }

  Future<File> writeSpeciality(String speciality) async {
    final file = await _specialityFile;

    // Write the file.
    return file.writeAsString(speciality);
  }

  Future<File> writeNumber(String number) async {
    final file = await _numberFile;

    // Write the file.
    return file.writeAsString(number);
  }

  Future<File> writeProvince(String province) async {
    final file = await _provinceFile;

    // Write the file.
    return file.writeAsString(province);
  }

  Future<File> writeAddress(String address) async {
    final file = await _addressFile;

    // Write the file.
    return file.writeAsString(address);
  }

//===========lat to list===============
  Future<File> writeLat(String lat) async {
    final file = await _lattFile;

    // Write the file.
    return file.writeAsString(lat);
  }

  Future<File> writeLng(String lng) async {
    final file = await _lnggFile;

    // Write the file.
    return file.writeAsString(lng);
  }

  Future<File> writeWork01(String work01) async {
    final file = await _work01File;

    // Write the file.
    return file.writeAsString(work01);
  }

  Future<File> writeWork02(String work02) async {
    final file = await _work02File;

    // Write the file.
    return file.writeAsString(work02);
  }

  Future<File> writeWork03(String work03) async {
    final file = await _work03File;

    // Write the file.
    return file.writeAsString(work03);
  }

  ///-------------------------------------

}
