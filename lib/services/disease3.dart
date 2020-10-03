import 'package:project_doctor/services/finalscore.dart';

class disease3 {
  String name;
  String sym1;
  String sym2;
  String sym3;
  String sym4;
  String rf1;
  String rf2;
  String rf3;
  String rf4;
  disease3(this.name, this.sym1, this.sym2, this.sym3, this.sym4, this.rf1,
      this.rf2, this.rf3, this.rf4);
}

maindisease3(
    String cc,
    String s2,
    String s3,
    String s4,
    String s5,
    String s6,
    String s7,
    String c1,
    String c2,
    String c3,
    String c4,
    String c5,
    String c6,
    String c7,
    String c8,
    String c9,
    String c10,
    String c11,
    String c12,
    String c13,
    String c14,
    String c15,
    String preg,
    String ob,
    String inact,
    String fam,
    String alcohol,
    String smok) {
  var acs = disease3('ACS', 'chest pain', 'left arm pain', 'jaw pain',
      'abdominal pain', 'smoking', 'alcoholism', 'DM', 'HTN');
  var acs2 = disease3('ACS', 'dyspnea', 'vomiting', 'sweating', 'palpitation',
      'syncope', 'family history', 'obesity', 'physical inactivity');
  var acs3 = disease3('ACS', 'neck pain', 'left shoulder pain', 'hiccough',
      'null', 'male', 'null', 'null', 'null');
  var hf = disease3(
    'pulmonary edema',
    'dyspnea',
    'cough',
    'sputum',
    'orthopnea',
    'HTN',
    'pregnancy',
    'DM',
    'alcoholism',
  );
  var hf2 = disease3(
      'pulmonary edema',
      'bilaterl leg edema',
      'palpitation',
      'PN dyspnea',
      'heamoptysis',
      'family history',
      'chronic heart disease',
      'physical inactivity',
      'smoking');
  var erhtn = disease3(
      'ER hypertension',
      'systolic BP > 180',
      'diastolic BP > 100',
      'null',
      'null',
      'alcoholism',
      'obesity',
      'physical inactivity',
      'family history');
  var shock = disease3('shock', 'systolic BP < 90', 'diastolic BP < 60',
      'PR > 100', 'PR < 60', 'null', 'null', 'null', 'null');
  var arrhythm = disease3('arrhytmia', 'palpitation', 'null', 'syncope', 'null',
      'syncope', 'null', 'null', 'null');
  var effussion = disease3('pericardial effusion', 'dyspnea', 'palpitation',
      'null', 'null', 'connective tissue disease', 'null', 'null', 'null');

  var asthma = disease3('asthma', 'dyspnea', 'cough', 'wheeze', 'null',
      'family history', 'null', 'chronic lung disease', 'asthma');
  var copd = disease3('COPD', 'dyspnea', 'cough', 'sputum', 'heamoptysis',
      'wheeze', 'smoking', 'chronic lung disease', 'copd');
  var pneumo = disease3('pneumothorax', 'dyspnea', 'systolic BP < 90',
      'diastolic BP < 60', 'PR > 100', 'cyanosis', 'cyanosis', 'null', 'null');

  var diabetic = disease3('diabetic ER', 'RBS > 200', 'RBS < 55', 'dyspnea',
      'abdominal pain', 'vomiting', 'nausea', 'DM', 'CKD');
  var diabetic2 = disease3('diabetic ER', 'confusion', 'coma', 'polyuria',
      'polydepsia', 'null', 'null', 'pregnancy', 'null');

  var ugib = disease3('upper gi bleeding', 'heamatemesis', 'malena',
      'abdominal pain', 'null', 'null', 'liver disease', 'null', 'null');

  var seizure = disease3('seizure', 'fit', 'fit', 'coma', 'confusion',
      'confusion', 'DM', 'HTN', 'epilepsy');
  var dloc = disease3('DLOC', 'coma', 'coma', 'confusion', 'confusion', 'coma',
      'null', 'null', 'null');
  var ich = disease3('ICH', 'headache', 'vomiting', 'weakness', 'numbness',
      'coma', 'ataxia', 'HTN', 'null');

  var intox = disease3('intoxication', 'intoxication', 'intoxication',
      'suicide', 'suicide', 'suicide', 'null', 'null', 'null');

  var trauma = disease3('trauma', 'FFH', 'RTA', 'stab', 'shot',
      'other injuries', 'null', 'null', 'null');
  var uro = disease3('urological ER', 'scrotal pain', 'scrotal pain',
      'priapism', 'praipism', 'null', 'null', 'null', 'null');

  var internist = disease3('internist', 'fever', 'fatigue', 'weight loss',
      'anorexia', 'insomnia', 'weight gain', 'somnlence', 'malaise');
  var internist2 = disease3('internist', 'fever', 'fatigue', 'weight loss',
      'anorexia', 'insomnia', 'weight gain', 'somnlence', 'malaise');
  var internist3 = disease3(
      'internist',
      'other health problems',
      'other health problems',
      'disease of the mouth',
      'disease of the mouth',
      'null',
      'null',
      'null',
      'null');
  var internist4 = disease3('internist', 'fever', 'fatigue', 'weight loss',
      'anorexia', 'insomnia', 'weight gain', 'somnlence', 'malaise');

  var emrg = [
    acs,
    acs2,
    acs3,
    hf,
    hf2,
    erhtn,
    shock,
    arrhythm,
    effussion,
    asthma,
    copd,
    pneumo,
    diabetic,
    diabetic2,
    ugib,
    seizure,
    dloc,
    ich,
    intox,
    trauma,
    uro
  ];
  var e = 0;
  var ee = emrg.length;
  var emsym = [
    emrg[e].sym1,
    emrg[e].sym2,
    emrg[e].sym3,
    emrg[e].sym4,
    emrg[e].rf1,
    emrg[e].rf2,
    emrg[e].rf3,
    emrg[e].rf4
  ];
  var emkey = 0;
  var emlen = emsym.length;

  var inter = [internist, internist2, internist3, internist4];
  var i = 0;
  var ii = inter.length;
  var intsym = [
    inter[i].sym1,
    inter[i].sym2,
    inter[i].sym3,
    inter[i].sym4,
    inter[i].rf1,
    inter[i].rf2,
    inter[i].rf3,
    inter[i].rf4
  ];
  var intkey = 0;
  var intlen = intsym.length;

  var chiefcom = cc;
  var others = [s2, s3, s4, s5, s6, s7];
  var o = 0;
  var oo = others.length;
  var riskf = [
    c1,
    c2,
    c3,
    c4,
    c5,
    c6,
    c7,
    c8,
    c9,
    c10,
    c11,
    c12,
    c13,
    c14,
    c15,
    preg,
    ob,
    fam,
    inact,
    smok,
    alcohol
  ];
  var r = 0;
  var rr = riskf.length;

  var emscore = 0;
  var intscore = 0;

  while (ee > 0) {
    while (emlen > 0) {
      if (chiefcom == emsym[emkey]) {
        emscore += 10;
      }
      while (oo > 0) {
        if (others[o] == emsym[emkey]) {
          emscore += 1;
        }
        o += 1;
        oo -= 1;
      }
      while (rr > 0) {
        if (riskf[r] == emsym[emkey]) {
          emscore += 1;
        }
        r += 1;
        rr -= 1;
      }
      o = 0;
      oo = others.length;
      r = 0;
      rr = riskf.length;
      emlen -= 1;
      emkey += 1;
    }
    e += 1;
    ee -= 1;
    if (ee > 0) {
      emsym = [
        emrg[e].sym1,
        emrg[e].sym2,
        emrg[e].sym3,
        emrg[e].sym4,
        emrg[e].rf1,
        emrg[e].rf2,
        emrg[e].rf3,
        emrg[e].rf4
      ];
      emkey = 0;
      emlen = emsym.length;
    }
  }
  while (ii > 0) {
    while (intlen > 0) {
      if (chiefcom == intsym[intkey]) {
        intscore += 10;
      }
      while (oo > 0) {
        if (others[o] == intsym[intkey]) {
          intscore += 1;
        }
        o += 1;
        oo -= 1;
      }
      while (rr > 0) {
        if (riskf[r] == intsym[intkey]) {
          intscore += 1;
        }
        r += 1;
        rr -= 1;
      }
      o = 0;
      oo = others.length;
      r = 0;
      rr = riskf.length;
      intlen -= 1;
      intkey += 1;
    }
    i += 1;
    ii -= 1;
    if (ii > 0) {
      intsym = [
        inter[i].sym1,
        inter[i].sym2,
        inter[i].sym3,
        inter[i].sym4,
        inter[i].rf1,
        inter[i].rf2,
        inter[i].rf3,
        inter[i].rf4
      ];
      intkey = 0;
      intlen = intsym.length;
    }
  }
  print(emscore);
  print(intscore);
  finalscore.erscore=emscore;
  finalscore.internscore=intscore;
}
