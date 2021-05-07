import 'package:project_doctor/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';

class SignInData {
  static String email;
  static String password;
  static bool isPasswordVisible;
}

class RegisterData {
  static bool isPasswordVisible;
  static String email;
  static String password;
  static String name;
  static String gender;
  static String speciality;
  static String phoneNumber;
  static String province;
}

class ResetPasswordData {
  static String email;
}

class CuraData {
  static Map specialities = {
    "1": ["medical_specialty.Enterologist".tr(), 'Internist'],
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
  static Map province = {
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
}
