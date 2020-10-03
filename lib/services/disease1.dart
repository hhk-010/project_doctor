import 'package:project_doctor/services/finalscore.dart';

class disease1 {
  String name;
  String symp1;
  String symp2;
  String symp3;
  String symp4;
  String rf1;
  String rf2;
  String rf3;
  String rf4;

  disease1(
    this.name,
    this.symp1,
    this.symp2,
    this.symp3,
    this.symp4,
    this.rf1,
    this.rf2,
    this.rf3,
    this.rf4,
  );
}

maindisease1(
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
  var acs = disease1('acs', 'chest pain', 'dyspnea', 'vomiting', 'palpitation',
      'smoking', 'family history', 'DM', 'HTN');
  var acs2 = disease1(
      'acs',
      'left shoulder pain',
      'jaw pain',
      'left arm pain',
      'neck pain',
      'abdominal pain',
      'obesity',
      'physical inactivity',
      'alcoholism');
  var acs3 = disease1('acs', 'hiccough', 'sweating', 'null', 'null', 'male',
      'null', 'null', 'null');
  var hf = disease1(
    'heart failure',
    'dysnea',
    'cough',
    'sputum',
    'orthopnea',
    'HTN',
    'pregnancy',
    'DM',
    'alcoholism',
  );
  var hf2 = disease1(
      'heart failure',
      'bilaterl leg edema',
      'palpitation',
      'PN dyspnea',
      'heamoptysis',
      'family history',
      'chronic heart disease',
      'physical inactivity',
      'smoking');
  var htn = disease1(
      'hypertension',
      'systolic BP > 140',
      'diastolic BP > 90',
      'null',
      'null',
      'alcoholism',
      'obesity',
      'physical inactivity',
      'family history');
  var arrhythm = disease1('arrhythmia', 'palpitation', 'null', 'null', 'null',
      'null', 'null', 'null', 'null');
  var dcm = disease1(
      'dilated cardiomyopathy',
      'dyspnea',
      'orthopnea',
      'PN dyspnea',
      'bilateral leg edema',
      'chest pain',
      'palpitation',
      'family history',
      'connective tissue disease');
  var hocm = disease1('HOCM', 'chest pain', 'syncope', 'dyspnea', 'null',
      'family history', 'connective tissue disease', 'null', 'null');
  var rcm = disease1(
      'restrictive cardiomyopathy',
      'dyspnea',
      'bilateral leg edema',
      'palpitation',
      'null',
      'null',
      'null',
      'null',
      'null');
  var pericard = disease1('pericarditis', 'chest pain', 'fever', 'null', 'null',
      'null', 'null', 'null', 'connective tissue disease');
  var effusion = disease1('pericardial effusion', 'dyspnea', 'palpitation',
      'null', 'null', 'connective tissue disease', 'null', 'null', 'null');
  var cperi = disease1('constrictive pericarditis', 'bilateral leg edema',
      'dyspnea', 'palpitation', 'null', 'null', 'null', 'null', 'null');
  var thoraneu = disease1('thoracic aortic aneurysm', 'chest pain', 'dyspnea',
      'null', 'null', 'HTN', 'family history', 'null', 'null');
  var aodisc = disease1('aortic dissection', 'chest pain', 'null', 'null',
      'null', 'HTN', 'family history', 'pregnancy', 'null');
  var mvd = disease1('mitral valve disease', 'dyspnea', 'cough', 'sputum',
      'palpitation', 'family history', 'null', 'null', 'null');
  var mvd2 = disease1(
      'mitral valve disease',
      'chest pain',
      'bilateral leg edema',
      'heamoptysis',
      'null',
      'null',
      'null',
      'null',
      'null');
  var avd = disease1('aortic valve disease', 'dyspnea', 'chest pain', 'syncope',
      'palpitation', 'null', 'PN dyspnea', 'null', 'connective tissue disease');
  var tricasp = disease1('tricasped valve disease', 'bilateral leg edema',
      'null', 'null', 'null', 'null', 'null', 'null', 'null');
  var achd = disease1('congenital heart disease', 'dyspnea', 'cough', 'sputum',
      'fever', 'palpitation', 'null', 'null', 'null');
  var endocar = disease1('endocarditis', 'bilateral leg edema', 'cough',
      'sputum', 'dyspnea', 'fever', 'CKD', 'null', 'null');
  var tof = disease1('TOF', 'dyspnea', 'cyanosis', 'null', 'null', 'null',
      'null', 'null', 'other cardiac problems');
  //myocarditis will be left to the internist

  var asthma = disease1('asthma', 'dyspnea', 'cough', 'wheeze', 'null',
      'family history', 'asthma', 'null', 'null');
  var copd = disease1('COPD', 'dyspnea', 'cough', 'sputum', 'heamoptysis',
      'wheeze', 'smoking', 'chronic lung disease', 'copd');
  var pneumonia = disease1('pneumonia', 'dyspnea', 'fever', 'cough', 'sputum',
      'alcoholism', 'smoking', 'chronic lung disease', 'CVA');
  var pneumonia2 = disease1('pneumonia', 'heamoptysis', 'chest pain', 'null',
      'null', 'null', 'null', 'null', 'null');
  var pleura = disease1(
      'pleural effussion',
      'dyspnea',
      'chest pain',
      'fever',
      'null',
      'CKD',
      'malignancy',
      'heart failure',
      'connective tissue disease');
  var pleura2 = disease1('empyema', 'dyspnea', 'chest pain', 'fever', 'null',
      'null', 'null', 'null', 'null');
  var pleura3 = disease1('pneumothorax', 'dyspnea', 'chest pain', 'cyanosis',
      'palpitation', 'malignancy', 'chronic lung disease', 'null', 'null');
  var bronc = disease1(
      'broncheictasis',
      'fever',
      'cough',
      'sputum',
      'dyspnea',
      'heamoptysis',
      'null',
      'connective tissue disease',
      'chronic lung disease');
  var calung = disease1('ca lung', 'dyspnea', 'cough', 'sputum', 'heamoptysis',
      'smoking', 'copd', 'chest pain', 'hoarseness');
  var ards = disease1('ARDS', 'dyspnea', 'cough', 'sputum', 'heamoptysis',
      'cyanosis', 'null', 'null', 'null');
  var pe = disease1('pulmonary embolism', 'dyspnea', 'chest pain',
      'heamoptysis', 'null', 'pregnancy', 'null', 'null', 'null');
  var ild = disease1('interstitial lung disease', 'dyspnea', 'cough', 'fever',
      'null', 'null', 'null', 'null', 'null');
  var ild2 = disease1('interstitial lung disease', 'dyspnea', 'cough', 'fever',
      'null', 'null', 'null', 'null', 'null');
  var ild3 = disease1('interstitial lung disease', 'dyspnea', 'cough', 'fever',
      'sputum', 'null', 'null', 'null', 'other respiratory problems');

  var dm = disease1('DM', 'polyuria', 'polydepsia', 'polyphagia', 'weight loss',
      'weight gain', 'family history', 'obesity', 'physical inactivity');
  var dm2 = disease1('DM', 'polyuria', 'polydepsia', 'null', 'null', 'null',
      'pregnancy', 'null', 'null');
  var thyrotoxicosis = disease1('thyrotoxicosis', 'palpitation', 'sweating',
      'tremer', 'insomnia', 'previous goitre', 'null', 'null', 'null');
  var thyrotoxicosis2 = disease1('thyrotoxicosis', 'weight loss', 'polyphagia',
      'heat sensation', 'null', 'null', 'null', 'null', 'null');
  var hypothyroidism = disease1(
      'hypothyroidism',
      'weight gain',
      'cold sensation',
      'anorexia',
      'somnlence',
      'dry skin',
      'menorrhagia',
      'null',
      'dry hair');
  var hypothyroidism2 = disease1('hypothyroidism', 'constipation', 'hoarseness',
      'bilateral leg edema', 'null', 'null', 'null', 'null', 'null');
  var acromeg = disease1('acromegally', 'enlarged hand', 'enlarged foot',
      'enlarged nose', 'enlarged jaw', 'null', 'null', 'null', 'null');
  var dwarf = disease1('dwarfisim', 'short stature', 'weight gain', 'null',
      'null', 'null', 'null', 'null', 'null');
  var prolac = disease1(
      'prolactinemia',
      'galactorrhea',
      'amenorrhea',
      'oligomenorrhea',
      'gynecomastia',
      'female hirsuitism',
      'decrease libido',
      'male infertility',
      'female infertility');
  var dinsip = disease1('diabetes insipdus', 'polyuria', 'polydepsia', 'null',
      'null', 'null', 'null', 'null', 'null');
  var hyperpth = disease1('hyperparathyroidism', 'polyuria', 'polydepsia',
      'bone pain', 'null', 'null', 'null', 'null', 'null');
  var malerep = disease1('male reproductive problems', 'delayed puberty',
      'gynecomastia', 'null', 'null', 'null', 'null', 'null', 'null');
  var pcos = disease1('PCOS', 'menorrhagia', 'female hirsuitism',
      'female infertility', 'weight gain', 'null', 'null', 'null', 'null');
  var cushing = disease1('cushing', 'weight gain', 'straie', 'weight gain',
      'female hirsuitism', 'null', 'null', 'null', 'null');
  var cah = disease1('CAH', 'female hirsuitism', 'null', 'null', 'null', 'null',
      'null', 'null', 'null');

  var cvs = [
    acs,
    acs2,
    acs3,
    hf,
    hf2,
    htn,
    arrhythm,
    dcm,
    hocm,
    rcm,
    pericard,
    effusion,
    cperi,
    thoraneu,
    aodisc,
    mvd,
    mvd2,
    avd,
    tricasp,
    achd,
    endocar,
    tof
  ];
  var resp = [
    asthma,
    copd,
    pneumonia,
    pneumonia2,
    pleura,
    pleura2,
    pleura3,
    bronc,
    calung,
    ards,
    pe,
    ild,
    ild2,
    ild3
  ];
  var endo = [
    dm,
    dm2,
    thyrotoxicosis,
    thyrotoxicosis2,
    hypothyroidism,
    hypothyroidism2,
    acromeg,
    dwarf,
    prolac,
    dinsip,
    hyperpth,
    malerep,
    pcos,
    cushing,
    cah
  ];
  var i = 0;
  var ii = cvs.length;
  var j = 0;
  var jj = resp.length;
  var e = 0;
  var ee = endo.length;
  var cvssym = [
    cvs[i].symp1,
    cvs[i].symp2,
    cvs[i].symp3,
    cvs[i].symp4,
    cvs[i].rf1,
    cvs[i].rf2,
    cvs[i].rf3,
    cvs[i].rf4
  ];
  var cvskey = 0;
  var cvslen = cvssym.length;
  var respsym = [
    resp[j].symp1,
    resp[j].symp2,
    resp[j].symp3,
    resp[j].symp4,
    resp[j].rf1,
    resp[j].rf2,
    resp[j].rf3,
    resp[j].rf4
  ];
  var respkey = 0;
  var resplen = respsym.length;
  var endosym = [
    endo[e].symp1,
    endo[e].symp2,
    endo[e].symp3,
    endo[e].symp4,
    endo[e].rf1,
    endo[e].rf2,
    endo[e].rf3,
    endo[e].rf4
  ];
  var endokey = 0;
  var endolen = endosym.length;
  var chiefcomp = cc;
  var others = [s2, s3, s4, s5, s6, s7];
  var o = 0;
  var oo = others.length;
  var riskf = [c1, c2, c3, preg, ob, fam, inact, alcohol, smok];
  var r = 0;
  var rr = riskf.length;
  var cvsscore = 0;
  var respscore = 0;
  var endoscore = 0;
  while (ii > 0) {
    while (cvslen > 0) {
      if (chiefcomp == cvssym[cvskey]) {
        cvsscore += 10;
      }
      //if(chiefcomp=='chest pain'||chiefcomp=='arm pain'||chiefcomp=='jaw pain'||chiefcomp=='shoulder pain'){
      //cvsscore+=4;
      //}
      while (oo > 0) {
        if (others[o] == cvssym[cvskey]) {
          cvsscore += 1;
        }
        o += 1;
        oo -= 1;
      }
      while (rr > 0) {
        //if (riskf[r]=='DM'||riskf[r]=='HTN'||riskf[r]=='family history'){
        //cvsscore+=2;
        //}
        if (riskf[r] == cvssym[cvskey]) {
          cvsscore += 1;
        }
        r += 1;
        rr -= 1;
      }
      cvslen -= 1;
      cvskey += 1;
      o = 0;
      oo = others.length;
      r = 0;
      rr = riskf.length;
    }
    i = i + 1;
    ii -= 1;
    if (ii > 0) {
      cvssym = [
        cvs[i].symp1,
        cvs[i].symp2,
        cvs[i].symp3,
        cvs[i].symp4,
        cvs[i].rf1,
        cvs[i].rf2,
        cvs[i].rf3,
        cvs[i].rf4
      ];
      cvskey = 0;
      cvslen = cvssym.length;
    }
  }
  while (jj > 0) {
    while (resplen > 0) {
      if (chiefcomp == respsym[respkey]) {
        respscore += 10;
      }
      while (oo > 0) {
        if (others[o] == respsym[respkey]) {
          respscore += 1;
        }
        o += 1;
        oo -= 1;
      }
      while (rr > 0) {
        if (riskf[r] == respsym[respkey]) {
          respscore += 1;
        }
        r += 1;
        rr -= 1;
      }
      o = 0;
      oo = others.length;
      r = 0;
      rr = riskf.length;
      resplen -= 1;
      respkey += 1;
    }
    j += 1;
    jj -= 1;
    if (jj > 0) {
      respsym = [
        resp[j].symp1,
        resp[j].symp2,
        resp[j].symp3,
        resp[j].symp4,
        resp[j].rf1,
        resp[j].rf2,
        resp[j].rf3,
        resp[j].rf4
      ];
      respkey = 0;
      resplen = respsym.length;
    }
  }
  while (ee > 0) {
    while (endolen > 0) {
      if (chiefcomp == endosym[endokey]) {
        endoscore += 10;
      }
      while (oo > 0) {
        if (others[o] == endosym[endokey]) {
          endoscore += 1;
        }
        o += 1;
        oo -= 1;
      }
      while (rr > o) {
        if (riskf[r] == endosym[endokey]) {
          endoscore += 1;
        }
        r += 1;
        rr -= 1;
      }
      o = 0;
      oo = others.length;
      r = 0;
      rr = riskf.length;
      endolen -= 1;
      endokey += 1;
    }
    e += 1;
    ee -= 1;
    if (ee > 0) {
      endosym = [
        endo[e].symp1,
        endo[e].symp2,
        endo[e].symp3,
        endo[e].symp4,
        endo[e].rf1,
        endo[e].rf2,
        endo[e].rf3,
        endo[e].rf4
      ];
      endokey = 0;
      endolen = endosym.length;
    }
  }
  print(cvsscore);
  print(endoscore);
  print(respscore);
  countfinal(cvsscore, respscore, endoscore);
}
