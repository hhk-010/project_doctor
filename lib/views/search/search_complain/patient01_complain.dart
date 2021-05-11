import 'dart:ui';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project_doctor/constants/color_style_size.dart';
import 'package:project_doctor/matching_algorithm/final_score.dart';
import 'package:project_doctor/generated/locale_keys.g.dart';
import 'package:project_doctor/services/data_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:project_doctor/views/search/search_complain/patient02_risk_factors.dart';

class PatientComplain extends StatefulWidget {
  @override
  _PatientComplainState createState() => _PatientComplainState();
}

class _PatientComplainState extends State<PatientComplain> {
  TextStyle _textStylePatient = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );

  final ageController = TextEditingController();
  String _age = '';
  String _error = '';
  //======finding decimal age====
  int decimalAge = 0;
  getage(String _age) {
    try {
      decimalAge = int.parse(_age);
      return decimalAge;
    } catch (e) {
      return null;
    }
  }

  //-------------snackbar for age==null---------
  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();
  bool state = false;

  // ----------------Conditional DropDownMenu ------------------
  String regionSelected01;
  String regionSelected02;
  String regionSelected03;
  String regionSelected04;
  String regionSelected05;
  String regionSelected06;
  String regionSelected07;
  String complainSelected01;
  String complainSelected02;
  String complainSelected03;
  String complainSelected04;
  String complainSelected05;
  String complainSelected06;
  String complainSelected07;
  List<DropdownMenuItem<String>> menuitems = [];
  bool disabledropdown01 = true;
  bool disabledropdown02 = true;
  bool disabledropdown03 = true;
  bool disabledropdown04 = true;
  bool disabledropdown05 = true;
  bool disabledropdown06 = true;
  bool disabledropdown07 = true;

  bool _visibile01 = false;
  bool _switch01 = false;
  bool _visibile02 = false;
  bool _switch02 = false;
  bool _visibile03 = false;
  bool _switch03 = false;
  bool _visibile04 = false;
  bool _switch04 = false;
  bool _visibile05 = false;
  bool _switch05 = false;
  bool _visibile06 = false;
  bool _switch06 = false;
  var regionSelected = TextEditingController();
  List radioGender = ["Male", "Female"];
  String radioSelect = '';

  @override
  void initState() {
    super.initState();
    SelectedPage.complaintSelected = true;
    SelectedPage.favoriteSelected = false;
    SelectedPage.lastSearchSelected = false;
    SelectedPage.newSearchSelected = false;
  }

  @override
  Widget build(BuildContext context) {
    //snackbar for
    var lang = Localizations.localeOf(context).languageCode;
    _showSnackBar() {
      final _snackBar = new SnackBar(
        content: Text(
          _error,
          style: TextStyle(fontSize: 15, fontFamily: lang == 'ar' ? 'noto_arabic' : 'Helvetica'),
        ),
        backgroundColor: Colors.deepOrange,
      );
      ScaffoldMessenger.of(context).showSnackBar(_snackBar);
    }

    final cardioRespiratory = {
      "9": [('cyanosis').tr(), 'cyanosis'],
      "11": [('wheeze').tr(), 'wheeze'],
      "5": [('chest pain').tr(), 'chest pain'],
      "7": [('sputum').tr(), 'sputum'],
      "1": [('hemoptysis').tr(), 'hemoptysis'],
      "4": [('palpitation').tr(), 'palpitation'],
      "6": [('cough').tr(), 'cough'],
      "8": [('dyspnea').tr(), 'dyspnea'],
      "2": [('orthopnea').tr(), 'orthopnea'],
      "3": [('PN dyspnea').tr(), 'PN dyspnea'],
      "10": [('other cardiac problems').tr(), 'other cardiac problems'],
      "12": [('other respiratory problems').tr(), 'other respiratory problems']
    };
    final gastroIntestinal = {
      "4": [('bloody diarrhea').tr(), 'bloody diarrhea'],
      "5": [('watery diarrhea').tr(), 'watery diarrhea'],
      "8": [('mucousy diarrhea').tr(), 'mucousy diarrhea'],
      "3": [('constipation').tr(), 'constipation'],
      "2": [('vomiting').tr(), 'vomiting'],
      "7": [('odynophagia').tr(), 'odynophagia'],
      "1": [('abdominal pain').tr(), 'abdominal pain'],
      "10": [('abdominal distension').tr(), 'abdominal distension'],
      "13": [('hematemesis').tr(), 'hematemesis'],
      "14": [('malena').tr(), 'malena'],
      "15": [('tenesmus').tr(), 'tenesmus'],
      "6": [('dysphagia').tr(), 'dysphagia'],
      "12": [('nausea').tr(), 'nausea'],
      "9": [('other git problems').tr(), 'other git problems'],
      "11": [('bleeding per rectum').tr(), 'bleeding per rectum'],
    };
    final peiranalAbdomen = {
      "2": [('perianal discharge').tr(), 'perianal discharge'],
      "1": [('perianal pain').tr(), 'perianal pain'],
      "5": [('abdominal wall swelling').tr(), 'abdominal wall swelling'],
      "4": [('perianal itching').tr(), 'perianal itching'],
      "3": [('anal incontinence').tr(), 'anal incontinence'],
    };
    final neurology = {
      "6": [('tremer').tr(), 'tremer'],
      "10": [('ataxia').tr(), 'ataxia'],
      "4": [('spasm').tr(), 'spasm'],
      "7": [('confusion').tr(), 'confusion'],
      "13": [('syncope').tr(), 'syncope'],
      "3": [('abnormal movement').tr(), 'abnormal movement'],
      "8": [('numbness').tr(), 'numbness'],
      "9": [('slurred speech').tr(), 'slurred speech'],
      "11": [('weakness').tr(), 'weakness'],
      "1": [('coma').tr(), 'coma'],
      "5": [('memory loss').tr(), 'memory loss'],
      "12": [('other neurological problems').tr(), 'other neurological problems'],
      "2": [('fit').tr(), 'fit'],
    };

    final psychology = {
      "11": [('psychological trauma').tr(), 'psychological trauma'],
      "2": [('behavioral impairement').tr(), 'behavioral impairement'],
      "3": [('depression').tr(), 'depression'],
      "12": [('addiction').tr(), 'addiction'],
      "5": [('phobia').tr(), 'phobia'],
      "10": [('stress').tr(), 'stress'],
      "7": [('obsession').tr(), 'obsession'],
      "4": [('hallucination/delusion').tr(), 'hallucination/delusion'],
      "1": [('cognitive impairment').tr(), 'cognitive impairment'],
      "9": [('hyperactivity').tr(), 'hyperactivity'],
      "6": [('suicide').tr(), 'suicide'],
      "14": [('other psychological problems').tr(), 'other psychological problems'],
      "8": [('attention deficit').tr(), 'attention deficit'],
    };
    final musckuloskeletal = {
      "7": [('limb pain').tr(), 'limb pain'],
      "1": [('generalized bone pain').tr(), 'generalized bone pain'],
      "2": [('joint pain').tr(), 'joint pain'],
      "3": [('deformity').tr(), 'deformity'],
      "4": [('joint swelling').tr(), 'joint swelling'],
      "5": [('limitation of movement').tr(), 'limitation of movement'],
      "8": [('dislocation').tr(), 'dislocation'],
      "6": [('fracture').tr(), 'fracture'],
      "9": [("other msk problems").tr(), "other msk problems"],
    };
    final headNeckBack = {
      "8": [('headache').tr(), 'headache'],
      "2": [('neck pain').tr(), 'neck pain'],
      "7": [('back pain').tr(), 'back pain'],
      "1": [('jaw pain').tr(), 'jaw pain'],
      "3": [('enlarged jaw').tr(), 'enlarged jaw'],
      "4": [('neck swelling').tr(), 'neck swelling'],
      "6": [('back mass').tr(), 'back mass'],
      "10": [('abnormal head shape').tr(), 'abnormal head shape'],
      "5": [('back opening').tr(), 'back opening'],
      "11": [('other skull problems').tr(), 'other skull problems'],
      "9": [('large head').tr(), 'large head'],
    };
    final upperLimb = {
      "9": [('limb pain').tr(), 'limb pain'],
      "1": [('left arm pain').tr(), 'left arm pain'],
      "2": [('left shoulder pain').tr(), 'left shoulder pain'],
      "4": [('joint pain').tr(), 'joint pain'],
      "5": [('deformity').tr(), 'deformity'],
      "6": [('joint swelling').tr(), 'joint swelling'],
      "7": [('limitation of movement').tr(), 'limitation of movement'],
      "10": [('dislocation').tr(), 'dislocation'],
      "8": [('fracture').tr(), 'fracture'],
    };

    final hand = {
      "3": [('joined digit').tr(), 'joined digit'],
      "10": [('joint pain').tr(), 'joint pain'],
      "8": [('hand lump').tr(), 'hand lump'],
      "5": [('hand deformity').tr(), 'hand deformity'],
      "1": [('enlarged hand').tr(), 'enlarged hand'],
      "11": [('joint swelling').tr(), 'joint swelling'],
      "7": [('hand swelling').tr(), 'hand swelling'],
      "13": [('dislocation').tr(), 'dislocation'],
      "2": [('extra digit').tr(), 'extra digit'],
      "4": [('loss digit').tr(), 'loss digit'],
      "12": [('fracture').tr(), 'fracture'],
      "6": [('other hand problems').tr(), 'other hand problems'],
    };
    final lowerLimb = {
      "13": [('limb pain').tr(), 'limb pain'],
      "10": [('leg pain during walking').tr(), 'leg pain during walking'],
      "6": [('unilateral leg pain').tr(), 'unilateral leg pain'],
      "4": [('joint pain').tr(), 'joint pain'],
      "7": [('deformity').tr(), 'deformity'],
      "2": [('enlarged foot').tr(), 'enlarged foot'],
      "11": [('foot ulcer').tr(), 'foot ulcer'],
      "5": [('unilateral leg swelling').tr(), 'unilateral leg swelling'],
      "8": [('joint swelling').tr(), 'joint swelling'],
      "1": [('bilateral leg edema').tr(), 'bilateral leg edema'],
      "9": [('limitation of movement').tr(), 'limitation of movement'],
      "14": [('dislocation').tr(), 'dislocation'],
      "12": [('fracture').tr(), 'fracture'],
    };

    final others = {
      "5": [('insomnia').tr(), 'insomnia'],
      "11": [('fatigue').tr(), 'fatigue'],
      "1": [('sweating').tr(), 'sweating'],
      "2": [('fever').tr(), 'fever'],
      "7": [('somnolence').tr(), 'somnolence'],
      "12": [('pallor').tr(), 'pallor'],
      "6": [('cold sensation').tr(), 'cold sensation'],
      "3": [('heat sensation').tr(), 'heat sensation'],
      "8": [('polydipsia').tr(), 'polydipsia'],
      "15": [('malaise').tr(), 'malaise'],
      "10": [('bleeding').tr(), 'bleeding'],
      "9": [('delayed puberty').tr(), 'delayed puberty'],
      "4": [('ulcer').tr(), 'ulcer'],
      "13": [('lump').tr(), 'lump'],
      "17": [('taste loss').tr(), 'taste loss'],
      "16": [('short stature').tr(), 'short stature'],
      "14": [('other health problems').tr(), 'other health problems'],
    };

    final injuriesSuicideIntoxicationBurn = {
      "9": [('msk injury').tr(), 'msk injury'],
      "10": [('sport injury').tr(), 'sport injury'],
      "7": [('intoxication').tr(), 'intoxication'],
      "8": [('burn').tr(), 'burn'],
      "1": [('FFH').tr(), 'FFH'],
      "2": [('RTA').tr(), 'RTA'],
      "3": [('stab').tr(), 'stab'],
      "4": [('shot').tr(), 'shot'],
      "6": [('suicide').tr(), 'suicide'],
      "5": [('other injuries').tr(), 'other injuries'],
    };

    final mouth = {
      "1": [('mouth deviation').tr(), 'mouth deviation'],
      "2": [('cleft lip').tr(), 'cleft lip'],
      "3": [('cleft palate').tr(), 'cleft palate'],
      "4": [('disease of the mouth').tr(), 'disease of the mouth'],
    };
    final appetite = {
      "2": [('weight gain').tr(), 'weight gain'],
      "1": [('polyphagia').tr(), 'polyphagia'],
      "3": [('weight loss').tr(), 'weight loss'],
      "4": [('anorexia').tr(), 'anorexia'],
    };

    final entThroat = {
      "1": [('hoarseness').tr(), 'hoarseness'],
      "2": [('sore throat').tr(), 'sore throat'],
      "3": [('other ent problems').tr(), 'other ent problems'],
    };
    final entNose = {
      "1": [('nasal discharge').tr(), 'nasal discharge'],
      "7": [('sneezing').tr(), 'sneezing'],
      "3": [('nasal obstruction').tr(), 'nasal obstruction'],
      "4": [('nasal pain').tr(), 'nasal pain'],
      "6": [('nasal deformity').tr(), 'nasal deformity'],
      "10": [('enlarged nose').tr(), 'enlarged nose'],
      "8": [('nasal itching').tr(), 'nasal itching'],
      "5": [('nasal mass').tr(), 'nasal mass'],
      "9": [('anosmia').tr(), 'anosmia'],
      "2": [('nasal bleeding'), 'nasal bleeding'],
      "11": [('other ent problems').tr(), 'other ent problems'],
    };

    final entEar = {
      "5": [('ear redness').tr(), 'ear redness'],
      "2": [('vertigo').tr(), 'vertigo'],
      "1": [('deafness').tr(), 'deafness'],
      "3": [('tinnitus').tr(), 'tinnitus'],
      "6": [('ear pain').tr(), 'ear pain'],
      "4": [('ear discharge').tr(), 'ear discharge'],
      "7": [('other ent problems').tr(), 'other ent problems'],
    };

    final dermatology = {
      "5": [('skin redness').tr(), 'skin redness'],
      "4": [('hair problems').tr(), 'hair problems'],
      "10": [('bruising').tr(), 'bruising'],
      "13": [('skin pigmentation').tr(), "skin pigmentation"],
      "1": [('dry skin').tr(), 'dry skin'],
      "2": [('dry hair').tr(), 'dry hair'],
      "9": [('acne').tr(), 'acne'],
      "8": [('skin itching').tr(), 'skin itching'],
      "7": [('skin appendage').tr(), 'skin appendage'],
      "3": [('skin rash').tr(), 'skin rash'],
      "6": [('skin lesion').tr(), 'skin lesion'],
      "11": [('female hirsutism').tr(), 'female hirsutism'],
      "12": [("other dermatological problems").tr(), 'other dermatological problems'],
    };

    final gynecology = {
      "10": [('miscarriage').tr(), 'miscarriage'],
      "1": [('amenorrhea').tr(), 'amenorrhea'],
      "2": [('oligomenorrhea').tr(), 'oligomenorrhea'],
      "4": [('menorrhagia').tr(), 'menorrhagia'],
      "5": [('female infertility').tr(), 'female infertility'],
      "22": [('delayed puberty').tr(), 'delayed puberty'],
      "6": [('female hirsutism').tr(), 'female hirsutism'],
      "7": [('prolong pregnancy').tr(), 'prolong pregnancy'],
      "8": [('postmenopausal bleeding').tr(), 'postmenopausal bleeding'],
      "9": [('other gynecological and obstetrical problems').tr(), 'other gynecological and obstetrical problems'],
    };

    final uroKidney = {
      "7": [('retention').tr(), 'retention'],
      "10": [('hematuria').tr(), 'hematuria'],
      "8": [('urgency').tr(), 'urgency'],
      "12": [('nocturia').tr(), 'nocturia'],
      "9": [('dysuria').tr(), 'dysuria'],
      "4": [('suprapubic pain').tr(), 'suprapubic pain'],
      "6": [('flank pain').tr(), 'flank pain'],
      "1": [('incontinence').tr(), 'incontinence'],
      "5": [('frequency').tr(), 'frequency'],
      "2": [('polyuria').tr(), 'polyuria'],
      "11": [('other urological problems').tr(), 'other urological problems'],
    };

    final maleGenital = {
      "10": [('priapism').tr(), 'priapism'],
      "3": [('male infertility').tr(), 'male infertility'],
      "9": [('scrotal pain').tr(), 'scrotal pain'],
      "4": [('scrotal swelling').tr(), 'scrotal swelling'],
      "2": [('delayed puberty').tr(), 'delayed puberty'],
      "7": [('penile mass').tr(), 'penile mass'],
      "23": [('impotence').tr(), 'impotence'],
      "11": [('hematospermia').tr(), 'hematospermia'],
      "8": [('other penile problems').tr(), 'other penile problems'],
    };

    final ophthalmology = {
      "8": [('eye redness').tr(), 'eye redness'],
      "12": [('eye pigmentation').tr(), 'eye pigmentation'],
      "22": [("jaundice").tr(), "jaundice"],
      "7": [('squint').tr(), 'squint'],
      "3": [('photophobia').tr(), 'photophobia'],
      "4": [('double vision').tr(), 'double vision'],
      "2": [('blindness').tr(), 'blindness'],
      "9": [('eye pain').tr(), 'eye pain'],
      "6": [('blurred vision').tr(), 'blurred vision'],
      "14": [('eyelid deformity').tr(), 'eyelid deformity'],
      "13": [('periorbital edema').tr(), 'periorbital edema'],
      "15": [('dry eye').tr(), 'dry eye'],
      "10": [('eye discharge').tr(), 'eye discharge'],
      "16": [('ophthalmoplegia').tr(), 'ophthalmoplegia'],
      "1": [('open eye').tr(), 'open eye'],
      "5": [('lid drop').tr(), 'lid drop'],
      "17": [('other ophthalmological problems').tr(), 'other ophthalmological problems'],
    };
    final breast = {
      "28": [('galactorrhea').tr(), 'galactorrhea'],
      "19": [('gynecomastia').tr(), 'gynecomastia'],
      "46": [('breast pain').tr(), 'breast pain'],
      "55": [('breast discharge').tr(), 'breast discharge'],
      "37": [('breast mass').tr(), 'breast mass'],
      "73": [('breast skin lesion').tr(), 'breast skin lesion'],
      "82": [('other breast problems').tr(), 'other breast problems'],
    };

    void populateCardioRespiratory() {
      for (String key in cardioRespiratory.keys) {
        menuitems.add(DropdownMenuItem<String>(
          child: Text(cardioRespiratory[key][0]),
          value: cardioRespiratory[key][1],
        ));
      }
    }

    void populateGastroIntestinal() {
      for (String key in gastroIntestinal.keys) {
        menuitems.add(DropdownMenuItem<String>(
          child: Text(gastroIntestinal[key][0]),
          value: gastroIntestinal[key][1],
        ));
      }
    }

    void populatePeiranalAbdomen() {
      for (String key in peiranalAbdomen.keys) {
        menuitems.add(DropdownMenuItem<String>(
          child: Text(peiranalAbdomen[key][0]),
          value: peiranalAbdomen[key][1],
        ));
      }
    }

    void populateNeurology() {
      for (String key in neurology.keys) {
        menuitems.add(DropdownMenuItem<String>(
          child: Text(neurology[key][0]),
          value: neurology[key][1],
        ));
      }
    }

    void populatePsychology() {
      for (String key in psychology.keys) {
        menuitems.add(DropdownMenuItem<String>(
          child: Text(psychology[key][0]),
          value: psychology[key][1],
        ));
      }
    }

    void populateMusckuloskeletal() {
      for (String key in musckuloskeletal.keys) {
        menuitems.add(DropdownMenuItem<String>(
          child: Text(musckuloskeletal[key][0]),
          value: musckuloskeletal[key][1],
        ));
      }
    }

    void populateHeadNeckBack() {
      for (String key in headNeckBack.keys) {
        menuitems.add(DropdownMenuItem<String>(
          child: Text(headNeckBack[key][0]),
          value: headNeckBack[key][1],
        ));
      }
    }

    void populateUpperLimb() {
      for (String key in upperLimb.keys) {
        menuitems.add(DropdownMenuItem<String>(
          child: Text(upperLimb[key][0]),
          value: upperLimb[key][1],
        ));
      }
    }

    void populateHand() {
      for (String key in hand.keys) {
        menuitems.add(DropdownMenuItem<String>(
          child: Text(hand[key][0]),
          value: hand[key][1],
        ));
      }
    }

    void populateLowerLimb() {
      for (String key in lowerLimb.keys) {
        menuitems.add(DropdownMenuItem<String>(
          child: Text(lowerLimb[key][0]),
          value: lowerLimb[key][1],
        ));
      }
    }

    void populateOthers() {
      for (String key in others.keys) {
        menuitems.add(DropdownMenuItem<String>(
          child: Text(others[key][0]),
          value: others[key][1],
        ));
      }
    }

    void populateInjuriesSuicideIntoxicationBurn() {
      for (String key in injuriesSuicideIntoxicationBurn.keys) {
        menuitems.add(DropdownMenuItem<String>(
          child: Text(injuriesSuicideIntoxicationBurn[key][0]),
          value: injuriesSuicideIntoxicationBurn[key][1],
        ));
      }
    }

    void populateMouth() {
      for (String key in mouth.keys) {
        menuitems.add(DropdownMenuItem<String>(
          child: Text(mouth[key][0]),
          value: mouth[key][1],
        ));
      }
    }

    void populateAppetite() {
      for (String key in appetite.keys) {
        menuitems.add(DropdownMenuItem<String>(
          child: Text(appetite[key][0]),
          value: appetite[key][1],
        ));
      }
    }

    void populateEntThroat() {
      for (String key in entThroat.keys) {
        menuitems.add(DropdownMenuItem<String>(
          child: Text(entThroat[key][0]),
          value: entThroat[key][1],
        ));
      }
    }

    void populateEntNose() {
      for (String key in entNose.keys) {
        menuitems.add(DropdownMenuItem<String>(
          child: Text(entNose[key][0]),
          value: entNose[key][1],
        ));
      }
    }

    void populateEntEar() {
      for (String key in entEar.keys) {
        menuitems.add(DropdownMenuItem<String>(
          child: Text(entEar[key][0]),
          value: entEar[key][1],
        ));
      }
    }

    void populateDermatology() {
      for (String key in dermatology.keys) {
        menuitems.add(DropdownMenuItem<String>(
          child: Text(dermatology[key][0]),
          value: dermatology[key][1],
        ));
      }
    }

    void populateGynecology() {
      for (String key in gynecology.keys) {
        menuitems.add(DropdownMenuItem<String>(
          child: Text(gynecology[key][0]),
          value: gynecology[key][1],
        ));
      }
    }

    void populatEuroKidney() {
      for (String key in uroKidney.keys) {
        menuitems.add(DropdownMenuItem<String>(
          child: Text(uroKidney[key][0]),
          value: uroKidney[key][1],
        ));
      }
    }

    void populatMaleGenital() {
      for (String key in maleGenital.keys) {
        menuitems.add(DropdownMenuItem<String>(
          child: Text(maleGenital[key][0]),
          value: maleGenital[key][1],
        ));
      }
    }

    void populatOphthalmology() {
      for (String key in ophthalmology.keys) {
        menuitems.add(DropdownMenuItem<String>(
          child: Text(ophthalmology[key][0]),
          value: ophthalmology[key][1],
        ));
      }
    }

    void populatBreast() {
      for (String key in breast.keys) {
        menuitems.add(DropdownMenuItem<String>(
          child: Text(breast[key][0]),
          value: breast[key][1],
        ));
      }
    }

    void selected01(_value) {
      if (_value == "cardioRespiratory") {
        menuitems = [];
        populateCardioRespiratory();
      } else if (_value == "gastroIntestinal") {
        menuitems = [];
        populateGastroIntestinal();
      } else if (_value == "peiranalAbdomen") {
        menuitems = [];
        populatePeiranalAbdomen();
      } else if (_value == 'neurology') {
        menuitems = [];
        populateNeurology();
      } else if (_value == 'psychology') {
        menuitems = [];
        populatePsychology();
      } else if (_value == 'musckuloskeletal') {
        menuitems = [];
        populateMusckuloskeletal();
      } else if (_value == 'headNeckBack') {
        menuitems = [];
        populateHeadNeckBack();
      } else if (_value == 'upperLimb') {
        menuitems = [];
        populateUpperLimb();
      } else if (_value == 'hand') {
        menuitems = [];
        populateHand();
      } else if (_value == 'lowerLimb') {
        menuitems = [];
        populateLowerLimb();
      } else if (_value == 'others') {
        menuitems = [];
        populateOthers();
      } else if (_value == 'bpPrLab') {
        menuitems = [];
        //populateBpPrLab();
      } else if (_value == 'injuriesSuicideIntoxicationBurn') {
        menuitems = [];
        populateInjuriesSuicideIntoxicationBurn();
      } else if (_value == 'mouth') {
        menuitems = [];
        populateMouth();
      } else if (_value == 'appetite') {
        menuitems = [];
        populateAppetite();
      } else if (_value == 'entThroat') {
        menuitems = [];
        populateEntThroat();
      } else if (_value == 'entNose') {
        menuitems = [];
        populateEntNose();
      } else if (_value == 'entEar') {
        menuitems = [];
        populateEntEar();
      } else if (_value == 'dermatology') {
        menuitems = [];
        populateDermatology();
      } else if (_value == 'gynecology') {
        menuitems = [];
        populateGynecology();
      } else if (_value == 'uroKidney') {
        menuitems = [];
        populatEuroKidney();
      } else if (_value == 'maleGenital') {
        menuitems = [];
        populatMaleGenital();
      } else if (_value == 'ophthalmology') {
        menuitems = [];
        populatOphthalmology();
      } else if (_value == 'breast') {
        menuitems = [];
        populatBreast();
      }
      setState(() {
        regionSelected01 = _value;
        disabledropdown01 = false;
      });
    }

    void selected02(_value) {
      if (_value == "cardioRespiratory") {
        menuitems = [];
        populateCardioRespiratory();
      } else if (_value == "gastroIntestinal") {
        menuitems = [];
        populateGastroIntestinal();
      } else if (_value == "peiranalAbdomen") {
        menuitems = [];
        populatePeiranalAbdomen();
      } else if (_value == 'neurology') {
        menuitems = [];
        populateNeurology();
      } else if (_value == 'psychology') {
        menuitems = [];
        populatePsychology();
      } else if (_value == 'musckuloskeletal') {
        menuitems = [];
        populateMusckuloskeletal();
      } else if (_value == 'headNeckBack') {
        menuitems = [];
        populateHeadNeckBack();
      } else if (_value == 'upperLimb') {
        menuitems = [];
        populateUpperLimb();
      } else if (_value == 'hand') {
        menuitems = [];
        populateHand();
      } else if (_value == 'lowerLimb') {
        menuitems = [];
        populateLowerLimb();
      } else if (_value == 'others') {
        menuitems = [];
        populateOthers();
      } else if (_value == 'bpPrLab') {
        menuitems = [];
        // populateBpPrLab();
      } else if (_value == 'injuriesSuicideIntoxicationBurn') {
        menuitems = [];
        populateInjuriesSuicideIntoxicationBurn();
      } else if (_value == 'mouth') {
        menuitems = [];
        populateMouth();
      } else if (_value == 'appetite') {
        menuitems = [];
        populateAppetite();
      } else if (_value == 'entThroat') {
        menuitems = [];
        populateEntThroat();
      } else if (_value == 'entNose') {
        menuitems = [];
        populateEntNose();
      } else if (_value == 'entEar') {
        menuitems = [];
        populateEntEar();
      } else if (_value == 'dermatology') {
        menuitems = [];
        populateDermatology();
      } else if (_value == 'gynecology') {
        menuitems = [];
        populateGynecology();
      } else if (_value == 'uroKidney') {
        menuitems = [];
        populatEuroKidney();
      } else if (_value == 'maleGenital') {
        menuitems = [];
        populatMaleGenital();
      } else if (_value == 'ophthalmology') {
        menuitems = [];
        populatOphthalmology();
      } else if (_value == 'breast') {
        menuitems = [];
        populatBreast();
      }
      setState(() {
        regionSelected02 = _value;

        disabledropdown02 = false;
      });
    }

    void selected03(_value) {
      if (_value == "cardioRespiratory") {
        menuitems = [];
        populateCardioRespiratory();
      } else if (_value == "gastroIntestinal") {
        menuitems = [];
        populateGastroIntestinal();
      } else if (_value == "peiranalAbdomen") {
        menuitems = [];
        populatePeiranalAbdomen();
      } else if (_value == 'neurology') {
        menuitems = [];
        populateNeurology();
      } else if (_value == 'psychology') {
        menuitems = [];
        populatePsychology();
      } else if (_value == 'musckuloskeletal') {
        menuitems = [];
        populateMusckuloskeletal();
      } else if (_value == 'headNeckBack') {
        menuitems = [];
        populateHeadNeckBack();
      } else if (_value == 'upperLimb') {
        menuitems = [];
        populateUpperLimb();
      } else if (_value == 'hand') {
        menuitems = [];
        populateHand();
      } else if (_value == 'lowerLimb') {
        menuitems = [];
        populateLowerLimb();
      } else if (_value == 'others') {
        menuitems = [];
        populateOthers();
      } else if (_value == 'bpPrLab') {
        menuitems = [];
        //populateBpPrLab();
      } else if (_value == 'injuriesSuicideIntoxicationBurn') {
        menuitems = [];
        populateInjuriesSuicideIntoxicationBurn();
      } else if (_value == 'mouth') {
        menuitems = [];
        populateMouth();
      } else if (_value == 'appetite') {
        menuitems = [];
        populateAppetite();
      } else if (_value == 'entThroat') {
        menuitems = [];
        populateEntThroat();
      } else if (_value == 'entNose') {
        menuitems = [];
        populateEntNose();
      } else if (_value == 'entEar') {
        menuitems = [];
        populateEntEar();
      } else if (_value == 'dermatology') {
        menuitems = [];
        populateDermatology();
      } else if (_value == 'gynecology') {
        menuitems = [];
        populateGynecology();
      } else if (_value == 'uroKidney') {
        menuitems = [];
        populatEuroKidney();
      } else if (_value == 'maleGenital') {
        menuitems = [];
        populatMaleGenital();
      } else if (_value == 'ophthalmology') {
        menuitems = [];
        populatOphthalmology();
      } else if (_value == 'breast') {
        menuitems = [];
        populatBreast();
      }
      setState(() {
        regionSelected03 = _value;

        disabledropdown03 = false;
      });
    }

    void selected04(_value) {
      if (_value == "cardioRespiratory") {
        menuitems = [];
        populateCardioRespiratory();
      } else if (_value == "gastroIntestinal") {
        menuitems = [];
        populateGastroIntestinal();
      } else if (_value == "peiranalAbdomen") {
        menuitems = [];
        populatePeiranalAbdomen();
      } else if (_value == 'neurology') {
        menuitems = [];
        populateNeurology();
      } else if (_value == 'psychology') {
        menuitems = [];
        populatePsychology();
      } else if (_value == 'musckuloskeletal') {
        menuitems = [];
        populateMusckuloskeletal();
      } else if (_value == 'headNeckBack') {
        menuitems = [];
        populateHeadNeckBack();
      } else if (_value == 'upperLimb') {
        menuitems = [];
        populateUpperLimb();
      } else if (_value == 'hand') {
        menuitems = [];
        populateHand();
      } else if (_value == 'lowerLimb') {
        menuitems = [];
        populateLowerLimb();
      } else if (_value == 'others') {
        menuitems = [];
        populateOthers();
      } else if (_value == 'bpPrLab') {
        menuitems = [];
        //populateBpPrLab();
      } else if (_value == 'injuriesSuicideIntoxicationBurn') {
        menuitems = [];
        populateInjuriesSuicideIntoxicationBurn();
      } else if (_value == 'mouth') {
        menuitems = [];
        populateMouth();
      } else if (_value == 'appetite') {
        menuitems = [];
        populateAppetite();
      } else if (_value == 'entThroat') {
        menuitems = [];
        populateEntThroat();
      } else if (_value == 'entNose') {
        menuitems = [];
        populateEntNose();
      } else if (_value == 'entEar') {
        menuitems = [];
        populateEntEar();
      } else if (_value == 'dermatology') {
        menuitems = [];
        populateDermatology();
      } else if (_value == 'gynecology') {
        menuitems = [];
        populateGynecology();
      } else if (_value == 'uroKidney') {
        menuitems = [];
        populatEuroKidney();
      } else if (_value == 'maleGenital') {
        menuitems = [];
        populatMaleGenital();
      } else if (_value == 'ophthalmology') {
        menuitems = [];
        populatOphthalmology();
      } else if (_value == 'breast') {
        menuitems = [];
        populatBreast();
      }
      setState(() {
        regionSelected04 = _value;

        disabledropdown04 = false;
      });
    }

    void selected05(_value) {
      if (_value == "cardioRespiratory") {
        menuitems = [];
        populateCardioRespiratory();
      } else if (_value == "gastroIntestinal") {
        menuitems = [];
        populateGastroIntestinal();
      } else if (_value == "peiranalAbdomen") {
        menuitems = [];
        populatePeiranalAbdomen();
      } else if (_value == 'neurology') {
        menuitems = [];
        populateNeurology();
      } else if (_value == 'psychology') {
        menuitems = [];
        populatePsychology();
      } else if (_value == 'musckuloskeletal') {
        menuitems = [];
        populateMusckuloskeletal();
      } else if (_value == 'headNeckBack') {
        menuitems = [];
        populateHeadNeckBack();
      } else if (_value == 'upperLimb') {
        menuitems = [];
        populateUpperLimb();
      } else if (_value == 'hand') {
        menuitems = [];
        populateHand();
      } else if (_value == 'lowerLimb') {
        menuitems = [];
        populateLowerLimb();
      } else if (_value == 'others') {
        menuitems = [];
        populateOthers();
      } else if (_value == 'bpPrLab') {
        menuitems = [];
        //populateBpPrLab();
      } else if (_value == 'injuriesSuicideIntoxicationBurn') {
        menuitems = [];
        populateInjuriesSuicideIntoxicationBurn();
      } else if (_value == 'mouth') {
        menuitems = [];
        populateMouth();
      } else if (_value == 'appetite') {
        menuitems = [];
        populateAppetite();
      } else if (_value == 'entThroat') {
        menuitems = [];
        populateEntThroat();
      } else if (_value == 'entNose') {
        menuitems = [];
        populateEntNose();
      } else if (_value == 'entEar') {
        menuitems = [];
        populateEntEar();
      } else if (_value == 'dermatology') {
        menuitems = [];
        populateDermatology();
      } else if (_value == 'gynecology') {
        menuitems = [];
        populateGynecology();
      } else if (_value == 'uroKidney') {
        menuitems = [];
        populatEuroKidney();
      } else if (_value == 'maleGenital') {
        menuitems = [];
        populatMaleGenital();
      } else if (_value == 'ophthalmology') {
        menuitems = [];
        populatOphthalmology();
      } else if (_value == 'breast') {
        menuitems = [];
        populatBreast();
      }
      setState(() {
        regionSelected05 = _value;

        disabledropdown05 = false;
      });
    }

    void selected06(_value) {
      if (_value == "cardioRespiratory") {
        menuitems = [];
        populateCardioRespiratory();
      } else if (_value == "gastroIntestinal") {
        menuitems = [];
        populateGastroIntestinal();
      } else if (_value == "peiranalAbdomen") {
        menuitems = [];
        populatePeiranalAbdomen();
      } else if (_value == 'neurology') {
        menuitems = [];
        populateNeurology();
      } else if (_value == 'psychology') {
        menuitems = [];
        populatePsychology();
      } else if (_value == 'musckuloskeletal') {
        menuitems = [];
        populateMusckuloskeletal();
      } else if (_value == 'headNeckBack') {
        menuitems = [];
        populateHeadNeckBack();
      } else if (_value == 'upperLimb') {
        menuitems = [];
        populateUpperLimb();
      } else if (_value == 'hand') {
        menuitems = [];
        populateHand();
      } else if (_value == 'lowerLimb') {
        menuitems = [];
        populateLowerLimb();
      } else if (_value == 'others') {
        menuitems = [];
        populateOthers();
      } else if (_value == 'bpPrLab') {
        menuitems = [];
        //populateBpPrLab();
      } else if (_value == 'injuriesSuicideIntoxicationBurn') {
        menuitems = [];
        populateInjuriesSuicideIntoxicationBurn();
      } else if (_value == 'mouth') {
        menuitems = [];
        populateMouth();
      } else if (_value == 'appetite') {
        menuitems = [];
        populateAppetite();
      } else if (_value == 'entThroat') {
        menuitems = [];
        populateEntThroat();
      } else if (_value == 'entNose') {
        menuitems = [];
        populateEntNose();
      } else if (_value == 'entEar') {
        menuitems = [];
        populateEntEar();
      } else if (_value == 'dermatology') {
        menuitems = [];
        populateDermatology();
      } else if (_value == 'gynecology') {
        menuitems = [];
        populateGynecology();
      } else if (_value == 'uroKidney') {
        menuitems = [];
        populatEuroKidney();
      } else if (_value == 'maleGenital') {
        menuitems = [];
        populatMaleGenital();
      } else if (_value == 'ophthalmology') {
        menuitems = [];
        populatOphthalmology();
      } else if (_value == 'breast') {
        menuitems = [];
        populatBreast();
      }
      setState(() {
        regionSelected06 = _value;

        disabledropdown06 = false;
      });
    }

    void selected07(_value) {
      if (_value == "cardioRespiratory") {
        menuitems = [];
        populateCardioRespiratory();
      } else if (_value == "gastroIntestinal") {
        menuitems = [];
        populateGastroIntestinal();
      } else if (_value == "peiranalAbdomen") {
        menuitems = [];
        populatePeiranalAbdomen();
      } else if (_value == 'neurology') {
        menuitems = [];
        populateNeurology();
      } else if (_value == 'psychology') {
        menuitems = [];
        populatePsychology();
      } else if (_value == 'musckuloskeletal') {
        menuitems = [];
        populateMusckuloskeletal();
      } else if (_value == 'headNeckBack') {
        menuitems = [];
        populateHeadNeckBack();
      } else if (_value == 'upperLimb') {
        menuitems = [];
        populateUpperLimb();
      } else if (_value == 'hand') {
        menuitems = [];
        populateHand();
      } else if (_value == 'lowerLimb') {
        menuitems = [];
        populateLowerLimb();
      } else if (_value == 'others') {
        menuitems = [];
        populateOthers();
      } else if (_value == 'bpPrLab') {
        menuitems = [];
        //populateBpPrLab();
      } else if (_value == 'injuriesSuicideIntoxicationBurn') {
        menuitems = [];
        populateInjuriesSuicideIntoxicationBurn();
      } else if (_value == 'mouth') {
        menuitems = [];
        populateMouth();
      } else if (_value == 'appetite') {
        menuitems = [];
        populateAppetite();
      } else if (_value == 'entThroat') {
        menuitems = [];
        populateEntThroat();
      } else if (_value == 'entNose') {
        menuitems = [];
        populateEntNose();
      } else if (_value == 'entEar') {
        menuitems = [];
        populateEntEar();
      } else if (_value == 'dermatology') {
        menuitems = [];
        populateDermatology();
      } else if (_value == 'gynecology') {
        menuitems = [];
        populateGynecology();
      } else if (_value == 'uroKidney') {
        menuitems = [];
        populatEuroKidney();
      } else if (_value == 'maleGenital') {
        menuitems = [];
        populatMaleGenital();
      } else if (_value == 'ophthalmology') {
        menuitems = [];
        populatOphthalmology();
      } else if (_value == 'breast') {
        menuitems = [];
        populatBreast();
      }
      setState(() {
        regionSelected07 = _value;

        disabledropdown07 = false;
      });
    }

    void secondselected(_value) {
      setState(() {
        complainSelected01 = _value;
      });
    }

    void secondselected2(_value) {
      setState(() {
        complainSelected02 = _value;
      });
    }

    void secondselected3(_value) {
      setState(() {
        complainSelected03 = _value;
      });
    }

    void secondselected4(_value) {
      setState(() {
        complainSelected04 = _value;
      });
    }

    void secondselected5(_value) {
      setState(() {
        complainSelected05 = _value;
      });
    }

    void secondselected6(_value) {
      setState(() {
        complainSelected06 = _value;
      });
    }

    void secondselected7(_value) {
      setState(() {
        complainSelected07 = _value;
      });
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: _scaffoldkey,
      backgroundColor: Colors.grey[200],
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: AppBar(
          backgroundColor: Colors.deepOrange,
          title: Text(
            LocaleKeys.view_patient_patient_complain.tr(),
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          centerTitle: true,
          elevation: 0,
        ),
      ),
      drawer: Container(
        width: getDeviceType(context, 180, 290, 520, 600),
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.only(bottom: 20),
        child: Container(
          height: 50,
          width: 150,
          child: FloatingActionButton.extended(
            icon: Icon(
              Icons.arrow_forward,
              color: Colors.white,
            ),
            elevation: 0.0,
            backgroundColor: Colors.deepOrange,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
            onPressed: () async {
              FinalScore.age = await getage(_age);
              if (_age == '') {
                setState(() {
                  _error = LocaleKeys.error_age_message.tr(); //'Please , enter your age';
                });
                _showSnackBar();
              } else if (FinalScore.age == null) {
                setState(() {
                  _error = LocaleKeys.view_patient_age_format.tr();
                });
                _showSnackBar();
              } else if (FinalScore.age > 130) {
                setState(() {
                  _error = LocaleKeys.error_age_message_error.tr();
                });
                _showSnackBar();
              } else {
                if (radioSelect == '') {
                  setState(() {
                    _error = LocaleKeys.error_gender_message.tr();
//'Please , select a gender';
                  });
                  _showSnackBar();
                } else {
                  if (complainSelected01 == null) {
                    setState(() {
                      _error = LocaleKeys.error_complain_message.tr();
                    //'Please , select a main complaint';
                    });
                    _showSnackBar();
                  } else {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => PatientRiskFactors(
                          chiefcomplaint: complainSelected01,
                          sym2: complainSelected02,
                          sym3: complainSelected03,
                          sym4: complainSelected04,
                          sym5: complainSelected05,
                          sym6: complainSelected06,
                          sym7: complainSelected07,
                          gender: radioSelect,
                        ),
                      ),
                    );
                  }
                }
              }
            },
            label: Text(LocaleKeys.view_buttons_next.tr(), style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Center(
        child: Padding(
          padding: EdgeInsets.only(top: 20),
          child: Container(
            width: 100,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: ListView(
                    children: [
                      Container(
                        decoration: CStyle.box,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: Text(
                                  LocaleKeys.view_patient_result_age_gender.tr(),
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Divider(
                                color: Colors.grey,
                                thickness: 2,
                                indent: 90,
                                endIndent: 90,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextField(
                                    keyboardType: TextInputType.numberWithOptions(decimal: true),
                                    /*inputFormatters: [
                                        FilteringTextInputFormatter.allow(
                                            RegExp('[0-9.,]')),
                                      ],*/
                                    controller: ageController,
                                    onChanged: (ageController) {
                                      if (ageController.isEmpty) {
                                        setState(() {
                                          _age = '';
                                        });
                                      } else {
                                        setState(() {
                                          _age = ageController.toString();
                                        });
                                      }
                                    },
                                    decoration: CStyle.getInputDecoration(context).copyWith(
                                      hintText: LocaleKeys.view_patient_age.tr(),
                                      hintStyle: TextStyle(fontSize: 12),
                                      prefixIcon: Icon(
                                        Icons.person_search,
                                        color: Colors.deepOrange,
                                      ),
                                      filled: true,
                                    )),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                    fit: FlexFit.loose,
                                    child: RadioListTile(
                                      title: Text(
                                        'view_patient_male'.tr(),
                                        style: _textStylePatient.copyWith(fontSize: 12),
                                      ),
                                      activeColor: Colors.deepOrange,
                                      value: radioGender[0],
                                      groupValue: radioSelect,
                                      onChanged: (value) {
                                        setState(() {
                                          regionSelected01 = null;
                                          regionSelected02 = null;
                                          regionSelected03 = null;
                                          regionSelected04 = null;
                                          regionSelected05 = null;
                                          regionSelected06 = null;
                                          regionSelected07 = null;
                                          complainSelected01 = null;
                                          complainSelected02 = null;
                                          complainSelected03 = null;
                                          complainSelected04 = null;
                                          complainSelected05 = null;
                                          complainSelected06 = null;
                                          complainSelected07 = null;
                                          radioSelect = value;
                                        });
                                      },
                                    ),
                                  ),
                                  Flexible(
                                      fit: FlexFit.loose,
                                      child: RadioListTile(
                                        title: Text(
                                          'view_patient_female'.tr(),
                                          style: _textStylePatient.copyWith(fontSize: 12),
                                        ),
                                        activeColor: Colors.deepOrange,
                                        value: radioGender[1],
                                        groupValue: radioSelect,
                                        onChanged: (value) {
                                          setState(() {
                                            regionSelected01 = null;
                                            regionSelected02 = null;
                                            regionSelected03 = null;
                                            regionSelected04 = null;
                                            regionSelected05 = null;
                                            regionSelected06 = null;
                                            regionSelected07 = null;
                                            complainSelected01 = null;
                                            complainSelected02 = null;
                                            complainSelected03 = null;
                                            complainSelected04 = null;
                                            complainSelected05 = null;
                                            complainSelected06 = null;
                                            complainSelected07 = null;
                                            radioSelect = value;
                                          });
                                        },
                                      )),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                        decoration: CStyle.box,
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            children: [
                              Center(
                                child: Container(
                                  child: FittedBox(
                                    fit: BoxFit.fitWidth,
                                    child: Text(
                                  LocaleKeys.view_patient_main_complain.tr(),
                                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ),
                              Divider(
                                color: Colors.grey,
                                thickness: 2,
                                indent: 30,
                                endIndent: 30,
                              ),
                              DropdownButton<String>(
                                isExpanded: true,
                                items: [
                                  DropdownMenuItem<String>(
                                    value: "cardioRespiratory",
                                    child: Text(('heart_lung').tr()),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: "gastroIntestinal",
                                    child: Text(('git').tr()),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: "peiranalAbdomen",
                                    child: Text(('perianal_abdomen').tr()),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: "neurology",
                                    child: Text(('brain_neuron').tr()),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: "musckuloskeletal",
                                    child: Text(('skeleton_muscles').tr()),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: "headNeckBack",
                                    child: Text(('head_neck_back').tr()),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: "upperLimb",
                                    child: Text(('upper_limb').tr()),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: "lowerLimb",
                                    child: Text(('lower_limb').tr()),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: "hand",
                                    child: Text(('Hand').tr()),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: "mouth",
                                    child: Text(('mouth').tr()),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: "appetite",
                                    child: Text(('appetite').tr()),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: "entThroat",
                                    child: Text(('throat').tr()),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: "entNose",
                                    child: Text(('nose').tr()),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: "entEar",
                                    child: Text(('ear').tr()),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: "ophthalmology",
                                    child: Text(('eye').tr()),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: "dermatology",
                                    child: Text(('skin').tr()),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: "uroKidney",
                                    child: Text(('uro').tr()),
                                  ),
                                  radioSelect == 'Male'
                                      ? DropdownMenuItem<String>(
                                          value: "maleGenital",
                                          child: Text(('male_genital').tr()),
                                        )
                                      : DropdownMenuItem<String>(
                                          value: "gynecology",
                                          child: Text(('gynecology').tr()),
                                        ),
                                  DropdownMenuItem<String>(
                                    value: "breast",
                                    child: Text(('Breast').tr()),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: "psychology",
                                    child: Text(('psychology').tr()),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: "injuriesSuicideIntoxicationBurn",
                                    child: Text(('injuriesSuicideIntoxicationBurn').tr()),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: "others",
                                    child: Text(('other_symptoms').tr()),
                                  ),
                                ],
                                value: regionSelected01,
                                onChanged: (_value) => selected01(_value),
                                hint: FittedBox(
                                  fit: BoxFit.fitWidth,
                                  child: Text(LocaleKeys.view_patient_complain_area.tr()),
                                ),
                              ),
                              DropdownButton<String>(
                                isExpanded: true,
                                items: menuitems,
                                onChanged: disabledropdown01 ? null : (value) => secondselected(value),
                                hint: Text(
                                  complainSelected01 == null
                                      ? LocaleKeys.view_patient_choose_complain.tr()
                                      : (complainSelected01).tr(),
                                  style: TextStyle(color: complainSelected01 == null ? Colors.grey[700] : Colors.black),
                                ),
                                disabledHint: Text((LocaleKeys.view_patient_first_choose_complain.tr())),
                              ),
                              SwitchListTile(
                                  activeColor: Colors.deepOrange,
                                  dense: true,
                                  title: AutoSizeText(
                                   LocaleKeys.view_patient_other_complain.tr(),
                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                                    maxLines: 1,
                                  ),
                                  value: _switch01,
                                  onChanged: (bool s) {
                                    setState(() {
                                      _switch01 = s;
                                      _visibile01 = !_visibile01;
                                    });
                                  }),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Visibility(
                        visible: _visibile01,
                        child: Container(
                          decoration: CStyle.box,
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              children: [
                                Center(
                                  child: Container(
                                    child: Text(
                                     LocaleKeys.view_patient_add_complains.tr(),
                                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                                Divider(
                                  color: Colors.grey,
                                  thickness: 2,
                                  indent: 30,
                                  endIndent: 30,
                                ),
                                DropdownButton<String>(
                                  isExpanded: true,
                                 items: [
                                  DropdownMenuItem<String>(
                                    value: "cardioRespiratory",
                                    child: Text(('heart_lung').tr()),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: "gastroIntestinal",
                                    child: Text(('git').tr()),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: "peiranalAbdomen",
                                    child: Text(('perianal_abdomen').tr()),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: "neurology",
                                    child: Text(('brain_neuron').tr()),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: "musckuloskeletal",
                                    child: Text(('skeleton_muscles').tr()),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: "headNeckBack",
                                    child: Text(('head_neck_back').tr()),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: "upperLimb",
                                    child: Text(('upper_limb').tr()),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: "lowerLimb",
                                    child: Text(('lower_limb').tr()),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: "hand",
                                    child: Text(('Hand').tr()),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: "mouth",
                                    child: Text(('mouth').tr()),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: "appetite",
                                    child: Text(('appetite').tr()),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: "entThroat",
                                    child: Text(('throat').tr()),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: "entNose",
                                    child: Text(('nose').tr()),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: "entEar",
                                    child: Text(('ear').tr()),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: "ophthalmology",
                                    child: Text(('eye').tr()),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: "dermatology",
                                    child: Text(('skin').tr()),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: "uroKidney",
                                    child: Text(('uro').tr()),
                                  ),
                                  radioSelect == 'Male'
                                      ? DropdownMenuItem<String>(
                                          value: "maleGenital",
                                          child: Text(('male_genital').tr()),
                                        )
                                      : DropdownMenuItem<String>(
                                          value: "gynecology",
                                          child: Text(('gynecology').tr()),
                                        ),
                                  DropdownMenuItem<String>(
                                    value: "breast",
                                    child: Text(('Breast').tr()),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: "psychology",
                                    child: Text(('psychology').tr()),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: "injuriesSuicideIntoxicationBurn",
                                    child: Text(('injuriesSuicideIntoxicationBurn').tr()),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: "others",
                                    child: Text(('other_symptoms').tr()),
                                  ),
                                ],
                                  value: regionSelected02,
                                  onChanged: (_value) => selected02(_value),
                                  hint: FittedBox(
                                    fit: BoxFit.fitWidth,
                                  child: Text(LocaleKeys.view_patient_complain_area.tr()),
                                  ),
                                ),
                                DropdownButton<String>(
                                  isExpanded: true,
                                  items: menuitems,
                                  onChanged: disabledropdown02 ? null : (value) => secondselected2(value),
                                  hint: Text(
                                    complainSelected02 == null
                                        ?  LocaleKeys.view_patient_choose_complain.tr()
                                        : (complainSelected02).tr(),
                                    style: TextStyle(color: complainSelected02 == null ? Colors.grey[700] : Colors.black),
                                  ),
                                disabledHint: Text((LocaleKeys.view_patient_first_choose_complain.tr())),
                                ),
                                SwitchListTile(
                                    activeColor: Colors.deepOrange,
                                    dense: true,
                                    title: AutoSizeText(
                                   LocaleKeys.view_patient_other_complain.tr(),
                                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                                      maxLines: 1,
                                    ),
                                    value: _switch02,
                                    onChanged: (bool s) {
                                      setState(() {
                                        _switch02 = s;
                                        _visibile02 = !_visibile02;
                                      });
                                    }),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Visibility(
                        visible: _visibile02,
                        child: Container(
                          decoration: CStyle.box,
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              children: [
                                Center(
                                  child: Container(
                                    child: Text(
                                      LocaleKeys.view_patient_add_complains.tr(),
                                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                                Divider(
                                  color: Colors.grey,
                                  thickness: 2,
                                  indent: 30,
                                  endIndent: 30,
                                ),
                                DropdownButton<String>(
                                  isExpanded: true,
                                              items: [
                                  DropdownMenuItem<String>(
                                    value: "cardioRespiratory",
                                    child: Text(('heart_lung').tr()),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: "gastroIntestinal",
                                    child: Text(('git').tr()),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: "peiranalAbdomen",
                                    child: Text(('perianal_abdomen').tr()),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: "neurology",
                                    child: Text(('brain_neuron').tr()),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: "musckuloskeletal",
                                    child: Text(('skeleton_muscles').tr()),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: "headNeckBack",
                                    child: Text(('head_neck_back').tr()),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: "upperLimb",
                                    child: Text(('upper_limb').tr()),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: "lowerLimb",
                                    child: Text(('lower_limb').tr()),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: "hand",
                                    child: Text(('Hand').tr()),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: "mouth",
                                    child: Text(('mouth').tr()),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: "appetite",
                                    child: Text(('appetite').tr()),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: "entThroat",
                                    child: Text(('throat').tr()),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: "entNose",
                                    child: Text(('nose').tr()),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: "entEar",
                                    child: Text(('ear').tr()),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: "ophthalmology",
                                    child: Text(('eye').tr()),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: "dermatology",
                                    child: Text(('skin').tr()),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: "uroKidney",
                                    child: Text(('uro').tr()),
                                  ),
                                  radioSelect == 'Male'
                                      ? DropdownMenuItem<String>(
                                          value: "maleGenital",
                                          child: Text(('male_genital').tr()),
                                        )
                                      : DropdownMenuItem<String>(
                                          value: "gynecology",
                                          child: Text(('gynecology').tr()),
                                        ),
                                  DropdownMenuItem<String>(
                                    value: "breast",
                                    child: Text(('Breast').tr()),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: "psychology",
                                    child: Text(('psychology').tr()),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: "injuriesSuicideIntoxicationBurn",
                                    child: Text(('injuriesSuicideIntoxicationBurn').tr()),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: "others",
                                    child: Text(('other_symptoms').tr()),
                                  ),
                                ],
                                  value: regionSelected03,
                                  onChanged: (_value) => selected03(_value),
                                  hint: FittedBox(
                                    fit: BoxFit.fitWidth,
                                  child: Text(LocaleKeys.view_patient_complain_area.tr()),
                                  ),
                                ),
                                DropdownButton<String>(
                                  isExpanded: true,
                                  items: menuitems,
                                  onChanged: disabledropdown03 ? null : (value) => secondselected3(value),
                                  hint: Text(
                                    complainSelected03 == null
                                       ? LocaleKeys.view_patient_choose_complain.tr()
                                      : (complainSelected03).tr(),
                                    style: TextStyle(color: complainSelected03 == null ? Colors.grey[700] : Colors.black),
                                  ),
                                disabledHint: Text((LocaleKeys.view_patient_first_choose_complain.tr())),
                                ),
                                SwitchListTile(
                                    activeColor: Colors.deepOrange,
                                    dense: true,
                                    title: AutoSizeText(
                                   LocaleKeys.view_patient_other_complain.tr(),
                                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                                      maxLines: 1,
                                    ),
                                    value: _switch03,
                                    onChanged: (bool s) {
                                      setState(() {
                                        _switch03 = s;
                                        _visibile03 = !_visibile03;
                                      });
                                    }),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Visibility(
                        visible: _visibile03,
                        child: Container(
                          decoration: CStyle.box,
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              children: [
                                Center(
                                  child: Container(
                                    child: Text(
                                     LocaleKeys.view_patient_add_complains.tr(),
                                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                                Divider(
                                  color: Colors.grey,
                                  thickness: 2,
                                  indent: 30,
                                  endIndent: 30,
                                ),
                                DropdownButton<String>(
                                  isExpanded: true,
                                    items: [
                                  DropdownMenuItem<String>(
                                    value: "cardioRespiratory",
                                    child: Text(('heart_lung').tr()),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: "gastroIntestinal",
                                    child: Text(('git').tr()),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: "peiranalAbdomen",
                                    child: Text(('perianal_abdomen').tr()),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: "neurology",
                                    child: Text(('brain_neuron').tr()),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: "musckuloskeletal",
                                    child: Text(('skeleton_muscles').tr()),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: "headNeckBack",
                                    child: Text(('head_neck_back').tr()),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: "upperLimb",
                                    child: Text(('upper_limb').tr()),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: "lowerLimb",
                                    child: Text(('lower_limb').tr()),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: "hand",
                                    child: Text(('Hand').tr()),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: "mouth",
                                    child: Text(('mouth').tr()),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: "appetite",
                                    child: Text(('appetite').tr()),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: "entThroat",
                                    child: Text(('throat').tr()),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: "entNose",
                                    child: Text(('nose').tr()),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: "entEar",
                                    child: Text(('ear').tr()),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: "ophthalmology",
                                    child: Text(('eye').tr()),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: "dermatology",
                                    child: Text(('skin').tr()),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: "uroKidney",
                                    child: Text(('uro').tr()),
                                  ),
                                  radioSelect == 'Male'
                                      ? DropdownMenuItem<String>(
                                          value: "maleGenital",
                                          child: Text(('male_genital').tr()),
                                        )
                                      : DropdownMenuItem<String>(
                                          value: "gynecology",
                                          child: Text(('gynecology').tr()),
                                        ),
                                  DropdownMenuItem<String>(
                                    value: "breast",
                                    child: Text(('Breast').tr()),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: "psychology",
                                    child: Text(('psychology').tr()),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: "injuriesSuicideIntoxicationBurn",
                                    child: Text(('injuriesSuicideIntoxicationBurn').tr()),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: "others",
                                    child: Text(('other_symptoms').tr()),
                                  ),
                                ],
                                 
                                  value: regionSelected04,
                                  onChanged: (_value) => selected04(_value),
                                  hint: FittedBox(
                                    fit: BoxFit.fitWidth,
                                  child: Text(LocaleKeys.view_patient_complain_area.tr()),
                                  ),
                                ),
                                DropdownButton<String>(
                                  isExpanded: true,
                                  items: menuitems,
                                  onChanged: disabledropdown04 ? null : (value) => secondselected4(value),
                                  hint: Text(
                                    complainSelected04 == null
                                        ?  LocaleKeys.view_patient_choose_complain.tr()
                                        : (complainSelected04).tr(),
                                    style: TextStyle(color: complainSelected04 == null ? Colors.grey[700] : Colors.black),
                                  ),
                                disabledHint: Text((LocaleKeys.view_patient_first_choose_complain.tr())),
                                ),
                                SwitchListTile(
                                    activeColor: Colors.deepOrange,
                                    dense: true,
                                    title: AutoSizeText(
                                   LocaleKeys.view_patient_other_complain.tr(),
                                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                                      maxLines: 1,
                                    ),
                                    value: _switch04,
                                    onChanged: (bool s) {
                                      setState(() {
                                        _switch04 = s;
                                        _visibile04 = !_visibile04;
                                      });
                                    }),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Visibility(
                        visible: _visibile04,
                        child: Container(
                          decoration: CStyle.box,
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              children: [
                                Center(
                                  child: Container(
                                    child: Text(
                                       LocaleKeys.view_patient_add_complains.tr(),
                                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                                Divider(
                                  color: Colors.grey,
                                  thickness: 2,
                                  indent: 30,
                                  endIndent: 30,
                                ),
                                DropdownButton<String>(
                                  isExpanded: true,
                                              items: [
                                  DropdownMenuItem<String>(
                                    value: "cardioRespiratory",
                                    child: Text(('heart_lung').tr()),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: "gastroIntestinal",
                                    child: Text(('git').tr()),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: "peiranalAbdomen",
                                    child: Text(('perianal_abdomen').tr()),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: "neurology",
                                    child: Text(('brain_neuron').tr()),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: "musckuloskeletal",
                                    child: Text(('skeleton_muscles').tr()),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: "headNeckBack",
                                    child: Text(('head_neck_back').tr()),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: "upperLimb",
                                    child: Text(('upper_limb').tr()),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: "lowerLimb",
                                    child: Text(('lower_limb').tr()),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: "hand",
                                    child: Text(('Hand').tr()),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: "mouth",
                                    child: Text(('mouth').tr()),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: "appetite",
                                    child: Text(('appetite').tr()),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: "entThroat",
                                    child: Text(('throat').tr()),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: "entNose",
                                    child: Text(('nose').tr()),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: "entEar",
                                    child: Text(('ear').tr()),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: "ophthalmology",
                                    child: Text(('eye').tr()),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: "dermatology",
                                    child: Text(('skin').tr()),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: "uroKidney",
                                    child: Text(('uro').tr()),
                                  ),
                                  radioSelect == 'Male'
                                      ? DropdownMenuItem<String>(
                                          value: "maleGenital",
                                          child: Text(('male_genital').tr()),
                                        )
                                      : DropdownMenuItem<String>(
                                          value: "gynecology",
                                          child: Text(('gynecology').tr()),
                                        ),
                                  DropdownMenuItem<String>(
                                    value: "breast",
                                    child: Text(('Breast').tr()),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: "psychology",
                                    child: Text(('psychology').tr()),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: "injuriesSuicideIntoxicationBurn",
                                    child: Text(('injuriesSuicideIntoxicationBurn').tr()),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: "others",
                                    child: Text(('other_symptoms').tr()),
                                  ),
                                ],
                                  value: regionSelected05,
                                  onChanged: (_value) => selected05(_value),
                                  hint: FittedBox(
                                    fit: BoxFit.fitWidth,
                                  child: Text(LocaleKeys.view_patient_complain_area.tr()),
                                  ),
                                ),
                                DropdownButton<String>(
                                  isExpanded: true,
                                  items: menuitems,
                                  onChanged: disabledropdown05 ? null : (value) => secondselected5(value),
                                  hint: Text(
                                    complainSelected05 == null
                                       ? LocaleKeys.view_patient_choose_complain.tr()
                                      : (complainSelected05).tr(),
                                    style: TextStyle(color: complainSelected05 == null ? Colors.grey[700] : Colors.black),
                                  ),
                                disabledHint: Text((LocaleKeys.view_patient_first_choose_complain.tr())),
                                ),
                                SwitchListTile(
                                    activeColor: Colors.deepOrange,
                                    dense: true,
                                    title: AutoSizeText(
                                   LocaleKeys.view_patient_other_complain.tr(),
                                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                                      maxLines: 1,
                                    ),
                                    value: _switch05,
                                    onChanged: (bool s) {
                                      setState(() {
                                        _switch05 = s;
                                        _visibile05 = !_visibile05;
                                      });
                                    }),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Visibility(
                        visible: _visibile05,
                        child: Container(
                          decoration: CStyle.box,
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              children: [
                                Center(
                                  child: Container(
                                    child: Text(
                                     LocaleKeys.view_patient_add_complains.tr(),
                                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                                Divider(
                                  color: Colors.grey,
                                  thickness: 2,
                                  indent: 30,
                                  endIndent: 30,
                                ),
                                DropdownButton<String>(
                                  isExpanded: true,
                                           items: [
                                  DropdownMenuItem<String>(
                                    value: "cardioRespiratory",
                                    child: Text(('heart_lung').tr()),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: "gastroIntestinal",
                                    child: Text(('git').tr()),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: "peiranalAbdomen",
                                    child: Text(('perianal_abdomen').tr()),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: "neurology",
                                    child: Text(('brain_neuron').tr()),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: "musckuloskeletal",
                                    child: Text(('skeleton_muscles').tr()),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: "headNeckBack",
                                    child: Text(('head_neck_back').tr()),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: "upperLimb",
                                    child: Text(('upper_limb').tr()),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: "lowerLimb",
                                    child: Text(('lower_limb').tr()),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: "hand",
                                    child: Text(('Hand').tr()),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: "mouth",
                                    child: Text(('mouth').tr()),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: "appetite",
                                    child: Text(('appetite').tr()),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: "entThroat",
                                    child: Text(('throat').tr()),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: "entNose",
                                    child: Text(('nose').tr()),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: "entEar",
                                    child: Text(('ear').tr()),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: "ophthalmology",
                                    child: Text(('eye').tr()),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: "dermatology",
                                    child: Text(('skin').tr()),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: "uroKidney",
                                    child: Text(('uro').tr()),
                                  ),
                                  radioSelect == 'Male'
                                      ? DropdownMenuItem<String>(
                                          value: "maleGenital",
                                          child: Text(('male_genital').tr()),
                                        )
                                      : DropdownMenuItem<String>(
                                          value: "gynecology",
                                          child: Text(('gynecology').tr()),
                                        ),
                                  DropdownMenuItem<String>(
                                    value: "breast",
                                    child: Text(('Breast').tr()),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: "psychology",
                                    child: Text(('psychology').tr()),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: "injuriesSuicideIntoxicationBurn",
                                    child: Text(('injuriesSuicideIntoxicationBurn').tr()),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: "others",
                                    child: Text(('other_symptoms').tr()),
                                  ),
                                ],
                               
                                  value: regionSelected06,
                                  onChanged: (_value) => selected06(_value),
                                  hint: FittedBox(
                                    fit: BoxFit.fitWidth,
                                  child: Text(LocaleKeys.view_patient_complain_area.tr()),
                                  ),
                                ),
                                DropdownButton<String>(
                                  isExpanded: true,
                                  items: menuitems,
                                  onChanged: disabledropdown06 ? null : (value) => secondselected6(value),
                                  hint: Text(
                                    complainSelected06 == null
                                        ?  LocaleKeys.view_patient_choose_complain.tr()
                                        : (complainSelected06).tr(),
                                    style: TextStyle(color: complainSelected06 == null ? Colors.grey[700] : Colors.black),
                                  ),
                                disabledHint: Text((LocaleKeys.view_patient_first_choose_complain.tr())),
                                ),
                                SwitchListTile(
                                    activeColor: Colors.deepOrange,
                                    dense: true,
                                    title: AutoSizeText(
                                   LocaleKeys.view_patient_other_complain.tr(),
                                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                                      maxLines: 1,
                                    ),
                                    value: _switch06,
                                    onChanged: (bool s) {
                                      setState(() {
                                        _switch06 = s;
                                        _visibile06 = !_visibile06;
                                      });
                                    }),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Visibility(
                        visible: _visibile06,
                        child: Container(
                          decoration: CStyle.box,
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              children: [
                                Center(
                                  child: Container(
                                    child: Text(
                                     LocaleKeys.view_patient_add_complains.tr(),
                                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                                Divider(
                                  color: Colors.grey,
                                  thickness: 2,
                                  indent: 30,
                                  endIndent: 30,
                                ),
                                DropdownButton<String>(
                                  isExpanded: true,
                                            items: [
                                  DropdownMenuItem<String>(
                                    value: "cardioRespiratory",
                                    child: Text(('heart_lung').tr()),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: "gastroIntestinal",
                                    child: Text(('git').tr()),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: "peiranalAbdomen",
                                    child: Text(('perianal_abdomen').tr()),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: "neurology",
                                    child: Text(('brain_neuron').tr()),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: "musckuloskeletal",
                                    child: Text(('skeleton_muscles').tr()),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: "headNeckBack",
                                    child: Text(('head_neck_back').tr()),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: "upperLimb",
                                    child: Text(('upper_limb').tr()),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: "lowerLimb",
                                    child: Text(('lower_limb').tr()),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: "hand",
                                    child: Text(('Hand').tr()),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: "mouth",
                                    child: Text(('mouth').tr()),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: "appetite",
                                    child: Text(('appetite').tr()),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: "entThroat",
                                    child: Text(('throat').tr()),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: "entNose",
                                    child: Text(('nose').tr()),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: "entEar",
                                    child: Text(('ear').tr()),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: "ophthalmology",
                                    child: Text(('eye').tr()),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: "dermatology",
                                    child: Text(('skin').tr()),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: "uroKidney",
                                    child: Text(('uro').tr()),
                                  ),
                                  radioSelect == 'Male'
                                      ? DropdownMenuItem<String>(
                                          value: "maleGenital",
                                          child: Text(('male_genital').tr()),
                                        )
                                      : DropdownMenuItem<String>(
                                          value: "gynecology",
                                          child: Text(('gynecology').tr()),
                                        ),
                                  DropdownMenuItem<String>(
                                    value: "breast",
                                    child: Text(('Breast').tr()),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: "psychology",
                                    child: Text(('psychology').tr()),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: "injuriesSuicideIntoxicationBurn",
                                    child: Text(('injuriesSuicideIntoxicationBurn').tr()),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: "others",
                                    child: Text(('other_symptoms').tr()),
                                  ),
                                ],
                                  value: regionSelected07,
                                  onChanged: (_value) => selected07(_value),
                                  hint: FittedBox(
                                    fit: BoxFit.fitWidth,
                                  child: Text(LocaleKeys.view_patient_complain_area.tr()),
                                  ),
                                ),
                                DropdownButton<String>(
                                  isExpanded: true,
                                  items: menuitems,
                                  onChanged: disabledropdown07 ? null : (value) => secondselected7(value),
                                  hint: Text(
                                    complainSelected07 == null
                                          ?  LocaleKeys.view_patient_choose_complain.tr()
                                        : (complainSelected07).tr(),
                                    style: TextStyle(color: complainSelected07 == null ? Colors.grey[700] : Colors.black),
                                  ),
                                disabledHint: Text((LocaleKeys.view_patient_first_choose_complain.tr())),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 100,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
