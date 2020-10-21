import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:project_doctor/matching_algorithm/final_score.dart';
import 'package:project_doctor/services/app_localizations.dart';
import 'package:project_doctor/constants/theme.dart';
import 'package:project_doctor/pages/patient_pages/patient02_risk_factors.dart';

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

  //--------------------------------------------------
  final ageController = TextEditingController();
  String _age = '';
  String _error = '';
  getage() {
    FinalScore.age = int.parse(_age);
  }

  //-------------snackbar for age==null---------
  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();
  _showSnackBar() {
    final _snackBar = new SnackBar(
      content: Text(
        _error,
        style: TextStyle(fontSize: 15),
      ),
      backgroundColor: Colors.deepOrange,
    );
    _scaffoldkey.currentState.showSnackBar(_snackBar);
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
  String complainSelected01;
  String complainSelected02;
  String complainSelected03;
  String complainSelected04;
  String complainSelected05;
  String complainSelected06;
  String complainSelected07;
  List<DropdownMenuItem<String>> menuitems = List();
  bool disabledropdown01 = true;
  bool disabledropdown02 = true;
  bool disabledropdown03 = true;
  bool disabledropdown04 = true;
  bool disabledropdown05 = true;
  bool disabledropdown06 = true;
  bool disabledropdown07 = true;

  final cardioRespiratory = {
    "1": ["hemoptysis", "hemoptysis"],
    "2": ["orthopnea", "orthopnea"],
    "3": ["PN dyspnea", "PN dyspnea"],
    "4": ["palpitation", "palpitation"],
    "5": ["chest pain", "chest pain"],
    "6": ["cough", "cough"],
    "7": ["dyspnea", "dyspnea"],
    "8": ["cyanosis", "cyanosis"],
    "9": ["other cardiac problems", "other cardiac problems"],
    "10": ["wheeze", "wheeze"],
    "11": ["other respiratory problems", "other respiratory problems"],
  };
  final gastroIntestinal = {
    "1": "abdominal pain",
    "2": "vomiting",
    "3": "constipation",
    "4": "bloody diarrhea",
    "5": "watery diarrhea",
    "6": "dysphagia",
    "7": "odynophagia",
    "8": "mucousy diarrhea",
    "9": "other git problems",
    "10": "abdominal distension",
    "11": "bleeding per rectum",
    "12": "nausea",
    "13": "hematemesis",
    "14": "malena",
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
    "1": "cognitive impairment",
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
    "13": "encorporesis",
    "14": "polyphagia",
    "15": "other psychological problems",
  };
  final musckuloskeletal = {
    "1": "generalized bone pain",
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
    "5": "back opening",
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
    "3": "generalized bone pain",
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
    "9": "generalized bone pain",
    "10": "joint pain",
    "11": "joint swelling",
    "12": "fracture",
    "13": "dislocation",
  };
  final lowerLimb = {
    "1": "bilateral leg edema",
    "2": "enlarged foot",
    "3": "generalized bone pain",
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
    "7": "somnolence",
    "8": "polydipsia",
    "9": "delayed puberty",
    "10": "bleeding",
    //"11": "bleeding",
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
    "2": "sore throat",
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
    "9": "acne",
    "10": "bruising",
    "11": "female hirsutism",
    "12": "other skin problems"
  };

  final gynecology = {
    "1": "amenorrhea",
    "2": "oligomenorrhea",
    "3": "decrease libido",
    "4": "menorrhagia",
    "5": "female infertility",
    "6": "female hirsutism",
    "7": "prolong pregnancy",
    "8": "postmenopausal bleeding",
    "9": "other gynecological and obstetrical problems",
    "10": "miscarriage",
  };

  final uroKidney = {
    "1": "incontinence",
    "2": "polyuria",
    "3": "abnormal urethral opening site",
    "4": "suprapubic pain",
    "5": "frequency",
    "6": "flank pain",
    "7": "retention",
    "8": "urgency",
    "9": "dysuria",
    "10": "hematuria",
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
    "12": "hematospermia",
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
    "17": "jaundice",
    "18": "other ophthalmological problems",
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
        child: Text(cardioRespiratory[key][0]),
        value: cardioRespiratory[key][1],
      ));
    }
  }

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

  List gender = ["Male", "Female"];
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
          style: _textStylePatient.copyWith(fontSize: 16),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final cardioRespiratory = {
      "1": [AppLocalizations.of(context).translate('hemoptysis'), 'hemoptysis'],
      "2": [AppLocalizations.of(context).translate('orthopnea'), 'orthopnea'],
      "3": [AppLocalizations.of(context).translate('PN dyspnea'), 'PN dyspnea'],
      "4": [
        AppLocalizations.of(context).translate('palpitation'),
        'palpitation'
      ],
      "5": [AppLocalizations.of(context).translate('chest pain'), 'chest pain'],
      "6": [AppLocalizations.of(context).translate('cough'), 'cough'],
      "7": [AppLocalizations.of(context).translate('sputum'), 'sputum'],
      "8": [AppLocalizations.of(context).translate('dyspnea'), 'dyspnea'],
      "9": [AppLocalizations.of(context).translate('cyanosis'), 'cyanosis'],
      "10": [
        AppLocalizations.of(context).translate('other cardiac problems'),
        'other cardiac problems'
      ],
      "11": [AppLocalizations.of(context).translate('wheeze'), 'wheeze'],
      "12": [
        AppLocalizations.of(context).translate('other respiratory problems'),
        'other respiratory problems'
      ]
    };
    final gastroIntestinal = {
      "1": [
        AppLocalizations.of(context).translate('abdominal pain'),
        'abdominal pain'
      ],
      "2": [AppLocalizations.of(context).translate('vomiting'), 'vomiting'],
      "3": [
        AppLocalizations.of(context).translate('constipation'),
        'constipation'
      ],
      "4": [
        AppLocalizations.of(context).translate('bloody diarrhea'),
        'bloody diarrhea'
      ],
      "5": [
        AppLocalizations.of(context).translate('watery diarrhea'),
        'watery diarrhea'
      ],
      "6": [AppLocalizations.of(context).translate('dysphagia'), 'dysphagia'],
      "7": [
        AppLocalizations.of(context).translate('odynophagia'),
        'odynophagia'
      ],
      "8": [
        AppLocalizations.of(context).translate('mucousy diarrhea'),
        'mucousy diarrhea'
      ],
      "9": [
        AppLocalizations.of(context).translate('other git problems'),
        'other git problems'
      ],
      "10": [
        AppLocalizations.of(context).translate('abdominal distension'),
        'abdominal distension'
      ],
      "11": [
        AppLocalizations.of(context).translate('bleeding per rectum'),
        'bleeding per rectum'
      ],
      "12": [AppLocalizations.of(context).translate('nausea'), 'nausea'],
      "13": [
        AppLocalizations.of(context).translate('hematemesis'),
        'hematemesis'
      ],
      "14": [AppLocalizations.of(context).translate('malena'), 'malena'],
      "15": [AppLocalizations.of(context).translate('tenesmus'), 'tenesmus'],
    };
    final peiranalAbdomen = {
      "1": [
        AppLocalizations.of(context).translate('perianal pain'),
        'perianal pain'
      ],
      "2": [
        AppLocalizations.of(context).translate('perianal discharge'),
        'perianal discharge'
      ],
      "3": [
        AppLocalizations.of(context).translate('anal incontinence'),
        'anal incontinence'
      ],
      "4": [
        AppLocalizations.of(context).translate('perianal itching'),
        'perianal itching'
      ],
      "5": [
        AppLocalizations.of(context).translate('abdominal wall swelling'),
        'abdominal wall swelling'
      ],
    };
    AppLocalizations.of(context).translate('');
    final neurology = {
      "1": [AppLocalizations.of(context).translate('coma'), 'coma'],
      "2": [AppLocalizations.of(context).translate('fit'), 'fit'],
      "3": [
        AppLocalizations.of(context).translate('abnormal movement'),
        'abnormal movement'
      ],
      "4": [AppLocalizations.of(context).translate('spasm'), 'spasm'],
      "5": [
        AppLocalizations.of(context).translate('memory loss'),
        'memory loss'
      ],
      "6": [AppLocalizations.of(context).translate('tremer'), 'tremer'],
      "7": [AppLocalizations.of(context).translate('confusion'), 'confusion'],
      "8": [AppLocalizations.of(context).translate('numbness'), 'numbness'],
      "9": [
        AppLocalizations.of(context).translate('slurred speech'),
        'slurred speech'
      ],
      "10": [AppLocalizations.of(context).translate('ataxia'), 'ataxia'],
      "11": [AppLocalizations.of(context).translate('weakness'), 'weakness'],
      "12": [
        AppLocalizations.of(context).translate('other neurological problems'),
        'other neurological problems'
      ],
      "13": [AppLocalizations.of(context).translate('syncope'), 'syncope'],
    };

    final psychology = {
      "1": [
        AppLocalizations.of(context).translate('cognitive impairment'),
        'cognitive impairment'
      ],
      "2": [
        AppLocalizations.of(context).translate('behavioral impairement'),
        'behavioral impairement'
      ],
      "3": [AppLocalizations.of(context).translate('depression'), 'depression'],
      "4": [
        AppLocalizations.of(context).translate('hallucination/delusion'),
        'hallucination/delusion'
      ],
      "5": [AppLocalizations.of(context).translate('phobia'), 'phobia'],
      "6": [AppLocalizations.of(context).translate('suicide'), 'suicide'],
      "7": [AppLocalizations.of(context).translate('obsession'), 'obsession'],
      "8": [
        AppLocalizations.of(context).translate('attention deficit'),
        'attention deficit'
      ],
      "9": [
        AppLocalizations.of(context).translate('hyperactivity'),
        'hyperactivity'
      ],
      "10": [AppLocalizations.of(context).translate('stress'), 'stress'],
      "11": [
        AppLocalizations.of(context).translate('psychological trauma'),
        'psychological trauma'
      ],
      "12": [AppLocalizations.of(context).translate('addiction'), 'addiction'],
      "13": [
        AppLocalizations.of(context).translate('encorporesis'),
        'encorporesis'
      ],
      //"14": AppLocalizations.of(context).translate('polyphagia'),==>better to see intrenist not psychiatrist
      "14": [
        AppLocalizations.of(context).translate('other psychological problems'),
        'other psychological problems'
      ],
    };
    final musckuloskeletal = {
      "1": [
        AppLocalizations.of(context).translate('generalized bone pain'),
        'generalized bone pain'
      ],
      "2": [AppLocalizations.of(context).translate('joint pain'), 'joint pain'],
      "3": [AppLocalizations.of(context).translate('deformity'), 'deformity'],
      "4": [
        AppLocalizations.of(context).translate('joint swelling'),
        'joint swelling'
      ],
      "5": [
        AppLocalizations.of(context).translate('limitation of movement'),
        'limitation of movement'
      ],
      "6": [AppLocalizations.of(context).translate('fracture'), 'fracture'],
      "7": [AppLocalizations.of(context).translate('limb pain'), 'limb pain'],
      "8": [
        AppLocalizations.of(context).translate('dislocation'),
        'dislocation'
      ],
      "9": [
        AppLocalizations.of(context).translate("other msk problems"),
        "other msk problems"
      ],
    };
    final headNeckBack = {
      "1": [AppLocalizations.of(context).translate('jaw pain'), 'jaw pain'],
      "2": [AppLocalizations.of(context).translate('neck pain'), 'neck pain'],
      "3": [
        AppLocalizations.of(context).translate('enlarged jaw'),
        'enlarged jaw'
      ],
      "4": [
        AppLocalizations.of(context).translate('neck swelling'),
        'neck swelling'
      ],
      "5": [
        AppLocalizations.of(context).translate('back opening'),
        'back opening'
      ],
      "6": [AppLocalizations.of(context).translate('back mass'), 'back mass'],
      "7": [AppLocalizations.of(context).translate('back pain'), 'back pain'],
      "8": [AppLocalizations.of(context).translate('headache'), 'headache'],
      "9": [AppLocalizations.of(context).translate('large head'), 'large head'],
      "10": [
        AppLocalizations.of(context).translate('abnormal head shape'),
        'abnormal head shape'
      ],
      "11": [
        AppLocalizations.of(context).translate('other skull problems'),
        'other skull problems'
      ],
    };
    final upperLimb = {
      "1": [
        AppLocalizations.of(context).translate('left arm pain'),
        'left arm pain'
      ],
      "2": [
        AppLocalizations.of(context).translate('left shoulder pain'),
        'left shoulder pain'
      ],
      "3": [
        AppLocalizations.of(context).translate('generalized bone pain'),
        'generalized bone pain'
      ],
      "4": [AppLocalizations.of(context).translate('joint pain'), 'joint pain'],
      "5": [AppLocalizations.of(context).translate('deformity'), 'deformity'],
      "6": [
        AppLocalizations.of(context).translate('joint swelling'),
        'joint swelling'
      ],
      "7": [
        AppLocalizations.of(context).translate('limitation of movement'),
        'limitation of movement'
      ],
      "8": [AppLocalizations.of(context).translate('fracture'), 'fracture'],
      "9": [AppLocalizations.of(context).translate('limb pain'), 'limb pain'],
      "10": [
        AppLocalizations.of(context).translate('dislocation'),
        'dislocation'
      ],
    };

    final hand = {
      "1": [
        AppLocalizations.of(context).translate('enlarged hand'),
        'enlarged hand'
      ],
      "2": [
        AppLocalizations.of(context).translate('extra digit'),
        'extra digit'
      ],
      "3": [
        AppLocalizations.of(context).translate('joined digit'),
        'joined digit'
      ],
      "4": [AppLocalizations.of(context).translate('loss digit'), 'loss digit'],
      "5": [
        AppLocalizations.of(context).translate('hand deformity'),
        'hand deformity'
      ],
      "6": [
        AppLocalizations.of(context).translate('other hand problems'),
        'other hand problems'
      ],
      "7": [
        AppLocalizations.of(context).translate('hand swelling'),
        'hand swelling'
      ],
      "8": [AppLocalizations.of(context).translate('hand lump'), 'hand lump'],
      "9": [
        AppLocalizations.of(context).translate('generalized bone pain'),
        'generalized bone pain'
      ],
      "10": [
        AppLocalizations.of(context).translate('joint pain'),
        'joint pain'
      ],
      "11": [
        AppLocalizations.of(context).translate('joint swelling'),
        'joint swelling'
      ],
      "12": [AppLocalizations.of(context).translate('fracture'), 'fracture'],
      "13": [
        AppLocalizations.of(context).translate('dislocation'),
        'dislocation'
      ],
    };
    final lowerLimb = {
      "1": [
        AppLocalizations.of(context).translate('bilateral leg edema'),
        'bilateral leg edema'
      ],
      "2": [
        AppLocalizations.of(context).translate('enlarged foot'),
        'enlarged foot'
      ],
      "3": [
        AppLocalizations.of(context).translate('generalized bone pain'),
        'generalized bone pain'
      ],
      "4": [AppLocalizations.of(context).translate('joint pain'), 'joint pain'],
      "5": [
        AppLocalizations.of(context).translate('unilateral leg swelling'),
        'unilateral leg swelling'
      ],
      "6": [
        AppLocalizations.of(context).translate('unilateral leg pain'),
        'unilateral leg pain'
      ],
      "7": [AppLocalizations.of(context).translate('deformity'), 'deformity'],
      "8": [
        AppLocalizations.of(context).translate('joint swelling'),
        'joint swelling'
      ],
      "9": [
        AppLocalizations.of(context).translate('limitation of movement'),
        'limitation of movement'
      ],
      "10": [
        AppLocalizations.of(context).translate('leg pain during walking'),
        'leg pain during walking'
      ],
      "11": [
        AppLocalizations.of(context).translate('foot ulcer'),
        'foot ulcer'
      ],
      "12": [AppLocalizations.of(context).translate('fracture'), 'fracture'],
      "13": [AppLocalizations.of(context).translate('limb pain'), 'limb pain'],
      "14": [
        AppLocalizations.of(context).translate('dislocation'),
        'dislocation'
      ],
    };

    final others = {
      "1": [AppLocalizations.of(context).translate('sweating'), 'sweating'],
      "2": [AppLocalizations.of(context).translate('fever'), 'fever'],
      "3": [
        AppLocalizations.of(context).translate('heat sensation'),
        'heat sensation'
      ],
      "4": [AppLocalizations.of(context).translate('ulcer'), 'ulcer'],
      "5": [AppLocalizations.of(context).translate('insomnia'), 'insomnia'],
      "6": [
        AppLocalizations.of(context).translate('cold sensation'),
        'cold sensation'
      ],
      "7": [AppLocalizations.of(context).translate('somnolence'), 'somnolence'],
      "8": [AppLocalizations.of(context).translate('polydipsia'), 'polydipsia'],
      "9": [
        AppLocalizations.of(context).translate('delayed puberty'),
        'delayed puberty'
      ],
      "10": [AppLocalizations.of(context).translate('bleeding'), 'bleeding'],
      "11": [AppLocalizations.of(context).translate('fatigue'), 'fatigue'],
      "12": [AppLocalizations.of(context).translate('pallor'), 'pallor'],
      "13": [AppLocalizations.of(context).translate('lump'), 'lump'],
      "14": [
        AppLocalizations.of(context).translate('other health problems'),
        'other health problems'
      ],
      "15": [AppLocalizations.of(context).translate('malaise'), 'malaise'],
      "16": [
        AppLocalizations.of(context).translate('short stature'),
        'short stature'
      ],
      "17": [
        AppLocalizations.of(context).translate('taste loss'),
        'taste loss'
      ],
    };
    final bpPrLab = {
      "1": AppLocalizations.of(context).translate(''),
      "2": AppLocalizations.of(context).translate(''),
      "3": AppLocalizations.of(context).translate(''),
      "4": AppLocalizations.of(context).translate(''),
      "5": AppLocalizations.of(context).translate(''),
      "6": AppLocalizations.of(context).translate(''),
      "7": AppLocalizations.of(context).translate(''),
      "8": AppLocalizations.of(context).translate(''),
      "9": AppLocalizations.of(context).translate(''),
      "10": AppLocalizations.of(context).translate(''),
      "11": AppLocalizations.of(context).translate(''),
      "12": AppLocalizations.of(context).translate(''),
    };

    final injuriesSuicideIntoxicationBurn = {
      "1": [AppLocalizations.of(context).translate('FFH'), 'FFH'],
      "2": [AppLocalizations.of(context).translate('RTA'), 'RTA'],
      "3": [AppLocalizations.of(context).translate('stab'), 'stab'],
      "4": [AppLocalizations.of(context).translate('shot'), 'shot'],
      "5": [
        AppLocalizations.of(context).translate('other injuries'),
        'other injuries'
      ],
      "6": [AppLocalizations.of(context).translate('suicide'), 'suicide'],
      "7": [
        AppLocalizations.of(context).translate('intoxication'),
        'intoxication'
      ],
      "8": [AppLocalizations.of(context).translate('burn'), 'burn'],
      "9": [AppLocalizations.of(context).translate('msk injury'), 'msk injury'],
      "10": [
        AppLocalizations.of(context).translate('sport injury'),
        'sport injury'
      ],
    };

    final mouth = {
      "1": [
        AppLocalizations.of(context).translate('mouth deviation'),
        'mouth deviation'
      ],
      "2": [AppLocalizations.of(context).translate('cleft lip'), 'cleft lip'],
      "3": [
        AppLocalizations.of(context).translate('cleft palate'),
        'cleft palate'
      ],
      "4": [
        AppLocalizations.of(context).translate('disease of the mouth'),
        'disease of the mouth'
      ],
    };
    final appetite = {
      "1": [AppLocalizations.of(context).translate('polyphagia'), 'polyphagia'],
      "2": [
        AppLocalizations.of(context).translate('weight gain'),
        'weight gain'
      ],
      "3": [
        AppLocalizations.of(context).translate('weight loss'),
        'weight loss'
      ],
      "4": [AppLocalizations.of(context).translate('anorexia'), 'anorexia'],
    };

    final entThroat = {
      "1": [AppLocalizations.of(context).translate('hoarseness'), 'hoarseness'],
      "2": [
        AppLocalizations.of(context).translate('sore throat'),
        'sore throat'
      ],
      "3": [
        AppLocalizations.of(context).translate('other ent problems'),
        'other ent problems'
      ],
    };
    final entNose = {
      "1": [
        AppLocalizations.of(context).translate('nasal discharge'),
        'nasal discharge'
      ],
      "2": [
        AppLocalizations.of(context).translate('nasal bleeding'),
        'nasal bleeding'
      ],
      "3": [
        AppLocalizations.of(context).translate('nasal obstruction'),
        'nasal obstruction'
      ],
      "4": [AppLocalizations.of(context).translate('nasal pain'), 'nasal pain'],
      "5": [AppLocalizations.of(context).translate('nasal mass'), 'nasal mass'],
      "6": [
        AppLocalizations.of(context).translate('nasal deformity'),
        'nasal deformity'
      ],
      "7": [AppLocalizations.of(context).translate('sneezing'), 'sneezing'],
      "8": [
        AppLocalizations.of(context).translate('nasal itching'),
        'nasal itching'
      ],
      "9": [AppLocalizations.of(context).translate('anosmia'), 'anosmia'],
      "10": [
        AppLocalizations.of(context).translate('enlarged nose'),
        'enlarged nose'
      ],
      "11": [
        AppLocalizations.of(context).translate('other ent problems'),
        'other ent problems'
      ],
    };

    final entEar = {
      "1": [AppLocalizations.of(context).translate('deafness'), 'deafness'],
      "2": [AppLocalizations.of(context).translate('vertigo'), 'vertigo'],
      "3": [AppLocalizations.of(context).translate('tinnitus'), 'tinnitus'],
      "4": [
        AppLocalizations.of(context).translate('ear discharge'),
        'ear discharge'
      ],
      "5": [
        AppLocalizations.of(context).translate('ear redness'),
        'ear redness'
      ],
      "6": [AppLocalizations.of(context).translate('ear pain'), 'ear pain'],
      "7": [
        AppLocalizations.of(context).translate('other ent problems'),
        'other ent problems'
      ],
    };

    final dermatology = {
      "1": [AppLocalizations.of(context).translate('dry skin'), 'dry skin'],
      "2": [AppLocalizations.of(context).translate('dry hair'), 'dry hair'],
      "3": [AppLocalizations.of(context).translate('skin rash'), 'skin rash'],
      "4": [
        AppLocalizations.of(context).translate('hair problems'),
        'hair problems'
      ],
      "5": [
        AppLocalizations.of(context).translate('skin redness'),
        'skin redness'
      ],
      "6": [
        AppLocalizations.of(context).translate('skin lesion'),
        'skin lesion'
      ],
      "7": [
        AppLocalizations.of(context).translate('skin appendage'),
        'skin appendage'
      ],
      "8": [
        AppLocalizations.of(context).translate('skin itching'),
        'skin itching'
      ],
      "9": [AppLocalizations.of(context).translate('acne'), 'acne'],
      "10": [AppLocalizations.of(context).translate('bruising'), 'bruising'],
      "11": [
        AppLocalizations.of(context).translate('female hirsutism'),
        'female hirsutism'
      ],
    };

    final gynecology = {
      "1": [AppLocalizations.of(context).translate('amenorrhea'), 'amenorrhea'],
      "2": [
        AppLocalizations.of(context).translate('oligomenorrhea'),
        'oligomenorrhea'
      ],
      "3": [
        AppLocalizations.of(context).translate('decrease libido'),
        'decrease libido'
      ],
      "4": [
        AppLocalizations.of(context).translate('menorrhagia'),
        'menorrhagia'
      ],
      "5": [
        AppLocalizations.of(context).translate('female infertility'),
        'female infertility'
      ],
      "6": [
        AppLocalizations.of(context).translate('female hirsutism'),
        'female hirsutism'
      ],
      "7": [
        AppLocalizations.of(context).translate('prolong pregnancy'),
        'prolong pregnancy'
      ],
      "8": [
        AppLocalizations.of(context).translate('postmenopausal bleeding'),
        'postmenopausal bleeding'
      ],
      "9": [
        AppLocalizations.of(context)
            .translate('other gynecological and obstetrical problems'),
        'other gynecological and obstetrical problems'
      ],
      "10": [
        AppLocalizations.of(context).translate('miscarriage'),
        'miscarriage'
      ],
    };

    final uroKidney = {
      "1": [
        AppLocalizations.of(context).translate('incontinence'),
        'incontinence'
      ],
      "2": [AppLocalizations.of(context).translate('polyuria'), 'polyuria'],
      "3": [
        AppLocalizations.of(context)
            .translate('abnormal urethral opening site'),
        'abnormal urethral opening site'
      ],
      "4": [
        AppLocalizations.of(context).translate('suprapubic pain'),
        'suprapubic pain'
      ],
      "5": [AppLocalizations.of(context).translate('frequency'), 'frequency'],
      "6": [AppLocalizations.of(context).translate('flank pain'), 'flank pain'],
      "7": [AppLocalizations.of(context).translate('retention'), 'retention'],
      "8": [AppLocalizations.of(context).translate('urgency'), 'urgency'],
      "9": [AppLocalizations.of(context).translate('dysuria'), 'dysuria'],
      "10": [AppLocalizations.of(context).translate('hematuria'), 'hematuria'],
      "11": [
        AppLocalizations.of(context).translate('other urological problems'),
        'other urological problems'
      ],
      "12": [AppLocalizations.of(context).translate('nocturia'), 'nocturia'],
    };

    final maleGenital = {
      "1": [
        AppLocalizations.of(context).translate('decrease libido'),
        'decrease libido'
      ],
      "2": [
        AppLocalizations.of(context).translate('delayed puberty'),
        'delayed puberty'
      ],
      "3": [
        AppLocalizations.of(context).translate('male infertility'),
        'male infertility'
      ],
      "4": [
        AppLocalizations.of(context).translate('scrotal swelling'),
        'scrotal swelling'
      ],
      "5": [
        AppLocalizations.of(context).translate('empty scrotum'),
        'empty scrotum'
      ],
      "6": [
        AppLocalizations.of(context).translate('abnormal penile size'),
        'abnormal penile size'
      ],
      "7": [
        AppLocalizations.of(context).translate('penile mass'),
        'penile mass'
      ],
      "8": [
        AppLocalizations.of(context).translate('other penile problems'),
        'other penile problems'
      ],
      "9": [
        AppLocalizations.of(context).translate('scrotal pain'),
        'scrotal pain'
      ],
      "10": [AppLocalizations.of(context).translate('priapism'), 'priapism'],
      "11": [AppLocalizations.of(context).translate('priapism'), 'priapism'],
      "12": [
        AppLocalizations.of(context).translate('hematospermia'),
        'hematospermia'
      ],
    };

    final ophthalmology = {
      "1": [AppLocalizations.of(context).translate('open eye'), 'open eye'],
      "2": [AppLocalizations.of(context).translate('blindness'), 'blindness'],
      "3": [
        AppLocalizations.of(context).translate('photophobia'),
        'photophobia'
      ],
      "4": [
        AppLocalizations.of(context).translate('double vision'),
        'double vision'
      ],
      "5": [AppLocalizations.of(context).translate('lid drop'), 'lid drop'],
      "6": [
        AppLocalizations.of(context).translate('blurred vision'),
        'blurred vision'
      ],
      "7": [AppLocalizations.of(context).translate('squint'), 'squint'],
      "8": [
        AppLocalizations.of(context).translate('eye redness'),
        'eye redness'
      ],
      "9": [AppLocalizations.of(context).translate('eye pain'), 'eye pain'],
      "10": [
        AppLocalizations.of(context).translate('eye discharge'),
        'eye discharge'
      ],
      "11": [
        AppLocalizations.of(context).translate('eye itching'),
        'eye itching'
      ],
      "12": [
        AppLocalizations.of(context).translate('eye pigmentation'),
        'eye pigmentation'
      ],
      "13": [
        AppLocalizations.of(context).translate('periorbital edema'),
        'periorbital edema'
      ],
      "14": [
        AppLocalizations.of(context).translate('eyelid deformity'),
        'eyelid deformity'
      ],
      "15": [AppLocalizations.of(context).translate('dry eye'), 'dry eye'],
      "16": [
        AppLocalizations.of(context).translate('ophthalmoplegia'),
        'ophthalmoplegia'
      ],
      "17": [
        AppLocalizations.of(context)
            .translate('other ophthalmological problems'),
        'other ophthalmological problems'
      ],
    };
    final breast = {
      "1": [
        AppLocalizations.of(context).translate('gynecomastia'),
        'gynecomastia'
      ],
      "2": [
        AppLocalizations.of(context).translate('galactorrhea'),
        'galactorrhea'
      ],
      "3": [
        AppLocalizations.of(context).translate('breast mass'),
        'breast mass'
      ],
      "4": [
        AppLocalizations.of(context).translate('breast pain'),
        'breast pain'
      ],
      "5": [
        AppLocalizations.of(context).translate('breast discharge'),
        'breast discharge'
      ],
      "6": [
        AppLocalizations.of(context).translate('breast lump'),
        'breast lump'
      ],
      "7": [
        AppLocalizations.of(context).translate('breast skin lesion'),
        'breast skin lesion'
      ],
      "8": [
        AppLocalizations.of(context).translate('other breast  problems'),
        'other breast  problems'
      ],
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
        print(_value);
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
      key: _scaffoldkey,
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        title: Text(
          AppLocalizations.of(context).translate('patient_complain'),
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
                      decoration: InputDecoration(
                        hintText: AppLocalizations.of(context).translate('age'),
                        prefixIcon: Icon(
                          Icons.account_box,
                          //changed beacause its not defined here , you can return it back
                          //Icons.person_search,
                          color: Colors.deepOrange,
                        ),
                        filled: true,
                      )),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 40, vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        addRadioButton(
                            0, AppLocalizations.of(context).translate('male')),
                        addRadioButton(1,
                            AppLocalizations.of(context).translate('female')),
                      ],
                    ),
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
                          AppLocalizations.of(context)
                              .translate('main_complain'),
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
                          child: Text(AppLocalizations.of(context)
                              .translate('heart_lung')),
                        ),
                        DropdownMenuItem<String>(
                          value: "gastroIntestinal",
                          child: Text(
                              AppLocalizations.of(context).translate('git')),
                        ),
                        DropdownMenuItem<String>(
                          value: "peiranalAbdomen",
                          child: Text(AppLocalizations.of(context)
                              .translate('perianal_abdomen')),
                        ),
                        DropdownMenuItem<String>(
                          value: "neurology",
                          child: Text(AppLocalizations.of(context)
                              .translate('brain_neuron')),
                        ),
                        DropdownMenuItem<String>(
                          value: "bpPrLab",
                          child: Text(AppLocalizations.of(context)
                              .translate('bpPrLab')),
                        ),
                        DropdownMenuItem<String>(
                          value: "musckuloskeletal",
                          child: Text(AppLocalizations.of(context)
                              .translate('skeleton_muscles')),
                        ),
                        DropdownMenuItem<String>(
                          value: "headNeckBack",
                          child: Text(AppLocalizations.of(context)
                              .translate('head_neck_back')),
                        ),
                        DropdownMenuItem<String>(
                          value: "upperLimb",
                          child: Text(AppLocalizations.of(context)
                              .translate('upper_limb')),
                        ),
                        DropdownMenuItem<String>(
                          value: "lowerLimb",
                          child: Text(AppLocalizations.of(context)
                              .translate('lower_limb')),
                        ),
                        DropdownMenuItem<String>(
                          value: "hand",
                          child: Text(
                              AppLocalizations.of(context).translate('Hand')),
                        ),
                        DropdownMenuItem<String>(
                          value: "mouth",
                          child: Text(
                              AppLocalizations.of(context).translate('mouth')),
                        ),
                        DropdownMenuItem<String>(
                          value: "appetite",
                          child: Text(AppLocalizations.of(context)
                              .translate('appetite')),
                        ),
                        DropdownMenuItem<String>(
                          value: "entThroat",
                          child: Text(
                              AppLocalizations.of(context).translate('throat')),
                        ),
                        DropdownMenuItem<String>(
                          value: "entNose",
                          child: Text(
                              AppLocalizations.of(context).translate('nose')),
                        ),
                        DropdownMenuItem<String>(
                          value: "entEar",
                          child: Text(
                              AppLocalizations.of(context).translate('ear')),
                        ),
                        DropdownMenuItem<String>(
                          value: "ophthalmology",
                          child: Text(
                              AppLocalizations.of(context).translate('eye')),
                        ),
                        DropdownMenuItem<String>(
                          value: "dermatology",
                          child: Text(
                              AppLocalizations.of(context).translate('skin')),
                        ),
                        DropdownMenuItem<String>(
                          value: "uroKidney",
                          child: Text(
                              AppLocalizations.of(context).translate('uro')),
                        ),
                        DropdownMenuItem<String>(
                          value: "maleGenital",
                          child: Text(AppLocalizations.of(context)
                              .translate('male_genital')),
                        ),
                        DropdownMenuItem<String>(
                          value: "gynecology",
                          child: Text(AppLocalizations.of(context)
                              .translate('gynecology')),
                        ),
                        DropdownMenuItem<String>(
                          value: "breast",
                          child: Text(
                              AppLocalizations.of(context).translate('Breast')),
                        ),
                        DropdownMenuItem<String>(
                          value: "psychology",
                          child: Text(AppLocalizations.of(context)
                              .translate('psychology')),
                        ),
                        DropdownMenuItem<String>(
                          value: "injuriesSuicideIntoxicationBurn",
                          child: Text(AppLocalizations.of(context)
                              .translate('injuriesSuicideIntoxicationBurn')),
                        ),
                        DropdownMenuItem<String>(
                          value: "others",
                          child: Text(AppLocalizations.of(context)
                              .translate('other_symptoms')),
                        ),
                      ],
                      //if one choose a region then reselect another one ---> there will be an error which
                      // was fixed by removing the arguement value
                      //value: regionSelected01,
                      onChanged: (_value) => selected01(_value),
                      hint: FittedBox(
                        fit: BoxFit.fitWidth,
                        child: Text(AppLocalizations.of(context)
                            .translate('complain_area')),
                      ),
                    ),
                    DropdownButton<String>(
                      isExpanded: true,
                      items: menuitems,
                      // the same reason above
                      //value: complainSelected01,
                      onChanged: disabledropdown01
                          ? null
                          : (value) => secondselected(value),
                      hint: Text(AppLocalizations.of(context)
                          .translate('choose_complain')),
                      disabledHint: Text(AppLocalizations.of(context)
                          .translate('first_choose_complain')),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        FittedBox(
                          fit: BoxFit.fitWidth,
                          child: Text(
                            AppLocalizations.of(context)
                                .translate('other_complain'),
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
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
                            AppLocalizations.of(context)
                                .translate('add_complains'),
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
                            child: Text(AppLocalizations.of(context)
                                .translate('heart_lung')),
                          ),
                          DropdownMenuItem<String>(
                            value: "gastroIntestinal",
                            child: Text(
                                AppLocalizations.of(context).translate('git')),
                          ),
                          DropdownMenuItem<String>(
                            value: "peiranalAbdomen",
                            child: Text(AppLocalizations.of(context)
                                .translate('perianal_abdomen')),
                          ),
                          DropdownMenuItem<String>(
                            value: "neurology",
                            child: Text(AppLocalizations.of(context)
                                .translate('brain_neuron')),
                          ),
                          DropdownMenuItem<String>(
                            value: "bpPrLab",
                            child: Text(AppLocalizations.of(context)
                                .translate('bpPrLab')),
                          ),
                          DropdownMenuItem<String>(
                            value: "musckuloskeletal",
                            child: Text(AppLocalizations.of(context)
                                .translate('skeleton_muscles')),
                          ),
                          DropdownMenuItem<String>(
                            value: "headNeckBack",
                            child: Text(AppLocalizations.of(context)
                                .translate('head_neck_back')),
                          ),
                          DropdownMenuItem<String>(
                            value: "upperLimb",
                            child: Text(AppLocalizations.of(context)
                                .translate('upper_limb')),
                          ),
                          DropdownMenuItem<String>(
                            value: "lowerLimb",
                            child: Text(AppLocalizations.of(context)
                                .translate('lower_limb')),
                          ),
                          DropdownMenuItem<String>(
                            value: "hand",
                            child: Text(
                                AppLocalizations.of(context).translate('Hand')),
                          ),
                          DropdownMenuItem<String>(
                            value: "mouth",
                            child: Text(AppLocalizations.of(context)
                                .translate('mouth')),
                          ),
                          DropdownMenuItem<String>(
                            value: "appetite",
                            child: Text(AppLocalizations.of(context)
                                .translate('appetite')),
                          ),
                          DropdownMenuItem<String>(
                            value: "entThroat",
                            child: Text(AppLocalizations.of(context)
                                .translate('throat')),
                          ),
                          DropdownMenuItem<String>(
                            value: "entNose",
                            child: Text(
                                AppLocalizations.of(context).translate('nose')),
                          ),
                          DropdownMenuItem<String>(
                            value: "entEar",
                            child: Text(
                                AppLocalizations.of(context).translate('ear')),
                          ),
                          DropdownMenuItem<String>(
                            value: "ophthalmology",
                            child: Text(
                                AppLocalizations.of(context).translate('eye')),
                          ),
                          DropdownMenuItem<String>(
                            value: "dermatology",
                            child: Text(
                                AppLocalizations.of(context).translate('skin')),
                          ),
                          DropdownMenuItem<String>(
                            value: "uroKidney",
                            child: Text(
                                AppLocalizations.of(context).translate('uro')),
                          ),
                          DropdownMenuItem<String>(
                            value: "maleGenital",
                            child: Text(AppLocalizations.of(context)
                                .translate('male_genital')),
                          ),
                          DropdownMenuItem<String>(
                            value: "gynecology",
                            child: Text(AppLocalizations.of(context)
                                .translate('gynecology')),
                          ),
                          DropdownMenuItem<String>(
                            value: "breast",
                            child: Text(AppLocalizations.of(context)
                                .translate('Breast')),
                          ),
                          DropdownMenuItem<String>(
                            value: "psychology",
                            child: Text(AppLocalizations.of(context)
                                .translate('psychology')),
                          ),
                          DropdownMenuItem<String>(
                            value: "injuriesSuicideIntoxicationBurn",
                            child: Text(AppLocalizations.of(context)
                                .translate('injuriesSuicideIntoxicationBurn')),
                          ),
                          DropdownMenuItem<String>(
                            value: "others",
                            child: Text(AppLocalizations.of(context)
                                .translate('other_symptoms')),
                          ),
                        ],
                        //value: regionSelected02,
                        onChanged: (_value) => selected02(_value),
                        hint: FittedBox(
                          fit: BoxFit.fitWidth,
                          child: Text(AppLocalizations.of(context)
                              .translate('complain_area')),
                        ),
                      ),
                      DropdownButton<String>(
                        isExpanded: true,
                        items: menuitems,
                        onChanged: disabledropdown02
                            ? null
                            : (value) => secondselected2(value),
                        hint: Text(AppLocalizations.of(context)
                            .translate('choose_complain')),
                        disabledHint: Text(AppLocalizations.of(context)
                            .translate('first_choose_complain')),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          FittedBox(
                            fit: BoxFit.fitWidth,
                            child: Text(
                              AppLocalizations.of(context)
                                  .translate('other_complain'),
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
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
                            AppLocalizations.of(context)
                                .translate('add_complains'),
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
                            child: Text(AppLocalizations.of(context)
                                .translate('heart_lung')),
                          ),
                          DropdownMenuItem<String>(
                            value: "gastroIntestinal",
                            child: Text(
                                AppLocalizations.of(context).translate('git')),
                          ),
                          DropdownMenuItem<String>(
                            value: "peiranalAbdomen",
                            child: Text(AppLocalizations.of(context)
                                .translate('perianal_abdomen')),
                          ),
                          DropdownMenuItem<String>(
                            value: "neurology",
                            child: Text(AppLocalizations.of(context)
                                .translate('brain_neuron')),
                          ),
                          DropdownMenuItem<String>(
                            value: "bpPrLab",
                            child: Text(AppLocalizations.of(context)
                                .translate('bpPrLab')),
                          ),
                          DropdownMenuItem<String>(
                            value: "musckuloskeletal",
                            child: Text(AppLocalizations.of(context)
                                .translate('skeleton_muscles')),
                          ),
                          DropdownMenuItem<String>(
                            value: "headNeckBack",
                            child: Text(AppLocalizations.of(context)
                                .translate('head_neck_back')),
                          ),
                          DropdownMenuItem<String>(
                            value: "upperLimb",
                            child: Text(AppLocalizations.of(context)
                                .translate('upper_limb')),
                          ),
                          DropdownMenuItem<String>(
                            value: "lowerLimb",
                            child: Text(AppLocalizations.of(context)
                                .translate('lower_limb')),
                          ),
                          DropdownMenuItem<String>(
                            value: "hand",
                            child: Text(
                                AppLocalizations.of(context).translate('Hand')),
                          ),
                          DropdownMenuItem<String>(
                            value: "mouth",
                            child: Text(AppLocalizations.of(context)
                                .translate('mouth')),
                          ),
                          DropdownMenuItem<String>(
                            value: "appetite",
                            child: Text(AppLocalizations.of(context)
                                .translate('appetite')),
                          ),
                          DropdownMenuItem<String>(
                            value: "entThroat",
                            child: Text(AppLocalizations.of(context)
                                .translate('throat')),
                          ),
                          DropdownMenuItem<String>(
                            value: "entNose",
                            child: Text(
                                AppLocalizations.of(context).translate('nose')),
                          ),
                          DropdownMenuItem<String>(
                            value: "entEar",
                            child: Text(
                                AppLocalizations.of(context).translate('ear')),
                          ),
                          DropdownMenuItem<String>(
                            value: "ophthalmology",
                            child: Text(
                                AppLocalizations.of(context).translate('eye')),
                          ),
                          DropdownMenuItem<String>(
                            value: "dermatology",
                            child: Text(
                                AppLocalizations.of(context).translate('skin')),
                          ),
                          DropdownMenuItem<String>(
                            value: "uroKidney",
                            child: Text(
                                AppLocalizations.of(context).translate('uro')),
                          ),
                          DropdownMenuItem<String>(
                            value: "maleGenital",
                            child: Text(AppLocalizations.of(context)
                                .translate('male_genital')),
                          ),
                          DropdownMenuItem<String>(
                            value: "gynecology",
                            child: Text(AppLocalizations.of(context)
                                .translate('gynecology')),
                          ),
                          DropdownMenuItem<String>(
                            value: "breast",
                            child: Text(AppLocalizations.of(context)
                                .translate('Breast')),
                          ),
                          DropdownMenuItem<String>(
                            value: "psychology",
                            child: Text(AppLocalizations.of(context)
                                .translate('psychology')),
                          ),
                          DropdownMenuItem<String>(
                            value: "injuriesSuicideIntoxicationBurn",
                            child: Text(AppLocalizations.of(context)
                                .translate('injuriesSuicideIntoxicationBurn')),
                          ),
                          DropdownMenuItem<String>(
                            value: "others",
                            child: Text(AppLocalizations.of(context)
                                .translate('other_symptoms')),
                          ),
                        ],
                        //value: regionSelected03,
                        onChanged: (_value) => selected03(_value),
                        hint: FittedBox(
                          fit: BoxFit.fitWidth,
                          child: Text(AppLocalizations.of(context)
                              .translate('complain_area')),
                        ),
                      ),
                      DropdownButton<String>(
                        isExpanded: true,
                        items: menuitems,
                        onChanged: disabledropdown03
                            ? null
                            : (value) => secondselected3(value),
                        hint: Text(AppLocalizations.of(context)
                            .translate('choose_complain')),
                        disabledHint: Text(AppLocalizations.of(context)
                            .translate('first_choose_complain')),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          FittedBox(
                            fit: BoxFit.fitWidth,
                            child: Text(
                              AppLocalizations.of(context)
                                  .translate('other_complain'),
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
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
            SizedBox(height: 20),
            Visibility(
              visible: _visibile03,
              child: Container(
                decoration: boxDecorationPatient,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Center(
                        child: Container(
                          child: Text(
                            AppLocalizations.of(context)
                                .translate('add_complains'),
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
                            child: Text(AppLocalizations.of(context)
                                .translate('heart_lung')),
                          ),
                          DropdownMenuItem<String>(
                            value: "gastroIntestinal",
                            child: Text(
                                AppLocalizations.of(context).translate('git')),
                          ),
                          DropdownMenuItem<String>(
                            value: "peiranalAbdomen",
                            child: Text(AppLocalizations.of(context)
                                .translate('perianal_abdomen')),
                          ),
                          DropdownMenuItem<String>(
                            value: "neurology",
                            child: Text(AppLocalizations.of(context)
                                .translate('brain_neuron')),
                          ),
                          DropdownMenuItem<String>(
                            value: "bpPrLab",
                            child: Text(AppLocalizations.of(context)
                                .translate('bpPrLab')),
                          ),
                          DropdownMenuItem<String>(
                            value: "musckuloskeletal",
                            child: Text(AppLocalizations.of(context)
                                .translate('skeleton_muscles')),
                          ),
                          DropdownMenuItem<String>(
                            value: "headNeckBack",
                            child: Text(AppLocalizations.of(context)
                                .translate('head_neck_back')),
                          ),
                          DropdownMenuItem<String>(
                            value: "upperLimb",
                            child: Text(AppLocalizations.of(context)
                                .translate('upper_limb')),
                          ),
                          DropdownMenuItem<String>(
                            value: "lowerLimb",
                            child: Text(AppLocalizations.of(context)
                                .translate('lower_limb')),
                          ),
                          DropdownMenuItem<String>(
                            value: "hand",
                            child: Text(
                                AppLocalizations.of(context).translate('Hand')),
                          ),
                          DropdownMenuItem<String>(
                            value: "mouth",
                            child: Text(AppLocalizations.of(context)
                                .translate('mouth')),
                          ),
                          DropdownMenuItem<String>(
                            value: "appetite",
                            child: Text(AppLocalizations.of(context)
                                .translate('appetite')),
                          ),
                          DropdownMenuItem<String>(
                            value: "entThroat",
                            child: Text(AppLocalizations.of(context)
                                .translate('throat')),
                          ),
                          DropdownMenuItem<String>(
                            value: "entNose",
                            child: Text(
                                AppLocalizations.of(context).translate('nose')),
                          ),
                          DropdownMenuItem<String>(
                            value: "entEar",
                            child: Text(
                                AppLocalizations.of(context).translate('ear')),
                          ),
                          DropdownMenuItem<String>(
                            value: "ophthalmology",
                            child: Text(
                                AppLocalizations.of(context).translate('eye')),
                          ),
                          DropdownMenuItem<String>(
                            value: "dermatology",
                            child: Text(
                                AppLocalizations.of(context).translate('skin')),
                          ),
                          DropdownMenuItem<String>(
                            value: "uroKidney",
                            child: Text(
                                AppLocalizations.of(context).translate('uro')),
                          ),
                          DropdownMenuItem<String>(
                            value: "maleGenital",
                            child: Text(AppLocalizations.of(context)
                                .translate('male_genital')),
                          ),
                          DropdownMenuItem<String>(
                            value: "gynecology",
                            child: Text(AppLocalizations.of(context)
                                .translate('gynecology')),
                          ),
                          DropdownMenuItem<String>(
                            value: "breast",
                            child: Text(AppLocalizations.of(context)
                                .translate('Breast')),
                          ),
                          DropdownMenuItem<String>(
                            value: "psychology",
                            child: Text(AppLocalizations.of(context)
                                .translate('psychology')),
                          ),
                          DropdownMenuItem<String>(
                            value: "injuriesSuicideIntoxicationBurn",
                            child: Text(AppLocalizations.of(context)
                                .translate('injuriesSuicideIntoxicationBurn')),
                          ),
                          DropdownMenuItem<String>(
                            value: "others",
                            child: Text(AppLocalizations.of(context)
                                .translate('other_symptoms')),
                          ),
                        ],
                        //value: regionSelected04,
                        onChanged: (_value) => selected04(_value),
                        hint: FittedBox(
                          fit: BoxFit.fitWidth,
                          child: Text(AppLocalizations.of(context)
                              .translate('complain_area')),
                        ),
                      ),
                      DropdownButton<String>(
                        isExpanded: true,
                        items: menuitems,
                        onChanged: disabledropdown04
                            ? null
                            : (value) => secondselected4(value),
                        hint: Text(AppLocalizations.of(context)
                            .translate('choose_complain')),
                        disabledHint: Text(AppLocalizations.of(context)
                            .translate('first_choose_complain')),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          FittedBox(
                            fit: BoxFit.fitWidth,
                            child: Text(
                              AppLocalizations.of(context)
                                  .translate('other_complain'),
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Switch(
                              value: _switch04,
                              activeColor: Colors.deepOrange,
                              onChanged: (bool s) {
                                setState(() {
                                  _switch04 = s;
                                  _visibile04 = !_visibile04;
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
              visible: _visibile04,
              child: Container(
                decoration: boxDecorationPatient,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Center(
                        child: Container(
                          child: Text(
                            AppLocalizations.of(context)
                                .translate('add_complains'),
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
                            child: Text(AppLocalizations.of(context)
                                .translate('heart_lung')),
                          ),
                          DropdownMenuItem<String>(
                            value: "gastroIntestinal",
                            child: Text(
                                AppLocalizations.of(context).translate('git')),
                          ),
                          DropdownMenuItem<String>(
                            value: "peiranalAbdomen",
                            child: Text(AppLocalizations.of(context)
                                .translate('perianal_abdomen')),
                          ),
                          DropdownMenuItem<String>(
                            value: "neurology",
                            child: Text(AppLocalizations.of(context)
                                .translate('brain_neuron')),
                          ),
                          DropdownMenuItem<String>(
                            value: "bpPrLab",
                            child: Text(AppLocalizations.of(context)
                                .translate('bpPrLab')),
                          ),
                          DropdownMenuItem<String>(
                            value: "musckuloskeletal",
                            child: Text(AppLocalizations.of(context)
                                .translate('skeleton_muscles')),
                          ),
                          DropdownMenuItem<String>(
                            value: "headNeckBack",
                            child: Text(AppLocalizations.of(context)
                                .translate('head_neck_back')),
                          ),
                          DropdownMenuItem<String>(
                            value: "upperLimb",
                            child: Text(AppLocalizations.of(context)
                                .translate('upper_limb')),
                          ),
                          DropdownMenuItem<String>(
                            value: "lowerLimb",
                            child: Text(AppLocalizations.of(context)
                                .translate('lower_limb')),
                          ),
                          DropdownMenuItem<String>(
                            value: "hand",
                            child: Text(
                                AppLocalizations.of(context).translate('Hand')),
                          ),
                          DropdownMenuItem<String>(
                            value: "mouth",
                            child: Text(AppLocalizations.of(context)
                                .translate('mouth')),
                          ),
                          DropdownMenuItem<String>(
                            value: "appetite",
                            child: Text(AppLocalizations.of(context)
                                .translate('appetite')),
                          ),
                          DropdownMenuItem<String>(
                            value: "entThroat",
                            child: Text(AppLocalizations.of(context)
                                .translate('throat')),
                          ),
                          DropdownMenuItem<String>(
                            value: "entNose",
                            child: Text(
                                AppLocalizations.of(context).translate('nose')),
                          ),
                          DropdownMenuItem<String>(
                            value: "entEar",
                            child: Text(
                                AppLocalizations.of(context).translate('ear')),
                          ),
                          DropdownMenuItem<String>(
                            value: "ophthalmology",
                            child: Text(
                                AppLocalizations.of(context).translate('eye')),
                          ),
                          DropdownMenuItem<String>(
                            value: "dermatology",
                            child: Text(
                                AppLocalizations.of(context).translate('skin')),
                          ),
                          DropdownMenuItem<String>(
                            value: "uroKidney",
                            child: Text(
                                AppLocalizations.of(context).translate('uro')),
                          ),
                          DropdownMenuItem<String>(
                            value: "maleGenital",
                            child: Text(AppLocalizations.of(context)
                                .translate('male_genital')),
                          ),
                          DropdownMenuItem<String>(
                            value: "gynecology",
                            child: Text(AppLocalizations.of(context)
                                .translate('gynecology')),
                          ),
                          DropdownMenuItem<String>(
                            value: "breast",
                            child: Text(AppLocalizations.of(context)
                                .translate('Breast')),
                          ),
                          DropdownMenuItem<String>(
                            value: "psychology",
                            child: Text(AppLocalizations.of(context)
                                .translate('psychology')),
                          ),
                          DropdownMenuItem<String>(
                            value: "injuriesSuicideIntoxicationBurn",
                            child: Text(AppLocalizations.of(context)
                                .translate('injuriesSuicideIntoxicationBurn')),
                          ),
                          DropdownMenuItem<String>(
                            value: "others",
                            child: Text(AppLocalizations.of(context)
                                .translate('other_symptoms')),
                          ),
                        ],
                        //value: regionSelected05,
                        onChanged: (_value) => selected05(_value),
                        hint: FittedBox(
                          fit: BoxFit.fitWidth,
                          child: Text(AppLocalizations.of(context)
                              .translate('complain_area')),
                        ),
                      ),
                      DropdownButton<String>(
                        isExpanded: true,
                        items: menuitems,
                        onChanged: disabledropdown05
                            ? null
                            : (value) => secondselected5(value),
                        hint: Text(AppLocalizations.of(context)
                            .translate('choose_complain')),
                        disabledHint: Text(AppLocalizations.of(context)
                            .translate('first_choose_complain')),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          FittedBox(
                            fit: BoxFit.fitWidth,
                            child: Text(
                              AppLocalizations.of(context)
                                  .translate('other_complain'),
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Switch(
                              value: _switch05,
                              activeColor: Colors.deepOrange,
                              onChanged: (bool s) {
                                setState(() {
                                  _switch05 = s;
                                  _visibile05 = !_visibile05;
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
              visible: _visibile05,
              child: Container(
                decoration: boxDecorationPatient,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Center(
                        child: Container(
                          child: Text(
                            AppLocalizations.of(context)
                                .translate('add_complains'),
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
                            child: Text(AppLocalizations.of(context)
                                .translate('heart_lung')),
                          ),
                          DropdownMenuItem<String>(
                            value: "gastroIntestinal",
                            child: Text(
                                AppLocalizations.of(context).translate('git')),
                          ),
                          DropdownMenuItem<String>(
                            value: "peiranalAbdomen",
                            child: Text(AppLocalizations.of(context)
                                .translate('perianal_abdomen')),
                          ),
                          DropdownMenuItem<String>(
                            value: "neurology",
                            child: Text(AppLocalizations.of(context)
                                .translate('brain_neuron')),
                          ),
                          DropdownMenuItem<String>(
                            value: "bpPrLab",
                            child: Text(AppLocalizations.of(context)
                                .translate('bpPrLab')),
                          ),
                          DropdownMenuItem<String>(
                            value: "musckuloskeletal",
                            child: Text(AppLocalizations.of(context)
                                .translate('skeleton_muscles')),
                          ),
                          DropdownMenuItem<String>(
                            value: "headNeckBack",
                            child: Text(AppLocalizations.of(context)
                                .translate('head_neck_back')),
                          ),
                          DropdownMenuItem<String>(
                            value: "upperLimb",
                            child: Text(AppLocalizations.of(context)
                                .translate('upper_limb')),
                          ),
                          DropdownMenuItem<String>(
                            value: "lowerLimb",
                            child: Text(AppLocalizations.of(context)
                                .translate('lower_limb')),
                          ),
                          DropdownMenuItem<String>(
                            value: "hand",
                            child: Text(
                                AppLocalizations.of(context).translate('Hand')),
                          ),
                          DropdownMenuItem<String>(
                            value: "mouth",
                            child: Text(AppLocalizations.of(context)
                                .translate('mouth')),
                          ),
                          DropdownMenuItem<String>(
                            value: "appetite",
                            child: Text(AppLocalizations.of(context)
                                .translate('appetite')),
                          ),
                          DropdownMenuItem<String>(
                            value: "entThroat",
                            child: Text(AppLocalizations.of(context)
                                .translate('throat')),
                          ),
                          DropdownMenuItem<String>(
                            value: "entNose",
                            child: Text(
                                AppLocalizations.of(context).translate('nose')),
                          ),
                          DropdownMenuItem<String>(
                            value: "entEar",
                            child: Text(
                                AppLocalizations.of(context).translate('ear')),
                          ),
                          DropdownMenuItem<String>(
                            value: "ophthalmology",
                            child: Text(
                                AppLocalizations.of(context).translate('eye')),
                          ),
                          DropdownMenuItem<String>(
                            value: "dermatology",
                            child: Text(
                                AppLocalizations.of(context).translate('skin')),
                          ),
                          DropdownMenuItem<String>(
                            value: "uroKidney",
                            child: Text(
                                AppLocalizations.of(context).translate('uro')),
                          ),
                          DropdownMenuItem<String>(
                            value: "maleGenital",
                            child: Text(AppLocalizations.of(context)
                                .translate('male_genital')),
                          ),
                          DropdownMenuItem<String>(
                            value: "gynecology",
                            child: Text(AppLocalizations.of(context)
                                .translate('gynecology')),
                          ),
                          DropdownMenuItem<String>(
                            value: "breast",
                            child: Text(AppLocalizations.of(context)
                                .translate('Breast')),
                          ),
                          DropdownMenuItem<String>(
                            value: "psychology",
                            child: Text(AppLocalizations.of(context)
                                .translate('psychology')),
                          ),
                          DropdownMenuItem<String>(
                            value: "injuriesSuicideIntoxicationBurn",
                            child: Text(AppLocalizations.of(context)
                                .translate('injuriesSuicideIntoxicationBurn')),
                          ),
                          DropdownMenuItem<String>(
                            value: "others",
                            child: Text(AppLocalizations.of(context)
                                .translate('other_symptoms')),
                          ),
                        ],
                        //value: regionSelected06,
                        onChanged: (_value) => selected06(_value),
                        hint: FittedBox(
                          fit: BoxFit.fitWidth,
                          child: Text(AppLocalizations.of(context)
                              .translate('complain_area')),
                        ),
                      ),
                      DropdownButton<String>(
                        isExpanded: true,
                        items: menuitems,
                        onChanged: disabledropdown06
                            ? null
                            : (value) => secondselected6(value),
                        hint: Text(AppLocalizations.of(context)
                            .translate('choose_complain')),
                        disabledHint: Text(AppLocalizations.of(context)
                            .translate('first_choose_complain')),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          FittedBox(
                            fit: BoxFit.fitWidth,
                            child: Text(
                              AppLocalizations.of(context)
                                  .translate('other_complain'),
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Switch(
                              value: _switch06,
                              activeColor: Colors.deepOrange,
                              onChanged: (bool s) {
                                setState(() {
                                  _switch06 = s;
                                  _visibile06 = !_visibile06;
                                });
                              })
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            Visibility(
              visible: _visibile06,
              child: Container(
                decoration: boxDecorationPatient,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Center(
                        child: Container(
                          child: Text(
                            AppLocalizations.of(context)
                                .translate('add_complains'),
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
                            child: Text(AppLocalizations.of(context)
                                .translate('heart_lung')),
                          ),
                          DropdownMenuItem<String>(
                            value: "gastroIntestinal",
                            child: Text(
                                AppLocalizations.of(context).translate('git')),
                          ),
                          DropdownMenuItem<String>(
                            value: "peiranalAbdomen",
                            child: Text(AppLocalizations.of(context)
                                .translate('perianal_abdomen')),
                          ),
                          DropdownMenuItem<String>(
                            value: "neurology",
                            child: Text(AppLocalizations.of(context)
                                .translate('brain_neuron')),
                          ),
                          DropdownMenuItem<String>(
                            value: "bpPrLab",
                            child: Text(AppLocalizations.of(context)
                                .translate('bpPrLab')),
                          ),
                          DropdownMenuItem<String>(
                            value: "musckuloskeletal",
                            child: Text(AppLocalizations.of(context)
                                .translate('skeleton_muscles')),
                          ),
                          DropdownMenuItem<String>(
                            value: "headNeckBack",
                            child: Text(AppLocalizations.of(context)
                                .translate('head_neck_back')),
                          ),
                          DropdownMenuItem<String>(
                            value: "upperLimb",
                            child: Text(AppLocalizations.of(context)
                                .translate('upper_limb')),
                          ),
                          DropdownMenuItem<String>(
                            value: "lowerLimb",
                            child: Text(AppLocalizations.of(context)
                                .translate('lower_limb')),
                          ),
                          DropdownMenuItem<String>(
                            value: "hand",
                            child: Text(
                                AppLocalizations.of(context).translate('Hand')),
                          ),
                          DropdownMenuItem<String>(
                            value: "mouth",
                            child: Text(AppLocalizations.of(context)
                                .translate('mouth')),
                          ),
                          DropdownMenuItem<String>(
                            value: "appetite",
                            child: Text(AppLocalizations.of(context)
                                .translate('appetite')),
                          ),
                          DropdownMenuItem<String>(
                            value: "entThroat",
                            child: Text(AppLocalizations.of(context)
                                .translate('throat')),
                          ),
                          DropdownMenuItem<String>(
                            value: "entNose",
                            child: Text(
                                AppLocalizations.of(context).translate('nose')),
                          ),
                          DropdownMenuItem<String>(
                            value: "entEar",
                            child: Text(
                                AppLocalizations.of(context).translate('ear')),
                          ),
                          DropdownMenuItem<String>(
                            value: "ophthalmology",
                            child: Text(
                                AppLocalizations.of(context).translate('eye')),
                          ),
                          DropdownMenuItem<String>(
                            value: "dermatology",
                            child: Text(
                                AppLocalizations.of(context).translate('skin')),
                          ),
                          DropdownMenuItem<String>(
                            value: "uroKidney",
                            child: Text(
                                AppLocalizations.of(context).translate('uro')),
                          ),
                          DropdownMenuItem<String>(
                            value: "maleGenital",
                            child: Text(AppLocalizations.of(context)
                                .translate('male_genital')),
                          ),
                          DropdownMenuItem<String>(
                            value: "gynecology",
                            child: Text(AppLocalizations.of(context)
                                .translate('gynecology')),
                          ),
                          DropdownMenuItem<String>(
                            value: "breast",
                            child: Text(AppLocalizations.of(context)
                                .translate('Breast')),
                          ),
                          DropdownMenuItem<String>(
                            value: "psychology",
                            child: Text(AppLocalizations.of(context)
                                .translate('psychology')),
                          ),
                          DropdownMenuItem<String>(
                            value: "injuriesSuicideIntoxicationBurn",
                            child: Text(AppLocalizations.of(context)
                                .translate('injuriesSuicideIntoxicationBurn')),
                          ),
                          DropdownMenuItem<String>(
                            value: "others",
                            child: Text(AppLocalizations.of(context)
                                .translate('other_symptoms')),
                          ),
                        ],
                        //value: regionSelected07,
                        onChanged: (_value) => selected07(_value),
                        hint: FittedBox(
                          fit: BoxFit.fitWidth,
                          child: Text(AppLocalizations.of(context)
                              .translate('complain_area')),
                        ),
                      ),
                      DropdownButton<String>(
                        isExpanded: true,
                        items: menuitems,
                        onChanged: disabledropdown07
                            ? null
                            : (value) => secondselected7(value),
                        hint: Text(AppLocalizations.of(context)
                            .translate('choose_complain')),
                        disabledHint: Text(AppLocalizations.of(context)
                            .translate('first_choose_complain')),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            //a conflict happened here and solved
            Container(
              height: 40.0,
              width: 200.0,
              child: RaisedButton.icon(
                icon: Icon(
                  Icons.arrow_forward,
                  color: Colors.white,
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(80.0)),
                color: Colors.deepOrange,
                label: Text(AppLocalizations.of(context).translate('next'),
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold)),
                onPressed: () {
                  print(_age);
                  if (_age == '') {
                    setState(() {
                      _error = AppLocalizations.of(context).translate(
                          "age_message"); //'Please , enter your age';
                    });
                    _showSnackBar();
                  } else if (int.parse(_age) > 130) {
                    setState(() {
                      _error = AppLocalizations.of(context).translate(
                          "age_message_error"); //'Age should be from 0 to 130';
                    });
                    _showSnackBar();
                  } else {
                    getage();
                    if (select == '') {
                      setState(() {
                        _error = AppLocalizations.of(context).translate(
                            "gender_message"); //'Please , select a gender';
                      });
                      _showSnackBar();
                    } else {
                      if (complainSelected01 == null) {
                        setState(() {
                          _error = AppLocalizations.of(context).translate(
                              "complain_message"); //'Please , select a main complaint';
                        });
                        _showSnackBar();
                      } else {
                        print(complainSelected01);
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
                            ),
                          ),
                        );
                      }
                    }
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
