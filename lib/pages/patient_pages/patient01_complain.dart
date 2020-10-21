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
  final ageController = TextEditingController();
  String age = '';
  getage() {
    FinalScore.age = int.parse(age);
  }

  //-------------snackbar for age==null---------
  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();
  _showSnackBar() {
    final _snackBar = new SnackBar(
      content: Text(
        AppLocalizations.of(context).translate('snack_age'),
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
      "1": AppLocalizations.of(context).translate('hemoptysis'),
      "2": AppLocalizations.of(context).translate('orthopnea'),
      "3": AppLocalizations.of(context).translate('PN dyspnea'),
      "4": AppLocalizations.of(context).translate('palpitation'),
      "5": AppLocalizations.of(context).translate('chest pain'),
      "6": AppLocalizations.of(context).translate('cough'),
      "7": AppLocalizations.of(context).translate('sputum'),
      "8": AppLocalizations.of(context).translate('dyspnea'),
      "9": AppLocalizations.of(context).translate('cyanosis'),
      "10": AppLocalizations.of(context).translate('other cardiac problems'),
      "11": AppLocalizations.of(context).translate('wheeze'),
      "12":
          AppLocalizations.of(context).translate('other respiratory problems'),
    };
    final gastroIntestinal = {
      "1": AppLocalizations.of(context).translate('abdominal pain'),
      "2": AppLocalizations.of(context).translate('vomiting'),
      "3": AppLocalizations.of(context).translate('constipation'),
      "4": AppLocalizations.of(context).translate('bloody diarrhea'),
      "5": AppLocalizations.of(context).translate('watery diarrhea'),
      "6": AppLocalizations.of(context).translate('dysphagia'),
      "7": AppLocalizations.of(context).translate('odynophagia'),
      "8": AppLocalizations.of(context).translate('mucousy diarrhea'),
      "9": AppLocalizations.of(context).translate('other git problems'),
      "10": AppLocalizations.of(context).translate('abdominal distension'),
      "11": AppLocalizations.of(context).translate('bleeding per rectum'),
      "12": AppLocalizations.of(context).translate('nausea'),
      "13": AppLocalizations.of(context).translate('hematemesis'),
      "14": AppLocalizations.of(context).translate('malena'),
      "15": AppLocalizations.of(context).translate('tenesmus'),
    };
    final peiranalAbdomen = {
      "1": AppLocalizations.of(context).translate('perianal pain'),
      "2": AppLocalizations.of(context).translate('perianal discharge'),
      "3": AppLocalizations.of(context).translate('anal incontinence'),
      "4": AppLocalizations.of(context).translate('perianal itching'),
      "5": AppLocalizations.of(context).translate('abdominal wall swelling'),
    };
    AppLocalizations.of(context).translate('');
    final neurology = {
      "1": AppLocalizations.of(context).translate('coma'),
      "2": AppLocalizations.of(context).translate('fit'),
      "3": AppLocalizations.of(context).translate('abnormal movement'),
      "4": AppLocalizations.of(context).translate('spasm'),
      "5": AppLocalizations.of(context).translate('memory loss'),
      "6": AppLocalizations.of(context).translate('tremer'),
      "7": AppLocalizations.of(context).translate('confusion'),
      "8": AppLocalizations.of(context).translate('numbness'),
      "9": AppLocalizations.of(context).translate('slurred speech'),
      "10": AppLocalizations.of(context).translate('ataxia'),
      "11": AppLocalizations.of(context).translate('weakness'),
      "12":
          AppLocalizations.of(context).translate('other neurological problems'),
      "13": AppLocalizations.of(context).translate('syncope')
    };

    final psychology = {
      "1": AppLocalizations.of(context).translate('cognitive impairment'),
      "2": AppLocalizations.of(context).translate('behavioral impairement'),
      "3": AppLocalizations.of(context).translate('depression'),
      "4": AppLocalizations.of(context).translate('hallucination/delusion'),
      "5": AppLocalizations.of(context).translate('phobia'),
      "6": AppLocalizations.of(context).translate('suicide'),
      "7": AppLocalizations.of(context).translate('obsession'),
      "8": AppLocalizations.of(context).translate('attention deficit'),
      "9": AppLocalizations.of(context).translate('hyperactivity'),
      "10": AppLocalizations.of(context).translate('stress'),
      "11": AppLocalizations.of(context).translate('psychological trauma'),
      "12": AppLocalizations.of(context).translate('addiction'),
      "13": AppLocalizations.of(context).translate('encorporesis'),
      "14": AppLocalizations.of(context).translate('polyphagia'),
      "15": AppLocalizations.of(context)
          .translate('other psychological problems'),
    };
    final musckuloskeletal = {
      "1": AppLocalizations.of(context).translate('generalized bone pain'),
      "2": AppLocalizations.of(context).translate('joint pain'),
      "3": AppLocalizations.of(context).translate('deformity'),
      "4": AppLocalizations.of(context).translate('joint swelling'),
      "5": AppLocalizations.of(context).translate('limitation of movement'),
      "6": AppLocalizations.of(context).translate('fracture'),
      "7": AppLocalizations.of(context).translate('limb pain'),
      "8": AppLocalizations.of(context).translate('dislocation'),
      "9": AppLocalizations.of(context).translate('other msk problems'),
    };
    final headNeckBack = {
      "1": AppLocalizations.of(context).translate('jaw pain'),
      "2": AppLocalizations.of(context).translate('neck pain'),
      "3": AppLocalizations.of(context).translate('enlarged jaw'),
      "4": AppLocalizations.of(context).translate('neck swelling'),
      "5": AppLocalizations.of(context).translate('back opening'),
      "6": AppLocalizations.of(context).translate('back mass'),
      "7": AppLocalizations.of(context).translate('back pain'),
      "8": AppLocalizations.of(context).translate('headache'),
      "9": AppLocalizations.of(context).translate('large head'),
      "10": AppLocalizations.of(context).translate('abnormal head shape'),
      "11": AppLocalizations.of(context).translate('other skull problems'),
    };
    final upperLimb = {
      "1": AppLocalizations.of(context).translate('left arm pain'),
      "2": AppLocalizations.of(context).translate('left shoulder pain'),
      "3": AppLocalizations.of(context).translate('generalized bone pain'),
      "4": AppLocalizations.of(context).translate('joint pain'),
      "5": AppLocalizations.of(context).translate('deformity'),
      "6": AppLocalizations.of(context).translate('joint swelling'),
      "7": AppLocalizations.of(context).translate('limitation of movement'),
      "8": AppLocalizations.of(context).translate('fracture'),
      "9": AppLocalizations.of(context).translate('limb pain'),
      "10": AppLocalizations.of(context).translate('dislocation'),
    };

    final hand = {
      "1": AppLocalizations.of(context).translate('enlarged hand'),
      "2": AppLocalizations.of(context).translate('extra digit'),
      "3": AppLocalizations.of(context).translate('joined digit'),
      "4": AppLocalizations.of(context).translate('loss digit'),
      "5": AppLocalizations.of(context).translate('hand deformity'),
      "6": AppLocalizations.of(context).translate('other hand problems'),
      "7": AppLocalizations.of(context).translate('hand swelling'),
      "8": AppLocalizations.of(context).translate('hand lump'),
      "9": AppLocalizations.of(context).translate('generalized bone pain'),
      "10": AppLocalizations.of(context).translate('joint pain,'),
      "11": AppLocalizations.of(context).translate('joint swelling'),
      "12": AppLocalizations.of(context).translate('fracture'),
      "13": AppLocalizations.of(context).translate('dislocation'),
    };
    final lowerLimb = {
      "1": AppLocalizations.of(context).translate('bilateral leg edema'),
      "2": AppLocalizations.of(context).translate('enlarged foot'),
      "3": AppLocalizations.of(context).translate('generalized bone pain'),
      "4": AppLocalizations.of(context).translate('joint pain'),
      "5": AppLocalizations.of(context).translate('unilateral leg swelling'),
      "6": AppLocalizations.of(context).translate('unilateral leg pain'),
      "7": AppLocalizations.of(context).translate('deformity'),
      "8": AppLocalizations.of(context).translate('joint swelling'),
      "9": AppLocalizations.of(context).translate('limitation of movement'),
      "10": AppLocalizations.of(context).translate('leg pain during walking'),
      "11": AppLocalizations.of(context).translate('foot ulcer'),
      "12": AppLocalizations.of(context).translate('fracture'),
      "13": AppLocalizations.of(context).translate('limb pain'),
      "14": AppLocalizations.of(context).translate('dislocation'),
    };

    final others = {
      "1": AppLocalizations.of(context).translate('sweating'),
      "2": AppLocalizations.of(context).translate('fever'),
      "3": AppLocalizations.of(context).translate('heat sensation'),
      "4": AppLocalizations.of(context).translate('ulcer'),
      "5": AppLocalizations.of(context).translate('insomnia'),
      "6": AppLocalizations.of(context).translate('cold sensation'),
      "7": AppLocalizations.of(context).translate('somnolence'),
      "8": AppLocalizations.of(context).translate('polydipsia'),
      "9": AppLocalizations.of(context).translate('delayed puberty'),
      "10": AppLocalizations.of(context).translate('bleeding'),
      "11": AppLocalizations.of(context).translate('fatigue'),
      "12": AppLocalizations.of(context).translate('pallor'),
      "13": AppLocalizations.of(context).translate('lump'),
      "14": AppLocalizations.of(context).translate('other health problems'),
      "15": AppLocalizations.of(context).translate('malaise'),
      "16": AppLocalizations.of(context).translate('short stature'),
      "17": AppLocalizations.of(context).translate('taste loss'),
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
      "1": AppLocalizations.of(context).translate('FFH'),
      "2": AppLocalizations.of(context).translate('RTA'),
      "3": AppLocalizations.of(context).translate('stab'),
      "4": AppLocalizations.of(context).translate('shot'),
      "5": AppLocalizations.of(context).translate('other injuries'),
      "6": AppLocalizations.of(context).translate('suicide'),
      "7": AppLocalizations.of(context).translate('intoxication'),
      "8": AppLocalizations.of(context).translate('burn'),
      "9": AppLocalizations.of(context).translate('msk injury'),
      "10": AppLocalizations.of(context).translate('sport injury'),
    };

    final mouth = {
      "1": AppLocalizations.of(context).translate('mouth deviation'),
      "2": AppLocalizations.of(context).translate('cleft lip'),
      "3": AppLocalizations.of(context).translate('cleft palate'),
      "4": AppLocalizations.of(context).translate('disease of the mouth'),
    };
    final appetite = {
      "1": AppLocalizations.of(context).translate('polyphagia'),
      "2": AppLocalizations.of(context).translate('weight gain'),
      "3": AppLocalizations.of(context).translate('weight loss'),
      "4": AppLocalizations.of(context).translate('anorexia'),
    };

    final entThroat = {
      "1": AppLocalizations.of(context).translate('hoarseness'),
      "2": AppLocalizations.of(context).translate('sore throat'),
      "3": AppLocalizations.of(context).translate('other ent problems'),
    };
    final entNose = {
      "1": AppLocalizations.of(context).translate('nasal discharge'),
      "2": AppLocalizations.of(context).translate('nasal bleeding'),
      "3": AppLocalizations.of(context).translate('nasal obstruction'),
      "4": AppLocalizations.of(context).translate('nasal pain'),
      "5": AppLocalizations.of(context).translate('nasal mass'),
      "6": AppLocalizations.of(context).translate('nasal deformity'),
      "7": AppLocalizations.of(context).translate('sneezing'),
      "8": AppLocalizations.of(context).translate('nasal itching'),
      "9": AppLocalizations.of(context).translate('anosmia'),
      "10": AppLocalizations.of(context).translate('enlarged nose'),
      "11": AppLocalizations.of(context).translate('other ent problems'),
    };

    final entEar = {
      "1": AppLocalizations.of(context).translate('deafness'),
      "2": AppLocalizations.of(context).translate('vertigo'),
      "3": AppLocalizations.of(context).translate('tinnitus'),
      "4": AppLocalizations.of(context).translate('ear discharge'),
      "5": AppLocalizations.of(context).translate('ear redness'),
      "6": AppLocalizations.of(context).translate('ear pain'),
      "7": AppLocalizations.of(context).translate('other ent problems'),
    };

    final dermatology = {
      "1": AppLocalizations.of(context).translate('dry skin'),
      "2": AppLocalizations.of(context).translate('dry hair'),
      "3": AppLocalizations.of(context).translate('skin rash'),
      "4": AppLocalizations.of(context).translate('hair problems'),
      "5": AppLocalizations.of(context).translate('skin redness'),
      "6": AppLocalizations.of(context).translate('skin lesion'),
      "7": AppLocalizations.of(context).translate('skin appendage'),
      "8": AppLocalizations.of(context).translate('skin itching'),
      "9": AppLocalizations.of(context).translate('acne'),
      "10": AppLocalizations.of(context).translate('bruising'),
      "11": AppLocalizations.of(context).translate('female hirsutism'),
    };

    final gynecology = {
      "1": AppLocalizations.of(context).translate('amenorrhea'),
      "2": AppLocalizations.of(context).translate('oligomenorrhea'),
      "3": AppLocalizations.of(context).translate('decrease libido'),
      "4": AppLocalizations.of(context).translate('menorrhagia'),
      "5": AppLocalizations.of(context).translate('female infertility'),
      "6": AppLocalizations.of(context).translate('female hirsutism'),
      "7": AppLocalizations.of(context).translate('prolong pregnancy'),
      "8": AppLocalizations.of(context).translate('postmenopausal bleeding'),
      "9": AppLocalizations.of(context)
          .translate('other gynecological and obstetrical problems'),
      "10": AppLocalizations.of(context).translate('miscarriage'),
    };

    final uroKidney = {
      "1": AppLocalizations.of(context).translate('incontinence'),
      "2": AppLocalizations.of(context).translate('polyuria'),
      "3": AppLocalizations.of(context)
          .translate('abnormal urethral opening site'),
      "4": AppLocalizations.of(context).translate('suprapubic pain'),
      "5": AppLocalizations.of(context).translate('frequency'),
      "6": AppLocalizations.of(context).translate('flank pain'),
      "7": AppLocalizations.of(context).translate('retention'),
      "8": AppLocalizations.of(context).translate('urgency'),
      "9": AppLocalizations.of(context).translate('dysuria'),
      "10": AppLocalizations.of(context).translate('hematuria'),
      "11": AppLocalizations.of(context).translate('other urological problems'),
      "12": AppLocalizations.of(context).translate('nocturia'),
    };

    final maleGenital = {
      "1": AppLocalizations.of(context).translate('decrease libido'),
      "2": AppLocalizations.of(context).translate('delayed puberty'),
      "3": AppLocalizations.of(context).translate('male infertility'),
      "4": AppLocalizations.of(context).translate('scrotal swelling'),
      "5": AppLocalizations.of(context).translate('empty scrotum'),
      "6": AppLocalizations.of(context).translate('abnormal penile size'),
      "7": AppLocalizations.of(context).translate('penile mass'),
      "8": AppLocalizations.of(context).translate('other penile problems'),
      "9": AppLocalizations.of(context).translate('scrotal pain'),
      "10": AppLocalizations.of(context).translate('priapism'),
      "11": AppLocalizations.of(context).translate('priapism'),
      "12": AppLocalizations.of(context).translate('hematospermia'),
    };

    final ophthalmology = {
      "1": AppLocalizations.of(context).translate('open eye'),
      "2": AppLocalizations.of(context).translate('blindness'),
      "3": AppLocalizations.of(context).translate('photophobia'),
      "4": AppLocalizations.of(context).translate('double vision'),
      "5": AppLocalizations.of(context).translate('lid drop'),
      "6": AppLocalizations.of(context).translate('blurred vision'),
      "7": AppLocalizations.of(context).translate('squint'),
      "8": AppLocalizations.of(context).translate('eye redness'),
      "9": AppLocalizations.of(context).translate('eye pain'),
      "10": AppLocalizations.of(context).translate('eye discharge'),
      "11": AppLocalizations.of(context).translate('eye itching'),
      "12": AppLocalizations.of(context).translate('eye pigmentation'),
      "13": AppLocalizations.of(context).translate('periorbital edema'),
      "14": AppLocalizations.of(context).translate('eyelid deformity'),
      "15": AppLocalizations.of(context).translate('dry eye'),
      "16": AppLocalizations.of(context).translate('ophthalmoplegia'),
      "17": AppLocalizations.of(context)
          .translate('other ophthalmological problems'),
    };
    final breast = {
      "1": AppLocalizations.of(context).translate('gynecomastia'),
      "2": AppLocalizations.of(context).translate('galactorrhea'),
      "3": AppLocalizations.of(context).translate('breast mass'),
      "4": AppLocalizations.of(context).translate('breast pain'),
      "5": AppLocalizations.of(context).translate('breast discharge'),
      "6": AppLocalizations.of(context).translate('breast lump'),
      "7": AppLocalizations.of(context).translate('breast skin lesion'),
      "8": AppLocalizations.of(context).translate('other breast  problems'),
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
                        setState(() {
                          age = ageController.toString();
                        });
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
                      value: regionSelected01,
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
                      value: complainSelected01,
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
                        value: regionSelected02,
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
                        value: regionSelected03,
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
                        value: regionSelected04,
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
                        value: regionSelected05,
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
                        value: regionSelected06,
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
                        value: regionSelected07,
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
                  if (age == '') {
                    _showSnackBar;
                  }
                  getage();
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
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
