import 'dart:ui';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project_doctor/matching_algorithm/final_score.dart';
import 'package:project_doctor/services/app_localizations.dart';
import 'package:project_doctor/constants/theme.dart';
import 'package:project_doctor/pages/patient_pages/patient02_risk_factors.dart';
import 'package:project_doctor/ui/responsive_builder.dart';
import 'package:project_doctor/ui/device_screen_type.dart';
import 'package:project_doctor/ui/sizing_information.dart';

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
  getage() {
    FinalScore.age = int.parse(_age);
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
  List radioGender = ["Male", "Female"];
  String radioSelect = '';

  @override
  Widget build(BuildContext context) {
    //snackbar for
    var lang = Localizations.localeOf(context).languageCode;
    _showSnackBar() {
      final _snackBar = new SnackBar(
        content: Text(
          _error,
          style: TextStyle(
              fontSize: 15,
              fontFamily: lang == 'ar' ? 'noto_arabic' : 'Helvetica'),
        ),
        backgroundColor: Colors.deepOrange,
      );
      _scaffoldkey.currentState.showSnackBar(_snackBar);
    }

    final cardioRespiratory = {
      "9": [AppLocalizations.of(context).translate('cyanosis'), 'cyanosis'],
      "11": [AppLocalizations.of(context).translate('wheeze'), 'wheeze'],
      "5": [AppLocalizations.of(context).translate('chest pain'), 'chest pain'],
      "7": [AppLocalizations.of(context).translate('sputum'), 'sputum'],
      "1": [AppLocalizations.of(context).translate('hemoptysis'), 'hemoptysis'],
      "4": [
        AppLocalizations.of(context).translate('palpitation'),
        'palpitation'
      ],
      "6": [AppLocalizations.of(context).translate('cough'), 'cough'],
      "8": [AppLocalizations.of(context).translate('dyspnea'), 'dyspnea'],
      "2": [AppLocalizations.of(context).translate('orthopnea'), 'orthopnea'],
      "3": [AppLocalizations.of(context).translate('PN dyspnea'), 'PN dyspnea'],
      "10": [
        AppLocalizations.of(context).translate('other cardiac problems'),
        'other cardiac problems'
      ],
      "12": [
        AppLocalizations.of(context).translate('other respiratory problems'),
        'other respiratory problems'
      ]
    };
    final gastroIntestinal = {
      "4": [
        AppLocalizations.of(context).translate('bloody diarrhea'),
        'bloody diarrhea'
      ],
      "5": [
        AppLocalizations.of(context).translate('watery diarrhea'),
        'watery diarrhea'
      ],
      "8": [
        AppLocalizations.of(context).translate('mucousy diarrhea'),
        'mucousy diarrhea'
      ],
      "3": [
        AppLocalizations.of(context).translate('constipation'),
        'constipation'
      ],
      "2": [AppLocalizations.of(context).translate('vomiting'), 'vomiting'],
      "7": [
        AppLocalizations.of(context).translate('odynophagia'),
        'odynophagia'
      ],
      "1": [
        AppLocalizations.of(context).translate('abdominal pain'),
        'abdominal pain'
      ],
      "10": [
        AppLocalizations.of(context).translate('abdominal distension'),
        'abdominal distension'
      ],
      "13": [
        AppLocalizations.of(context).translate('hematemesis'),
        'hematemesis'
      ],
      "14": [AppLocalizations.of(context).translate('malena'), 'malena'],
      "15": [AppLocalizations.of(context).translate('tenesmus'), 'tenesmus'],
      "6": [AppLocalizations.of(context).translate('dysphagia'), 'dysphagia'],
      "12": [AppLocalizations.of(context).translate('nausea'), 'nausea'],
      "9": [
        AppLocalizations.of(context).translate('other git problems'),
        'other git problems'
      ],
      "11": [
        AppLocalizations.of(context).translate('bleeding per rectum'),
        'bleeding per rectum'
      ],
    };
    final peiranalAbdomen = {
      "2": [
        AppLocalizations.of(context).translate('perianal discharge'),
        'perianal discharge'
      ],
      "1": [
        AppLocalizations.of(context).translate('perianal pain'),
        'perianal pain'
      ],
      "5": [
        AppLocalizations.of(context).translate('abdominal wall swelling'),
        'abdominal wall swelling'
      ],
      "4": [
        AppLocalizations.of(context).translate('perianal itching'),
        'perianal itching'
      ],
      "3": [
        AppLocalizations.of(context).translate('anal incontinence'),
        'anal incontinence'
      ],
    };
    final neurology = {
      "6": [AppLocalizations.of(context).translate('tremer'), 'tremer'],
      "10": [AppLocalizations.of(context).translate('ataxia'), 'ataxia'],
      "4": [AppLocalizations.of(context).translate('spasm'), 'spasm'],
      "7": [AppLocalizations.of(context).translate('confusion'), 'confusion'],
      "13": [AppLocalizations.of(context).translate('syncope'), 'syncope'],
      "3": [
        AppLocalizations.of(context).translate('abnormal movement'),
        'abnormal movement'
      ],
      "8": [AppLocalizations.of(context).translate('numbness'), 'numbness'],
      "9": [
        AppLocalizations.of(context).translate('slurred speech'),
        'slurred speech'
      ],
      "11": [AppLocalizations.of(context).translate('weakness'), 'weakness'],
      "1": [AppLocalizations.of(context).translate('coma'), 'coma'],
      "5": [
        AppLocalizations.of(context).translate('memory loss'),
        'memory loss'
      ],
      "12": [
        AppLocalizations.of(context).translate('other neurological problems'),
        'other neurological problems'
      ],
      "2": [AppLocalizations.of(context).translate('fit'), 'fit'],
    };

    final psychology = {
      "11": [
        AppLocalizations.of(context).translate('psychological trauma'),
        'psychological trauma'
      ],
      "2": [
        AppLocalizations.of(context).translate('behavioral impairement'),
        'behavioral impairement'
      ],
      "3": [AppLocalizations.of(context).translate('depression'), 'depression'],
      "12": [AppLocalizations.of(context).translate('addiction'), 'addiction'],
      "5": [AppLocalizations.of(context).translate('phobia'), 'phobia'],
      "10": [AppLocalizations.of(context).translate('stress'), 'stress'],
      "7": [AppLocalizations.of(context).translate('obsession'), 'obsession'],
      "4": [
        AppLocalizations.of(context).translate('hallucination/delusion'),
        'hallucination/delusion'
      ],
      "1": [
        AppLocalizations.of(context).translate('cognitive impairment'),
        'cognitive impairment'
      ],
      "9": [
        AppLocalizations.of(context).translate('hyperactivity'),
        'hyperactivity'
      ],
      "6": [AppLocalizations.of(context).translate('suicide'), 'suicide'],
      "14": [
        AppLocalizations.of(context).translate('other psychological problems'),
        'other psychological problems'
      ],
      "8": [
        AppLocalizations.of(context).translate('attention deficit'),
        'attention deficit'
      ],
    };
    final musckuloskeletal = {
      "7": [AppLocalizations.of(context).translate('limb pain'), 'limb pain'],
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
      "8": [
        AppLocalizations.of(context).translate('dislocation'),
        'dislocation'
      ],
      "6": [AppLocalizations.of(context).translate('fracture'), 'fracture'],
      "9": [
        AppLocalizations.of(context).translate("other msk problems"),
        "other msk problems"
      ],
    };
    final headNeckBack = {
      "8": [AppLocalizations.of(context).translate('headache'), 'headache'],
      "2": [AppLocalizations.of(context).translate('neck pain'), 'neck pain'],
      "7": [AppLocalizations.of(context).translate('back pain'), 'back pain'],
      "1": [AppLocalizations.of(context).translate('jaw pain'), 'jaw pain'],
      "3": [
        AppLocalizations.of(context).translate('enlarged jaw'),
        'enlarged jaw'
      ],
      "4": [
        AppLocalizations.of(context).translate('neck swelling'),
        'neck swelling'
      ],
      "6": [AppLocalizations.of(context).translate('back mass'), 'back mass'],
      "10": [
        AppLocalizations.of(context).translate('abnormal head shape'),
        'abnormal head shape'
      ],
      "5": [
        AppLocalizations.of(context).translate('back opening'),
        'back opening'
      ],
      "11": [
        AppLocalizations.of(context).translate('other skull problems'),
        'other skull problems'
      ],
      "9": [AppLocalizations.of(context).translate('large head'), 'large head'],
    };
    final upperLimb = {
      "9": [AppLocalizations.of(context).translate('limb pain'), 'limb pain'],
      "1": [
        AppLocalizations.of(context).translate('left arm pain'),
        'left arm pain'
      ],
      "3": [
        AppLocalizations.of(context).translate('generalized bone pain'),
        'generalized bone pain'
      ],
      "2": [
        AppLocalizations.of(context).translate('left shoulder pain'),
        'left shoulder pain'
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
      "10": [
        AppLocalizations.of(context).translate('dislocation'),
        'dislocation'
      ],
      "8": [AppLocalizations.of(context).translate('fracture'), 'fracture'],
    };

    final hand = {
      "3": [
        AppLocalizations.of(context).translate('joined digit'),
        'joined digit'
      ],
      "10": [
        AppLocalizations.of(context).translate('joint pain'),
        'joint pain'
      ],
      "8": [AppLocalizations.of(context).translate('hand lump'), 'hand lump'],
      "5": [
        AppLocalizations.of(context).translate('hand deformity'),
        'hand deformity'
      ],
      "1": [
        AppLocalizations.of(context).translate('enlarged hand'),
        'enlarged hand'
      ],
      "11": [
        AppLocalizations.of(context).translate('joint swelling'),
        'joint swelling'
      ],
      "7": [
        AppLocalizations.of(context).translate('hand swelling'),
        'hand swelling'
      ],
      "13": [
        AppLocalizations.of(context).translate('dislocation'),
        'dislocation'
      ],
      "2": [
        AppLocalizations.of(context).translate('extra digit'),
        'extra digit'
      ],
      "4": [AppLocalizations.of(context).translate('loss digit'), 'loss digit'],
      "12": [AppLocalizations.of(context).translate('fracture'), 'fracture'],
      "6": [
        AppLocalizations.of(context).translate('other hand problems'),
        'other hand problems'
      ],
    };
    final lowerLimb = {
      "13": [AppLocalizations.of(context).translate('limb pain'), 'limb pain'],
      "10": [
        AppLocalizations.of(context).translate('leg pain during walking'),
        'leg pain during walking'
      ],
      "6": [
        AppLocalizations.of(context).translate('unilateral leg pain'),
        'unilateral leg pain'
      ],
      "4": [AppLocalizations.of(context).translate('joint pain'), 'joint pain'],
      "7": [AppLocalizations.of(context).translate('deformity'), 'deformity'],
      "2": [
        AppLocalizations.of(context).translate('enlarged foot'),
        'enlarged foot'
      ],
      "11": [
        AppLocalizations.of(context).translate('foot ulcer'),
        'foot ulcer'
      ],
      "5": [
        AppLocalizations.of(context).translate('unilateral leg swelling'),
        'unilateral leg swelling'
      ],
      "8": [
        AppLocalizations.of(context).translate('joint swelling'),
        'joint swelling'
      ],
      "1": [
        AppLocalizations.of(context).translate('bilateral leg edema'),
        'bilateral leg edema'
      ],
      "9": [
        AppLocalizations.of(context).translate('limitation of movement'),
        'limitation of movement'
      ],
      /*"3": [
        AppLocalizations.of(context).translate('generalized bone pain'),
        'generalized bone pain'
      ],*/
      "14": [
        AppLocalizations.of(context).translate('dislocation'),
        'dislocation'
      ],
      "12": [AppLocalizations.of(context).translate('fracture'), 'fracture'],
    };

    final others = {
      "5": [AppLocalizations.of(context).translate('insomnia'), 'insomnia'],
      "11": [AppLocalizations.of(context).translate('fatigue'), 'fatigue'],
      "1": [AppLocalizations.of(context).translate('sweating'), 'sweating'],
      "2": [AppLocalizations.of(context).translate('fever'), 'fever'],
      "7": [AppLocalizations.of(context).translate('somnolence'), 'somnolence'],
      "12": [AppLocalizations.of(context).translate('pallor'), 'pallor'],
      "6": [
        AppLocalizations.of(context).translate('cold sensation'),
        'cold sensation'
      ],
      "3": [
        AppLocalizations.of(context).translate('heat sensation'),
        'heat sensation'
      ],
      "8": [AppLocalizations.of(context).translate('polydipsia'), 'polydipsia'],
      "15": [AppLocalizations.of(context).translate('malaise'), 'malaise'],
      "10": [AppLocalizations.of(context).translate('bleeding'), 'bleeding'],
      "9": [
        AppLocalizations.of(context).translate('delayed puberty'),
        'delayed puberty'
      ],
      "4": [AppLocalizations.of(context).translate('ulcer'), 'ulcer'],
      "13": [AppLocalizations.of(context).translate('lump'), 'lump'],
      "17": [
        AppLocalizations.of(context).translate('taste loss'),
        'taste loss'
      ],
      "16": [
        AppLocalizations.of(context).translate('short stature'),
        'short stature'
      ],
      "14": [
        AppLocalizations.of(context).translate('other health problems'),
        'other health problems'
      ],
    };

    final injuriesSuicideIntoxicationBurn = {
      "9": [AppLocalizations.of(context).translate('msk injury'), 'msk injury'],
      "10": [
        AppLocalizations.of(context).translate('sport injury'),
        'sport injury'
      ],
      "7": [
        AppLocalizations.of(context).translate('intoxication'),
        'intoxication'
      ],
      "8": [AppLocalizations.of(context).translate('burn'), 'burn'],
      "1": [AppLocalizations.of(context).translate('FFH'), 'FFH'],
      "2": [AppLocalizations.of(context).translate('RTA'), 'RTA'],
      "3": [AppLocalizations.of(context).translate('stab'), 'stab'],
      "4": [AppLocalizations.of(context).translate('shot'), 'shot'],
      "6": [AppLocalizations.of(context).translate('suicide'), 'suicide'],
      "5": [
        AppLocalizations.of(context).translate('other injuries'),
        'other injuries'
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
      "2": [
        AppLocalizations.of(context).translate('weight gain'),
        'weight gain'
      ],
      "1": [AppLocalizations.of(context).translate('polyphagia'), 'polyphagia'],
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
      "7": [AppLocalizations.of(context).translate('sneezing'), 'sneezing'],
      "3": [
        AppLocalizations.of(context).translate('nasal obstruction'),
        'nasal obstruction'
      ],
      "4": [AppLocalizations.of(context).translate('nasal pain'), 'nasal pain'],
      "6": [
        AppLocalizations.of(context).translate('nasal deformity'),
        'nasal deformity'
      ],
      "10": [
        AppLocalizations.of(context).translate('enlarged nose'),
        'enlarged nose'
      ],
      "8": [
        AppLocalizations.of(context).translate('nasal itching'),
        'nasal itching'
      ],
      "5": [AppLocalizations.of(context).translate('nasal mass'), 'nasal mass'],
      "9": [AppLocalizations.of(context).translate('anosmia'), 'anosmia'],
      "2": [
        AppLocalizations.of(context).translate('nasal bleeding'),
        'nasal bleeding'
      ],
      "11": [
        AppLocalizations.of(context).translate('other ent problems'),
        'other ent problems'
      ],
    };

    final entEar = {
      "5": [
        AppLocalizations.of(context).translate('ear redness'),
        'ear redness'
      ],
      "2": [AppLocalizations.of(context).translate('vertigo'), 'vertigo'],
      "1": [AppLocalizations.of(context).translate('deafness'), 'deafness'],
      "3": [AppLocalizations.of(context).translate('tinnitus'), 'tinnitus'],
      "6": [AppLocalizations.of(context).translate('ear pain'), 'ear pain'],
      "4": [
        AppLocalizations.of(context).translate('ear discharge'),
        'ear discharge'
      ],
      "7": [
        AppLocalizations.of(context).translate('other ent problems'),
        'other ent problems'
      ],
    };

    final dermatology = {
      "5": [
        AppLocalizations.of(context).translate('skin redness'),
        'skin redness'
      ],
      "4": [
        AppLocalizations.of(context).translate('hair problems'),
        'hair problems'
      ],
      "10": [AppLocalizations.of(context).translate('bruising'), 'bruising'],
      "13": [
        AppLocalizations.of(context).translate('skin pigmentation'),
        "skin pigmentation"
      ],
      "1": [AppLocalizations.of(context).translate('dry skin'), 'dry skin'],
      "2": [AppLocalizations.of(context).translate('dry hair'), 'dry hair'],
      "9": [AppLocalizations.of(context).translate('acne'), 'acne'],
      "8": [
        AppLocalizations.of(context).translate('skin itching'),
        'skin itching'
      ],
      "7": [
        AppLocalizations.of(context).translate('skin appendage'),
        'skin appendage'
      ],
      "3": [AppLocalizations.of(context).translate('skin rash'), 'skin rash'],
      "6": [
        AppLocalizations.of(context).translate('skin lesion'),
        'skin lesion'
      ],
      "11": [
        AppLocalizations.of(context).translate('female hirsutism'),
        'female hirsutism'
      ],
      "12": [
        AppLocalizations.of(context).translate("other dermatological problems"),
        'other dermatological problems'
      ],
    };

    final gynecology = {
      "10": [
        AppLocalizations.of(context).translate('miscarriage'),
        'miscarriage'
      ],
      "1": [AppLocalizations.of(context).translate('amenorrhea'), 'amenorrhea'],
      "2": [
        AppLocalizations.of(context).translate('oligomenorrhea'),
        'oligomenorrhea'
      ],
      //"3": [AppLocalizations.of(context).translate('decrease libido'), 'decrease libido'],
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
    };

    final uroKidney = {
      "7": [AppLocalizations.of(context).translate('retention'), 'retention'],
      "10": [AppLocalizations.of(context).translate('hematuria'), 'hematuria'],
      "8": [AppLocalizations.of(context).translate('urgency'), 'urgency'],
      "12": [AppLocalizations.of(context).translate('nocturia'), 'nocturia'],
      "9": [AppLocalizations.of(context).translate('dysuria'), 'dysuria'],
      "4": [
        AppLocalizations.of(context).translate('suprapubic pain'),
        'suprapubic pain'
      ],
      "6": [AppLocalizations.of(context).translate('flank pain'), 'flank pain'],
      "1": [
        AppLocalizations.of(context).translate('incontinence'),
        'incontinence'
      ],
      //"3": [AppLocalizations.of(context).translate('abnormal urethral opening site'), 'abnormal urethral opening site'],
      "5": [AppLocalizations.of(context).translate('frequency'), 'frequency'],
      "2": [AppLocalizations.of(context).translate('polyuria'), 'polyuria'],
      "11": [
        AppLocalizations.of(context).translate('other urological problems'),
        'other urological problems'
      ],
    };

    final maleGenital = {
      "10": [AppLocalizations.of(context).translate('priapism'), 'priapism'],
      "3": [
        AppLocalizations.of(context).translate('male infertility'),
        'male infertility'
      ],
      "9": [
        AppLocalizations.of(context).translate('scrotal pain'),
        'scrotal pain'
      ],
      "4": [
        AppLocalizations.of(context).translate('scrotal swelling'),
        'scrotal swelling'
      ],
      "2": [
        AppLocalizations.of(context).translate('delayed puberty'),
        'delayed puberty'
      ],
      // "1": [AppLocalizations.of(context).translate('decrease libido'), 'decrease libido'],
      "7": [
        AppLocalizations.of(context).translate('penile mass'),
        'penile mass'
      ],
      "23": [AppLocalizations.of(context).translate('impotence'), 'impotence'],
      "11": [
        AppLocalizations.of(context).translate('hematospermia'),
        'hematospermia'
      ],
      "8": [
        AppLocalizations.of(context).translate('other penile problems'),
        'other penile problems'
      ],
    };

    final ophthalmology = {
      "8": [
        AppLocalizations.of(context).translate('eye redness'),
        'eye redness'
      ],
      "12": [
        AppLocalizations.of(context).translate('eye pigmentation'),
        'eye pigmentation'
      ],
      "22": [AppLocalizations.of(context).translate("jaundice"), "jaundice"],
      "7": [AppLocalizations.of(context).translate('squint'), 'squint'],
      "3": [
        AppLocalizations.of(context).translate('photophobia'),
        'photophobia'
      ],
      "4": [
        AppLocalizations.of(context).translate('double vision'),
        'double vision'
      ],
      "2": [AppLocalizations.of(context).translate('blindness'), 'blindness'],
      "9": [AppLocalizations.of(context).translate('eye pain'), 'eye pain'],
      "6": [
        AppLocalizations.of(context).translate('blurred vision'),
        'blurred vision'
      ],
      "14": [
        AppLocalizations.of(context).translate('eyelid deformity'),
        'eyelid deformity'
      ],
      "13": [
        AppLocalizations.of(context).translate('periorbital edema'),
        'periorbital edema'
      ],
      "15": [AppLocalizations.of(context).translate('dry eye'), 'dry eye'],
      "10": [
        AppLocalizations.of(context).translate('eye discharge'),
        'eye discharge'
      ],
      "16": [
        AppLocalizations.of(context).translate('ophthalmoplegia'),
        'ophthalmoplegia'
      ],
      "1": [AppLocalizations.of(context).translate('open eye'), 'open eye'],
      "5": [AppLocalizations.of(context).translate('lid drop'), 'lid drop'],
      /*"11": [
        AppLocalizations.of(context).translate('eye itching'),
        'eye itching'
      ],*/
      "17": [
        AppLocalizations.of(context)
            .translate('other ophthalmological problems'),
        'other ophthalmological problems'
      ],
    };
    final breast = {
      "28": [
        AppLocalizations.of(context).translate('galactorrhea'),
        'galactorrhea'
      ],
      "19": [
        AppLocalizations.of(context).translate('gynecomastia'),
        'gynecomastia'
      ],
      "46": [
        AppLocalizations.of(context).translate('breast pain'),
        'breast pain'
      ],
      "55": [
        AppLocalizations.of(context).translate('breast discharge'),
        'breast discharge'
      ],
      "37": [
        AppLocalizations.of(context).translate('breast mass'),
        'breast mass'
      ],
      "73": [
        AppLocalizations.of(context).translate('breast skin lesion'),
        'breast skin lesion'
      ],
      "82": [
        AppLocalizations.of(context).translate('other breast problems'),
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

    return ResponsiveBuilder(builder: (context, sizingInformation) {
      double appBar;
      double appBarHeight;
      double containerWidth;
      double buttonHeight;
      double buttonWidth;
      double title;
      double subTitle;
      double floatingActionHeight;
      double upperInset;

      if (sizingInformation.deviceScreenType == DeviceScreenType.Mobile) {
        appBar = 25;
        appBarHeight = 50;
        containerWidth = displayWidth(context) * 0.85;
        title = displayWidth(context) * 0.045;
        subTitle = displayWidth(context) * 0.04;
        buttonHeight = displayHeight(context) * 0.05;
        buttonWidth = displayWidth(context) * 0.7;
        floatingActionHeight = 10;
        upperInset = 25;
      } else {
        appBar = displayHeight(context) * 0.045;
        appBarHeight = 75;
        containerWidth = displayWidth(context) * 0.5;
        title = displayWidth(context) * 0.035;
        subTitle = displayWidth(context) * 0.025;
        buttonHeight = displayHeight(context) * 0.04;
        buttonWidth = displayWidth(context) * 0.4;
        floatingActionHeight = 50.0;
        upperInset = 50;
      }
      return Scaffold(
        resizeToAvoidBottomInset: false,
        key: _scaffoldkey,
        backgroundColor: Colors.grey[200],
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(appBarHeight),
          child: AppBar(
            backgroundColor: Colors.deepOrange,
            title: Text(
              AppLocalizations.of(context).translate('patient_complain'),
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: appBar),
            ),
            centerTitle: true,
            elevation: 0,
          ),
        ),
        floatingActionButton: Padding(
          padding: EdgeInsets.only(bottom: floatingActionHeight),
          child: Container(
            height: buttonHeight,
            width: buttonWidth,
            child: FloatingActionButton.extended(
              icon: Icon(
                Icons.arrow_forward,
                color: Colors.white,
              ),
              elevation: 0.0,
              backgroundColor: Colors.deepOrange,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(80.0)),
              onPressed: () {
                //print(_age);
                if (_age == '') {
                  setState(() {
                    _error = AppLocalizations.of(context)
                        .translate("age_message"); //'Please , enter your age';
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
                  if (radioSelect == '') {
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
              label: Text(AppLocalizations.of(context).translate('next'),
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: title,
                      fontWeight: FontWeight.bold)),
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: Center(
          child: Padding(
            padding: EdgeInsets.only(top: upperInset),
            child: Container(
              width: containerWidth,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: ListView(
                      children: [
                        Container(
                          decoration: boxDecoration,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Center(
                                  child: Text(
                                    AppLocalizations.of(context).translate(
                                      'age_gender',
                                    ),
                                    style: TextStyle(
                                      fontSize: title,
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
                                      keyboardType:
                                          TextInputType.numberWithOptions(
                                              decimal: true),
                                      inputFormatters: [
                                        FilteringTextInputFormatter.allow(
                                            RegExp('[0-9.,]')),
                                      ],
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
                                      decoration: textInputdecoration.copyWith(
                                        hintText: AppLocalizations.of(context)
                                            .translate(
                                          'age',
                                        ),
                                        hintStyle:
                                            TextStyle(fontSize: subTitle),
                                        prefixIcon: Icon(
                                          Icons.person_search,
                                          color: Colors.deepOrange,
                                        ),
                                        filled: true,
                                      )),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Flexible(
                                      fit: FlexFit.loose,
                                      child: RadioListTile(
                                        title: Text(
                                          AppLocalizations.of(context)
                                              .translate('male'),
                                          style: _textStylePatient.copyWith(
                                              fontSize: subTitle),
                                        ),
                                        activeColor: Colors.deepOrange,
                                        value: radioGender[0],
                                        groupValue: radioSelect,
                                        onChanged: (value) {
                                          setState(() {
                                            radioSelect = value;
                                          });
                                        },
                                      ),
                                    ),
                                    Flexible(
                                        fit: FlexFit.loose,
                                        child: RadioListTile(
                                          title: Text(
                                            AppLocalizations.of(context)
                                                .translate('female'),
                                            style: _textStylePatient.copyWith(
                                                fontSize: subTitle),
                                          ),
                                          activeColor: Colors.deepOrange,
                                          value: radioGender[1],
                                          groupValue: radioSelect,
                                          onChanged: (value) {
                                            setState(() {
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
                          decoration: boxDecoration,
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              children: [
                                Center(
                                  child: Container(
                                    child: FittedBox(
                                      fit: BoxFit.fitWidth,
                                      child: Text(
                                        AppLocalizations.of(context)
                                            .translate('main_complain'),
                                        style: TextStyle(
                                            fontSize: title,
                                            fontWeight: FontWeight.bold),
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
                                      child: Text(AppLocalizations.of(context)
                                          .translate('heart_lung')),
                                    ),
                                    DropdownMenuItem<String>(
                                      value: "gastroIntestinal",
                                      child: Text(AppLocalizations.of(context)
                                          .translate('git')),
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
                                      child: Text(AppLocalizations.of(context)
                                          .translate('Hand')),
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
                                      child: Text(AppLocalizations.of(context)
                                          .translate('nose')),
                                    ),
                                    DropdownMenuItem<String>(
                                      value: "entEar",
                                      child: Text(AppLocalizations.of(context)
                                          .translate('ear')),
                                    ),
                                    DropdownMenuItem<String>(
                                      value: "ophthalmology",
                                      child: Text(AppLocalizations.of(context)
                                          .translate('eye')),
                                    ),
                                    DropdownMenuItem<String>(
                                      value: "dermatology",
                                      child: Text(AppLocalizations.of(context)
                                          .translate('skin')),
                                    ),
                                    DropdownMenuItem<String>(
                                      value: "uroKidney",
                                      child: Text(AppLocalizations.of(context)
                                          .translate('uro')),
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
                                          .translate(
                                              'injuriesSuicideIntoxicationBurn')),
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
                                  onChanged: disabledropdown01
                                      ? null
                                      : (value) => secondselected(value),
                                  hint: Text(
                                    complainSelected01 == null
                                        ? AppLocalizations.of(context)
                                            .translate('choose_complain')
                                        : AppLocalizations.of(context)
                                            .translate(complainSelected01),
                                    style: TextStyle(
                                        color: complainSelected01 == null
                                            ? Colors.grey[700]
                                            : Colors.black),
                                  ),
                                  disabledHint: Text(
                                      AppLocalizations.of(context)
                                          .translate('first_choose_complain')),
                                ),
                                SwitchListTile(
                                    activeColor: Colors.deepOrange,
                                    dense: true,
                                    title: AutoSizeText(
                                      AppLocalizations.of(context)
                                          .translate('other_complain'),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: subTitle),
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
                            decoration: boxDecoration,
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
                                            fontSize: title,
                                            fontWeight: FontWeight.bold),
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
                                        child: Text(AppLocalizations.of(context)
                                            .translate('git')),
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
                                        child: Text(AppLocalizations.of(context)
                                            .translate('Hand')),
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
                                        child: Text(AppLocalizations.of(context)
                                            .translate('nose')),
                                      ),
                                      DropdownMenuItem<String>(
                                        value: "entEar",
                                        child: Text(AppLocalizations.of(context)
                                            .translate('ear')),
                                      ),
                                      DropdownMenuItem<String>(
                                        value: "ophthalmology",
                                        child: Text(AppLocalizations.of(context)
                                            .translate('eye')),
                                      ),
                                      DropdownMenuItem<String>(
                                        value: "dermatology",
                                        child: Text(AppLocalizations.of(context)
                                            .translate('skin')),
                                      ),
                                      DropdownMenuItem<String>(
                                        value: "uroKidney",
                                        child: Text(AppLocalizations.of(context)
                                            .translate('uro')),
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
                                        value:
                                            "injuriesSuicideIntoxicationBurn",
                                        child: Text(AppLocalizations.of(context)
                                            .translate(
                                                'injuriesSuicideIntoxicationBurn')),
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
                                    hint: Text(
                                      complainSelected02 == null
                                          ? AppLocalizations.of(context)
                                              .translate('choose_complain')
                                          : AppLocalizations.of(context)
                                              .translate(complainSelected02),
                                      style: TextStyle(
                                          color: complainSelected02 == null
                                              ? Colors.grey[700]
                                              : Colors.black),
                                    ),
                                    disabledHint: Text(
                                        AppLocalizations.of(context).translate(
                                            'first_choose_complain')),
                                  ),
                                  SwitchListTile(
                                      activeColor: Colors.deepOrange,
                                      dense: true,
                                      title: AutoSizeText(
                                        AppLocalizations.of(context)
                                            .translate('other_complain'),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: subTitle),
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
                            decoration: boxDecoration,
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
                                            fontSize: title,
                                            fontWeight: FontWeight.bold),
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
                                        child: Text(AppLocalizations.of(context)
                                            .translate('git')),
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
                                        child: Text(AppLocalizations.of(context)
                                            .translate('Hand')),
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
                                        child: Text(AppLocalizations.of(context)
                                            .translate('nose')),
                                      ),
                                      DropdownMenuItem<String>(
                                        value: "entEar",
                                        child: Text(AppLocalizations.of(context)
                                            .translate('ear')),
                                      ),
                                      DropdownMenuItem<String>(
                                        value: "ophthalmology",
                                        child: Text(AppLocalizations.of(context)
                                            .translate('eye')),
                                      ),
                                      DropdownMenuItem<String>(
                                        value: "dermatology",
                                        child: Text(AppLocalizations.of(context)
                                            .translate('skin')),
                                      ),
                                      DropdownMenuItem<String>(
                                        value: "uroKidney",
                                        child: Text(AppLocalizations.of(context)
                                            .translate('uro')),
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
                                        value:
                                            "injuriesSuicideIntoxicationBurn",
                                        child: Text(AppLocalizations.of(context)
                                            .translate(
                                                'injuriesSuicideIntoxicationBurn')),
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
                                    hint: Text(
                                      complainSelected03 == null
                                          ? AppLocalizations.of(context)
                                              .translate('choose_complain')
                                          : AppLocalizations.of(context)
                                              .translate(complainSelected03),
                                      style: TextStyle(
                                          color: complainSelected03 == null
                                              ? Colors.grey[700]
                                              : Colors.black),
                                    ),
                                    disabledHint: Text(
                                        AppLocalizations.of(context).translate(
                                            'first_choose_complain')),
                                  ),
                                  SwitchListTile(
                                      activeColor: Colors.deepOrange,
                                      dense: true,
                                      title: AutoSizeText(
                                        AppLocalizations.of(context)
                                            .translate('other_complain'),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: subTitle),
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
                            decoration: boxDecoration,
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
                                            fontSize: title,
                                            fontWeight: FontWeight.bold),
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
                                        child: Text(AppLocalizations.of(context)
                                            .translate('git')),
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
                                        child: Text(AppLocalizations.of(context)
                                            .translate('Hand')),
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
                                        child: Text(AppLocalizations.of(context)
                                            .translate('nose')),
                                      ),
                                      DropdownMenuItem<String>(
                                        value: "entEar",
                                        child: Text(AppLocalizations.of(context)
                                            .translate('ear')),
                                      ),
                                      DropdownMenuItem<String>(
                                        value: "ophthalmology",
                                        child: Text(AppLocalizations.of(context)
                                            .translate('eye')),
                                      ),
                                      DropdownMenuItem<String>(
                                        value: "dermatology",
                                        child: Text(AppLocalizations.of(context)
                                            .translate('skin')),
                                      ),
                                      DropdownMenuItem<String>(
                                        value: "uroKidney",
                                        child: Text(AppLocalizations.of(context)
                                            .translate('uro')),
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
                                        value:
                                            "injuriesSuicideIntoxicationBurn",
                                        child: Text(AppLocalizations.of(context)
                                            .translate(
                                                'injuriesSuicideIntoxicationBurn')),
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
                                    hint: Text(
                                      complainSelected04 == null
                                          ? AppLocalizations.of(context)
                                              .translate('choose_complain')
                                          : AppLocalizations.of(context)
                                              .translate(complainSelected04),
                                      style: TextStyle(
                                          color: complainSelected04 == null
                                              ? Colors.grey[700]
                                              : Colors.black),
                                    ),
                                    disabledHint: Text(
                                        AppLocalizations.of(context).translate(
                                            'first_choose_complain')),
                                  ),
                                  SwitchListTile(
                                      activeColor: Colors.deepOrange,
                                      dense: true,
                                      title: AutoSizeText(
                                        AppLocalizations.of(context)
                                            .translate('other_complain'),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: subTitle),
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
                            decoration: boxDecoration,
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
                                            fontSize: title,
                                            fontWeight: FontWeight.bold),
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
                                        child: Text(AppLocalizations.of(context)
                                            .translate('git')),
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
                                        child: Text(AppLocalizations.of(context)
                                            .translate('Hand')),
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
                                        child: Text(AppLocalizations.of(context)
                                            .translate('nose')),
                                      ),
                                      DropdownMenuItem<String>(
                                        value: "entEar",
                                        child: Text(AppLocalizations.of(context)
                                            .translate('ear')),
                                      ),
                                      DropdownMenuItem<String>(
                                        value: "ophthalmology",
                                        child: Text(AppLocalizations.of(context)
                                            .translate('eye')),
                                      ),
                                      DropdownMenuItem<String>(
                                        value: "dermatology",
                                        child: Text(AppLocalizations.of(context)
                                            .translate('skin')),
                                      ),
                                      DropdownMenuItem<String>(
                                        value: "uroKidney",
                                        child: Text(AppLocalizations.of(context)
                                            .translate('uro')),
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
                                        value:
                                            "injuriesSuicideIntoxicationBurn",
                                        child: Text(AppLocalizations.of(context)
                                            .translate(
                                                'injuriesSuicideIntoxicationBurn')),
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
                                    hint: Text(
                                      complainSelected05 == null
                                          ? AppLocalizations.of(context)
                                              .translate('choose_complain')
                                          : AppLocalizations.of(context)
                                              .translate(complainSelected05),
                                      style: TextStyle(
                                          color: complainSelected05 == null
                                              ? Colors.grey[700]
                                              : Colors.black),
                                    ),
                                    disabledHint: Text(
                                        AppLocalizations.of(context).translate(
                                            'first_choose_complain')),
                                  ),
                                  SwitchListTile(
                                      activeColor: Colors.deepOrange,
                                      dense: true,
                                      title: AutoSizeText(
                                        AppLocalizations.of(context)
                                            .translate('other_complain'),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: subTitle),
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
                            decoration: boxDecoration,
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
                                            fontSize: title,
                                            fontWeight: FontWeight.bold),
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
                                        child: Text(AppLocalizations.of(context)
                                            .translate('git')),
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
                                        child: Text(AppLocalizations.of(context)
                                            .translate('Hand')),
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
                                        child: Text(AppLocalizations.of(context)
                                            .translate('nose')),
                                      ),
                                      DropdownMenuItem<String>(
                                        value: "entEar",
                                        child: Text(AppLocalizations.of(context)
                                            .translate('ear')),
                                      ),
                                      DropdownMenuItem<String>(
                                        value: "ophthalmology",
                                        child: Text(AppLocalizations.of(context)
                                            .translate('eye')),
                                      ),
                                      DropdownMenuItem<String>(
                                        value: "dermatology",
                                        child: Text(AppLocalizations.of(context)
                                            .translate('skin')),
                                      ),
                                      DropdownMenuItem<String>(
                                        value: "uroKidney",
                                        child: Text(AppLocalizations.of(context)
                                            .translate('uro')),
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
                                        value:
                                            "injuriesSuicideIntoxicationBurn",
                                        child: Text(AppLocalizations.of(context)
                                            .translate(
                                                'injuriesSuicideIntoxicationBurn')),
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
                                    hint: Text(
                                      complainSelected06 == null
                                          ? AppLocalizations.of(context)
                                              .translate('choose_complain')
                                          : AppLocalizations.of(context)
                                              .translate(complainSelected06),
                                      style: TextStyle(
                                          color: complainSelected06 == null
                                              ? Colors.grey[700]
                                              : Colors.black),
                                    ),
                                    disabledHint: Text(
                                        AppLocalizations.of(context).translate(
                                            'first_choose_complain')),
                                  ),
                                  SwitchListTile(
                                      activeColor: Colors.deepOrange,
                                      dense: true,
                                      title: AutoSizeText(
                                        AppLocalizations.of(context)
                                            .translate('other_complain'),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: subTitle),
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
                            decoration: boxDecoration,
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
                                            fontSize: title,
                                            fontWeight: FontWeight.bold),
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
                                        child: Text(AppLocalizations.of(context)
                                            .translate('git')),
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
                                        child: Text(AppLocalizations.of(context)
                                            .translate('Hand')),
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
                                        child: Text(AppLocalizations.of(context)
                                            .translate('nose')),
                                      ),
                                      DropdownMenuItem<String>(
                                        value: "entEar",
                                        child: Text(AppLocalizations.of(context)
                                            .translate('ear')),
                                      ),
                                      DropdownMenuItem<String>(
                                        value: "ophthalmology",
                                        child: Text(AppLocalizations.of(context)
                                            .translate('eye')),
                                      ),
                                      DropdownMenuItem<String>(
                                        value: "dermatology",
                                        child: Text(AppLocalizations.of(context)
                                            .translate('skin')),
                                      ),
                                      DropdownMenuItem<String>(
                                        value: "uroKidney",
                                        child: Text(AppLocalizations.of(context)
                                            .translate('uro')),
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
                                        value:
                                            "injuriesSuicideIntoxicationBurn",
                                        child: Text(AppLocalizations.of(context)
                                            .translate(
                                                'injuriesSuicideIntoxicationBurn')),
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
                                    hint: Text(
                                      complainSelected07 == null
                                          ? AppLocalizations.of(context)
                                              .translate('choose_complain')
                                          : AppLocalizations.of(context)
                                              .translate(complainSelected07),
                                      style: TextStyle(
                                          color: complainSelected07 == null
                                              ? Colors.grey[700]
                                              : Colors.black),
                                    ),
                                    disabledHint: Text(
                                        AppLocalizations.of(context).translate(
                                            'first_choose_complain')),
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
    });
  }
}
