import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:project_doctor/matching_algorithm/final_score.dart';
import 'package:project_doctor/services/app_localizations.dart';
import 'package:project_doctor/constants/theme.dart';
import 'package:project_doctor/pages/patient_pages/patient_risk_factors.dart';

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
  String age = '';
  getage() {
    FinalScore.age = int.parse(age);
  }

  // =============================================Radio Buttons
  List gender = ['Male', 'Female'];
  String select = '';
  Row addRadioButton(int btnValue, String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Radio(
          activeColor: Colors.deepOrange,
          value: gender[btnValue],
          groupValue: select,
          onChanged: (value) {
            setState(() {
              select = value;
            });
          },
        ),
        Text(
          title,
          style: _textStylePatient,
        )
      ],
    );
  }

  bool state = false;

  // ----------------Conditional DropDownMenu ------------------
  String regionSelected01;
  String regionSelected02;
  String regionSelected03;
  String regionSelected04;
  String regionSelected05;
  String regionSelected06;
  String regionSelected07;
  String complainSelected01 = "";
  String complainSelected02 = "";
  String complainSelected03 = "";
  String complainSelected04 = "";
  String complainSelected05 = "";
  String complainSelected06 = "";
  String complainSelected07 = "";
  List<DropdownMenuItem<String>> menuitems = List();
  bool disabledropdown01 = true;
  bool disabledropdown02 = true;
  bool disabledropdown03 = true;
  bool disabledropdown04 = true;
  bool disabledropdown05 = true;
  bool disabledropdown06 = true;
  bool disabledropdown07 = true;

  final cardioRespiratory = {
    "1": "heamoptysis",
    "2": "orthopnea",
    "3": "PN dyspnea",
    "4": "palpitation",
    "5": "chest pain",
    "6": "cough",
    "7": "cyanosis",
    "8": "other cardiac problems",
    "9": "wheeze",
    "10": "other respiratory problems",
  };
  final gastroIntestinal = {
    "1": "abdominal pain",
    "2": "hiccough",
    "3": "vomiting",
    "4": "constipation",
    "5": "bloody diarrhea",
    "6": "watery diarrhea",
    "7": "dysphagia",
    "8": "odynophagia",
    "9": "mucousy diarrhea",
    "10": "other git problems",
    "11": "abdominal distension",
    "12": "bleeding per rectum",
    "13": "nausea",
    "14": "heamatemesis",
    "15": "malena",
  };
  final peiranalAbdomen = {
    "1": "perianal pain",
    "2": "perianal discharge",
    "3": "anal incontinence",
    "4": "perianal itching",
    "5": "abdominal wall swelling",
  };

  final neurology = {
    "1": "coma",
    "2": "fit",
    "3": "abnormal movement",
    "4": "spasm",
    "5": "memory loss",
    "6": "tremer",
    "7": "confusion",
    "8": "numbness",
    "9": "slurred speech",
    "10": "ataxia",
    "11": "weakness",
    "12": "other neurological problems",
    "13": "syncope",
  };

  final psychology = {
    "1": "cognitive impairement",
    "2": "behavioral impairement",
    "3": "depression",
    "4": "hallucination/delusion",
    "5": "phobia",
    "6": "suicide",
    "7": "obsession",
    "8": "attention deficit",
    "9": "hyperactivity",
    "10": "stress",
    "11": "psychological trauma",
    "12": "addiction",
    "13": "enuresis",
    "14": "incorporesis",
    "15": "polyphagia",
    "16": "other psychological problems",
  };
  final musckuloskeletal = {
    "1": "bone pain",
    "2": "joint pain",
    "3": "deformity",
    "4": "joint swelling",
    "5": "limitation of movement",
    "6": "fracture",
    "7": "limb pain",
    "8": "dislocation",
    "9": "other msk problems",
  };
  final headNeckBack = {
    "1": "jaw pain",
    "2": "neck pain",
    "3": "enlarged jaw",
    "4": "neck swelling",
    "5": "back openning",
    "6": "back mass",
    "7": "back pain",
    "8": "headache",
    "9": "large head",
    "10": "abnormal head shape",
    "11": "other skull problems",
  };
  final upperLimb = {
    "1": "left arm pain",
    "2": "left shoulder pain",
    "3": "bone pain",
    "4": "joint pain",
    "5": "deformity",
    "6": "joint swelling",
    "7": "limitation of movement",
    "8": "fracture",
    "9": "limb pain",
    "10": "dislocation",
  };

  final hand = {
    "1": "enlarged hand",
    "2": "extra digit",
    "3": "joined digit",
    "4": "loss digit",
    "5": "hand deformity",
    "6": "other hand problems",
    "7": "hand swelling",
    "8": "hand lump",
    "9": "bone pain",
    "10": "joint pain",
    "11": "joint swelling",
    "12": "fracture",
    "13": "dislocation",
  };
  final lowerLimb = {
    "1": "bilateral leg edema",
    "2": "enlarged foot",
    "3": "bone pain",
    "4": "joint pain'",
    "5": "unilateral leg swelling",
    "6": "unilateral leg pain",
    "7": "deformity",
    "8": "joint swelling",
    "9": "limitation of movement",
    "10": "leg pain during walking",
    "11": "foot ulcer",
    "12": "fracture",
    "13": "limb pain",
    "14": "dislocation",
  };

  final others = {
    "1": "sweating",
    "2": "fever",
    "3": "heat sensation",
    "4": "ulcer",
    "5": "insomnia",
    "6": "cold sensation",
    "7": "somnlence",
    "8": "polydepsia",
    "9": "delayed puberty",
    "10": "bleeding",
    "11": "bleeding",
    "12": "fatigue",
    "13": "pallor",
    "14": "lump",
    "15": "other health problems",
    "16": "malaise",
    "17": "short stature",
    "18": "taste loss",
  };
  final bpPrLab = {
    "1": "systolic BP > 180",
    "2": "diastolic BP > 100",
    "3": "systolic BP < 90",
    "4": "diastolic BP < 60",
    "5": "PR > 100",
    "6": "PR < 60",
    "7": "RBS > 200",
    "8": "RBS < 55",
    "9": "high blood urea > 90",
    "10": "high serum creatinine > 2",
    "11": "systolic BP > 140",
    "12": "diastolic BP > 90",
  };

  final injuriesSuicideIntoxicationBurn = {
    "1": "FFH",
    "2": "RTA",
    "3": "stab",
    "4": "shot",
    "5": "other injuries",
    "6": "suicide",
    "7": "intoxication",
    "8": "burn",
    "9": "msk injury",
    "10": "sport injury",
  };

  final mouth = {
    "1": "mouth deviation",
    "2": "cleft lip",
    "3": "cleft palate",
    "4": "disease of the mouth",
  };
  final appetite = {
    "1": "polyphagia",
    "2": "weight gain",
    "3": "weight loss",
    "4": "anorexia",
  };

  final entThroat = {
    "1": "hoarseness",
    "2": "sorethroat",
    "3": "other ent problems",
  };
  final entNose = {
    "1": "nasal discharge",
    "2": "nasal bleeding",
    "3": "nasal obstruction",
    "4": "nasal pain",
    "5": "nasal mass",
    "6": "nasal deformity",
    "7": "sneezing",
    "8": "nasal itching",
    "9": "anosmia",
    "10": "enlarged nose",
    "11": "other ent problems",
  };

  final entEar = {
    "1": "deafness",
    "2": "vertigo",
    "3": "tinnitus",
    "4": "ear discharge",
    "5": "ear redness",
    "6": "ear pain",
    "7": "other ent problems",
  };

  final dermatology = {
    "1": "dry skin",
    "2": "dry hair",
    "3": "skin rash",
    "4": "hair problems",
    "5": "skin redness",
    "6": "skin lesion",
    "7": "skin appendage",
    "8": "skin itching",
    "9": "acnes",
    "10": "bruising",
    "11": "female hirsuitism",
  };

  final gynecology = {
    "1": "amenorrhea",
    "2": "oligomenorrhea",
    "3": "decrease libido",
    "4": "menorrhagia",
    "5": "female infertility",
    "6": "female hirsuitism",
    "7": "prolong pregnancy",
    "8": "postmenopausal bleeding",
    "9": "other gynecological and obstetrical problems",
    "10": "miscarriage",
  };

  final uroKidney = {
    "1": "incontinence",
    "2": "polyuria",
    "3": "abnormal urethral openning site",
    "4": "suprapubic pain",
    "5": "frequency",
    "6": "flank pain",
    "7": "retention",
    "8": "urgency",
    "9": "dysuria",
    "10": "heamaturia",
    "11": "other urological problems",
    "12": "nocturia",
  };

  final maleGenital = {
    "1": "decrease libido",
    "2": "delayed puberty",
    "3": "male infertility",
    "4": "scrotal swelling",
    "5": "empty scrotum",
    "6": "abnormal penile size",
    "7": "penile mass",
    "8": "other penile problems",
    "9": "scrotal pain",
    "10": "priapism",
    "11": "impotence",
    "12": "heamatospermia",
  };

  final ophthalmology = {
    "1": "open eye",
    "2": "blindness",
    "3": "photophobia",
    "4": "double vision",
    "5": "lid drop",
    "6": "blurred vision",
    "7": "squint",
    "8": "eye redness",
    "9": "eye pain",
    "10": "eye discharge",
    "11": "eye itching",
    "12": "eye pigmentation",
    "13": "periorbital edema",
    "14": "eyelid deformity",
    "15": "dry eye",
    "16": "ophthalmoplegia",
    "17": "other ophthalmological problems",
  };
  final breast = {
    "1": "gynecomastia",
    "2": "galactorrhea",
    "3": "breast mass",
    "4": "breast pain",
    "5": "breast discharge",
    "6": "breast lump",
    "7": "breast skin lesion",
    "8": "other breast  problems",
  };

  void populateCardioRespiratory() {
    for (String key in cardioRespiratory.keys) {
      menuitems.add(DropdownMenuItem<String>(
        child: Text(cardioRespiratory[key]),
        value: cardioRespiratory[key],
      ));
    }
  }

  void populateGastroIntestinal() {
    for (String key in gastroIntestinal.keys) {
      menuitems.add(DropdownMenuItem<String>(
        child: Text(gastroIntestinal[key]),
        value: gastroIntestinal[key],
      ));
    }
  }

  void populatePeiranalAbdomen() {
    for (String key in peiranalAbdomen.keys) {
      menuitems.add(DropdownMenuItem<String>(
        child: Text(peiranalAbdomen[key]),
        value: peiranalAbdomen[key],
      ));
    }
  }

  void populateNeurology() {
    for (String key in neurology.keys) {
      menuitems.add(DropdownMenuItem<String>(
        child: Text(neurology[key]),
        value: neurology[key],
      ));
    }
  }

  void populatePsychology() {
    for (String key in psychology.keys) {
      menuitems.add(DropdownMenuItem<String>(
        child: Text(psychology[key]),
        value: psychology[key],
      ));
    }
  }

  void populateMusckuloskeletal() {
    for (String key in musckuloskeletal.keys) {
      menuitems.add(DropdownMenuItem<String>(
        child: Text(musckuloskeletal[key]),
        value: musckuloskeletal[key],
      ));
    }
  }

  void populateHeadNeckBack() {
    for (String key in headNeckBack.keys) {
      menuitems.add(DropdownMenuItem<String>(
        child: Text(headNeckBack[key]),
        value: headNeckBack[key],
      ));
    }
  }

  void populateUpperLimb() {
    for (String key in upperLimb.keys) {
      menuitems.add(DropdownMenuItem<String>(
        child: Text(upperLimb[key]),
        value: upperLimb[key],
      ));
    }
  }

  void populateHand() {
    for (String key in hand.keys) {
      menuitems.add(DropdownMenuItem<String>(
        child: Text(hand[key]),
        value: hand[key],
      ));
    }
  }

  void populateLowerLimb() {
    for (String key in lowerLimb.keys) {
      menuitems.add(DropdownMenuItem<String>(
        child: Text(lowerLimb[key]),
        value: lowerLimb[key],
      ));
    }
  }

  void populateOthers() {
    for (String key in others.keys) {
      menuitems.add(DropdownMenuItem<String>(
        child: Text(others[key]),
        value: others[key],
      ));
    }
  }

  void populateBpPrLab() {
    for (String key in bpPrLab.keys) {
      menuitems.add(DropdownMenuItem<String>(
        child: Text(bpPrLab[key]),
        value: bpPrLab[key],
      ));
    }
  }

  void populateInjuriesSuicideIntoxicationBurn() {
    for (String key in injuriesSuicideIntoxicationBurn.keys) {
      menuitems.add(DropdownMenuItem<String>(
        child: Text(injuriesSuicideIntoxicationBurn[key]),
        value: injuriesSuicideIntoxicationBurn[key],
      ));
    }
  }

  void populateMouth() {
    for (String key in mouth.keys) {
      menuitems.add(DropdownMenuItem<String>(
        child: Text(mouth[key]),
        value: mouth[key],
      ));
    }
  }

  void populateAppetite() {
    for (String key in appetite.keys) {
      menuitems.add(DropdownMenuItem<String>(
        child: Text(appetite[key]),
        value: appetite[key],
      ));
    }
  }

  void populateEntThroat() {
    for (String key in entThroat.keys) {
      menuitems.add(DropdownMenuItem<String>(
        child: Text(entThroat[key]),
        value: entThroat[key],
      ));
    }
  }

  void populateEntNose() {
    for (String key in entNose.keys) {
      menuitems.add(DropdownMenuItem<String>(
        child: Text(entNose[key]),
        value: entNose[key],
      ));
    }
  }

  void populateEntEar() {
    for (String key in entEar.keys) {
      menuitems.add(DropdownMenuItem<String>(
        child: Text(entEar[key]),
        value: entEar[key],
      ));
    }
  }

  void populateDermatology() {
    for (String key in dermatology.keys) {
      menuitems.add(DropdownMenuItem<String>(
        child: Text(dermatology[key]),
        value: dermatology[key],
      ));
    }
  }

  void populateGynecology() {
    for (String key in gynecology.keys) {
      menuitems.add(DropdownMenuItem<String>(
        child: Text(gynecology[key]),
        value: gynecology[key],
      ));
    }
  }

  void populatEuroKidney() {
    for (String key in uroKidney.keys) {
      menuitems.add(DropdownMenuItem<String>(
        child: Text(uroKidney[key]),
        value: uroKidney[key],
      ));
    }
  }

  void populatMaleGenital() {
    for (String key in maleGenital.keys) {
      menuitems.add(DropdownMenuItem<String>(
        child: Text(maleGenital[key]),
        value: maleGenital[key],
      ));
    }
  }

  void populatOphthalmology() {
    for (String key in ophthalmology.keys) {
      menuitems.add(DropdownMenuItem<String>(
        child: Text(ophthalmology[key]),
        value: ophthalmology[key],
      ));
    }
  }

  void populatBreast() {
    for (String key in breast.keys) {
      menuitems.add(DropdownMenuItem<String>(
        child: Text(breast[key]),
        value: breast[key],
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
      populateBpPrLab();
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
      populateBpPrLab();
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
      populateBpPrLab();
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
      populateBpPrLab();
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
      populateBpPrLab();
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
      populateBpPrLab();
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
      populateBpPrLab();
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

  bool _visibile01 = false;
  bool _switch01 = false;
  bool _visibile02 = false;
  bool _switch02 = false;
  bool _visibile03 = false;
  bool _switch03 = false;

  var regionSelected = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        title: Text(
          AppLocalizations.of(context).translate('patient_appbar'),
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 40),
        child: ListView(
          children: [
            Container(
              decoration: boxDecorationPatient,
              child: Column(
                children: [
                  TextField(
                      keyboardType: TextInputType.number,
                      controller: ageController,
                      onChanged: (ageController) {
                        setState(() {
                          age = ageController.toString();
                        });
                      },
                      decoration: InputDecoration(
                        hintText: 'Enter Your Age in Years',
                        prefixIcon: Icon(
                          Icons.person_search,
                          color: Colors.deepOrange,
                        ),
                        filled: true,
                      )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      addRadioButton(
                          0,
                          AppLocalizations.of(context)
                              .translate('patient_male')),
                      addRadioButton(
                          1,
                          AppLocalizations.of(context)
                              .translate('patient_female')),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Container(
              decoration: boxDecorationPatient,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Center(
                      child: Container(
                        child: Text(
                          'The Main Complain',
                          style: TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.bold),
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
                          child: Text("Heart and Lungs"),
                        ),
                        DropdownMenuItem<String>(
                          value: "gastroIntestinal",
                          child: Text("Gastro Intestinal Tract"),
                        ),
                        DropdownMenuItem<String>(
                          value: "peiranalAbdomen",
                          child: Text("Peri-Anal Area"),
                        ),
                        DropdownMenuItem<String>(
                          value: "neurology",
                          child: Text("Brain"),
                        ),
                        DropdownMenuItem<String>(
                          value: "psychology",
                          child: Text("Psychology"),
                        ),
                        DropdownMenuItem<String>(
                          value: "musckuloskeletal",
                          child: Text("Skeleton and Muscles"),
                        ),
                        DropdownMenuItem<String>(
                          value: "headNeckBack",
                          child: Text("Head, Neck and Back"),
                        ),
                        DropdownMenuItem<String>(
                          value: "upperLimb",
                          child: Text("upper Limb"),
                        ),
                        DropdownMenuItem<String>(
                          value: "hand",
                          child: Text("Hand"),
                        ),
                        DropdownMenuItem<String>(
                          value: "lowerLimb",
                          child: Text("Lower Limb"),
                        ),
                        DropdownMenuItem<String>(
                          value: "others",
                          child: Text("Other Symptoms"),
                        ),
                        DropdownMenuItem<String>(
                          value: "bpPrLab",
                          child: Text(
                              "Blood Pressure, Pulse and Lab Investigation"),
                        ),
                        DropdownMenuItem<String>(
                          value: "injuriesSuicideIntoxicationBurn",
                          child:
                              Text("Injuries, Suicide, Intoxication and Burn"),
                        ),
                        DropdownMenuItem<String>(
                          value: "mouth",
                          child: Text("Mouth"),
                        ),
                        DropdownMenuItem<String>(
                          value: "appetite",
                          child: Text("Appetite"),
                        ),
                        DropdownMenuItem<String>(
                          value: "entThroat",
                          child: Text("Throat"),
                        ),
                        DropdownMenuItem<String>(
                          value: "entNose",
                          child: Text("Nose"),
                        ),
                        DropdownMenuItem<String>(
                          value: "entEar",
                          child: Text("Ear"),
                        ),
                        DropdownMenuItem<String>(
                          value: "dermatology",
                          child: Text("Skin Problems"),
                        ),
                        DropdownMenuItem<String>(
                          value: "gynecology",
                          child: Text("Female Menstrual Health"),
                        ),
                        DropdownMenuItem<String>(
                          value: "uroKidney",
                          child: Text("Urinary Tract"),
                        ),
                        DropdownMenuItem<String>(
                          value: "maleGenital",
                          child: Text("Male Genital Health"),
                        ),
                        DropdownMenuItem<String>(
                          value: "ophthalmology",
                          child: Text("Eye Problems"),
                        ),
                        DropdownMenuItem<String>(
                          value: "breast",
                          child: Text("Breast"),
                        ),
                      ],
                      value: regionSelected01,
                      onChanged: (_value) => selected01(_value),
                      hint: Text(AppLocalizations.of(context)
                          .translate('patient_area_of_choice')),
                    ),
                    DropdownButton<String>(
                      isExpanded: true,
                      items: menuitems,
                      onChanged: disabledropdown01
                          ? null
                          : (value) => secondselected(value),
                      hint: Text(AppLocalizations.of(context)
                          .translate('patient_complain')),
                      disabledHint: Text(AppLocalizations.of(context)
                          .translate('patient_disablehint')),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Do you have another Complain',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        Switch(
                            value: _switch01,
                            activeColor: Colors.deepOrange,
                            onChanged: (bool s) {
                              setState(() {
                                _switch01 = s;
                                _visibile01 = !_visibile01;
                              });
                            })
                      ],
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Visibility(
              visible: _visibile01,
              child: Container(
                decoration: boxDecorationPatient,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Center(
                        child: Container(
                          child: Text(
                            'Additional Complains',
                            style: TextStyle(
                                fontSize: 18.0, fontWeight: FontWeight.bold),
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
                            child: Text("Heart and Lungs"),
                          ),
                          DropdownMenuItem<String>(
                            value: "gastroIntestinal",
                            child: Text("Gastro Intestinal Tract"),
                          ),
                          DropdownMenuItem<String>(
                            value: "peiranalAbdomen",
                            child: Text("Peri-Anal Area"),
                          ),
                          DropdownMenuItem<String>(
                            value: "neurology",
                            child: Text("Brain"),
                          ),
                          DropdownMenuItem<String>(
                            value: "psychology",
                            child: Text("Psychology"),
                          ),
                          DropdownMenuItem<String>(
                            value: "musckuloskeletal",
                            child: Text("Skeleton and Muscles"),
                          ),
                          DropdownMenuItem<String>(
                            value: "headNeckBack",
                            child: Text("Head, Neck and Back"),
                          ),
                          DropdownMenuItem<String>(
                            value: "upperLimb",
                            child: Text("upper Limb"),
                          ),
                          DropdownMenuItem<String>(
                            value: "hand",
                            child: Text("Hand"),
                          ),
                          DropdownMenuItem<String>(
                            value: "lowerLimb",
                            child: Text("Lower Limb"),
                          ),
                          DropdownMenuItem<String>(
                            value: "others",
                            child: Text("Other Symptoms"),
                          ),
                          DropdownMenuItem<String>(
                            value: "bpPrLab",
                            child: Text(
                                "Blood Pressure, Pulse and Lab Investigation"),
                          ),
                          DropdownMenuItem<String>(
                            value: "injuriesSuicideIntoxicationBurn",
                            child: Text(
                                "Injuries, Suicide, Intoxication and Burn"),
                          ),
                          DropdownMenuItem<String>(
                            value: "mouth",
                            child: Text("Mouth"),
                          ),
                          DropdownMenuItem<String>(
                            value: "appetite",
                            child: Text("Appetite"),
                          ),
                          DropdownMenuItem<String>(
                            value: "entThroat",
                            child: Text("Throat"),
                          ),
                          DropdownMenuItem<String>(
                            value: "entNose",
                            child: Text("Nose"),
                          ),
                          DropdownMenuItem<String>(
                            value: "entEar",
                            child: Text("Ear"),
                          ),
                          DropdownMenuItem<String>(
                            value: "dermatology",
                            child: Text("Skin Problems"),
                          ),
                          DropdownMenuItem<String>(
                            value: "gynecology",
                            child: Text("Female Menstrual Health"),
                          ),
                          DropdownMenuItem<String>(
                            value: "uroKidney",
                            child: Text("Urinary Tract"),
                          ),
                          DropdownMenuItem<String>(
                            value: "maleGenital",
                            child: Text("Male Genital Health"),
                          ),
                          DropdownMenuItem<String>(
                            value: "ophthalmology",
                            child: Text("Eye Problems"),
                          ),
                          DropdownMenuItem<String>(
                            value: "breast",
                            child: Text("Breast"),
                          ),
                        ],
                        value: regionSelected02,
                        onChanged: (_value) => selected02(_value),
                        hint: Text(AppLocalizations.of(context)
                            .translate('patient_area_of_choice')),
                      ),
                      DropdownButton<String>(
                        isExpanded: true,
                        items: menuitems,
                        onChanged: disabledropdown02
                            ? null
                            : (value) => secondselected2(value),
                        hint: Text(AppLocalizations.of(context)
                            .translate('patient_complain')),
                        disabledHint: Text(AppLocalizations.of(context)
                            .translate('patient_disablehint')),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Do you have another Complain',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                          Switch(
                              value: _switch02,
                              activeColor: Colors.deepOrange,
                              onChanged: (bool s) {
                                setState(() {
                                  _switch02 = s;
                                  _visibile02 = !_visibile02;
                                });
                              })
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Visibility(
              visible: _visibile02,
              child: Container(
                decoration: boxDecorationPatient,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Center(
                        child: Container(
                          child: Text(
                            'Additional Complains',
                            style: TextStyle(
                                fontSize: 18.0, fontWeight: FontWeight.bold),
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
                            child: Text("Heart and Lungs"),
                          ),
                          DropdownMenuItem<String>(
                            value: "gastroIntestinal",
                            child: Text("Gastro Intestinal Tract"),
                          ),
                          DropdownMenuItem<String>(
                            value: "peiranalAbdomen",
                            child: Text("Peri-Anal Area"),
                          ),
                          DropdownMenuItem<String>(
                            value: "neurology",
                            child: Text("Brain"),
                          ),
                          DropdownMenuItem<String>(
                            value: "psychology",
                            child: Text("Psychology"),
                          ),
                          DropdownMenuItem<String>(
                            value: "musckuloskeletal",
                            child: Text("Skeleton and Muscles"),
                          ),
                          DropdownMenuItem<String>(
                            value: "headNeckBack",
                            child: Text("Head, Neck and Back"),
                          ),
                          DropdownMenuItem<String>(
                            value: "upperLimb",
                            child: Text("upper Limb"),
                          ),
                          DropdownMenuItem<String>(
                            value: "hand",
                            child: Text("Hand"),
                          ),
                          DropdownMenuItem<String>(
                            value: "lowerLimb",
                            child: Text("Lower Limb"),
                          ),
                          DropdownMenuItem<String>(
                            value: "others",
                            child: Text("Other Symptoms"),
                          ),
                          DropdownMenuItem<String>(
                            value: "bpPrLab",
                            child: Text(
                                "Blood Pressure, Pulse and Lab Investigation"),
                          ),
                          DropdownMenuItem<String>(
                            value: "injuriesSuicideIntoxicationBurn",
                            child: Text(
                                "Injuries, Suicide, Intoxication and Burn"),
                          ),
                          DropdownMenuItem<String>(
                            value: "mouth",
                            child: Text("Mouth"),
                          ),
                          DropdownMenuItem<String>(
                            value: "appetite",
                            child: Text("Appetite"),
                          ),
                          DropdownMenuItem<String>(
                            value: "entThroat",
                            child: Text("Throat"),
                          ),
                          DropdownMenuItem<String>(
                            value: "entNose",
                            child: Text("Nose"),
                          ),
                          DropdownMenuItem<String>(
                            value: "entEar",
                            child: Text("Ear"),
                          ),
                          DropdownMenuItem<String>(
                            value: "dermatology",
                            child: Text("Skin Problems"),
                          ),
                          DropdownMenuItem<String>(
                            value: "gynecology",
                            child: Text("Female Menstrual Health"),
                          ),
                          DropdownMenuItem<String>(
                            value: "uroKidney",
                            child: Text("Urinary Tract"),
                          ),
                          DropdownMenuItem<String>(
                            value: "maleGenital",
                            child: Text("Male Genital Health"),
                          ),
                          DropdownMenuItem<String>(
                            value: "ophthalmology",
                            child: Text("Eye Problems"),
                          ),
                          DropdownMenuItem<String>(
                            value: "breast",
                            child: Text("Breast"),
                          ),
                        ],
                        onChanged: (_value) => selected03(_value),
                        hint: Text(AppLocalizations.of(context)
                            .translate('patient_area_of_choice')),
                      ),
                      DropdownButton<String>(
                        isExpanded: true,
                        items: menuitems,
                        onChanged: disabledropdown03
                            ? null
                            : (value) => secondselected3(value),
                        hint: Text(AppLocalizations.of(context)
                            .translate('patient_complain')),
                        disabledHint: Text(AppLocalizations.of(context)
                            .translate('patient_disablehint')),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Do you have another Complain',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                          Switch(
                              value: _switch03,
                              activeColor: Colors.deepOrange,
                              onChanged: (bool s) {
                                setState(() {
                                  _switch03 = s;
                                  _visibile03 = !_visibile03;
                                });
                              })
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            RaisedButton.icon(
              icon: Icon(
                Icons.arrow_forward,
                color: Colors.white,
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(80.0)),
              color: Colors.deepOrange,
              label: Text('Continue',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold)),
              onPressed: () async {
                getage();
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => PatientRiskFactors(
                          chiefcomplaint: complainSelected01,
                          sym2: complainSelected02,
                          sym3: complainSelected03,
                          sym4: complainSelected04,
                          sym5: complainSelected05,
                          sym6: complainSelected06,
                          sym7: complainSelected07,
                        )));
              },
            ),
          ],
        ),
      ),
    );
  }
}
