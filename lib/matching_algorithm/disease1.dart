import 'package:project_doctor/matching_algorithm/final_score.dart';

class Disease1 {
  String name;
  String symp1;
  String symp2;
  String symp3;
  String symp4;
  String rf1;
  String rf2;
  String rf3;
  String rf4;

  Disease1(
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
    String smok,
    String gender) {
  var acs = Disease1('acs', 'chest pain', 'dyspnea', 'vomiting', 'palpitation',
      'smoking', 'family history', 'DM', 'HTN');
  var acs2 = Disease1(
      'acs',
      'left shoulder pain',
      'jaw pain',
      'left arm pain',
      'neck pain',
      'abdominal pain',
      'obesity',
      'physical inactivity',
      'alcoholism');
  var acs3 = Disease1('acs', 'hiccough', 'sweating', 'null', 'null', 'male',
      'null', 'null', 'null');
  var hf = Disease1(
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
  var hf2 = Disease1(
      'heart failure',
      'bilateral leg edema',
      'palpitation',
      'PN dyspnea',
      'hemoptysis',
      'family history',
      'chronic heart disease',
      'physical inactivity',
      'smoking');
  var htn = Disease1(
      'hypertension',
      'systolic BP > 140',
      'diastolic BP > 90',
      'null',
      'null',
      'alcoholism',
      'obesity',
      'physical inactivity',
      'family history');
  var arrhythm = Disease1('arrhythmia', 'palpitation', 'null', 'null', 'null',
      'null', 'null', 'null', 'null');
  var dcm = Disease1(
      'dilated cardiomyopathy',
      'dyspnea',
      'orthopnea',
      'PN dyspnea',
      'bilateral leg edema',
      'chest pain',
      'palpitation',
      'family history',
      'connective tissue disease');
  var hocm = Disease1('HOCM', 'chest pain', 'syncope', 'dyspnea', 'null',
      'family history', 'connective tissue disease', 'null', 'null');
  var rcm = Disease1(
      'restrictive cardiomyopathy',
      'dyspnea',
      'bilateral leg edema',
      'palpitation',
      'null',
      'null',
      'null',
      'null',
      'null');
  var pericard = Disease1('pericarditis', 'chest pain', 'fever', 'null', 'null',
      'null', 'null', 'null', 'connective tissue disease');
  var effusion = Disease1('pericardial effusion', 'dyspnea', 'palpitation',
      'null', 'null', 'connective tissue disease', 'null', 'null', 'null');
  var cperi = Disease1('constrictive pericarditis', 'bilateral leg edema',
      'dyspnea', 'palpitation', 'null', 'null', 'null', 'null', 'null');
  var thoraneu = Disease1('thoracic aortic aneurysm', 'chest pain', 'dyspnea',
      'null', 'null', 'HTN', 'family history', 'null', 'null');
  var aodisc = Disease1('aortic dissection', 'chest pain', 'null', 'null',
      'null', 'HTN', 'family history', 'pregnancy', 'null');
  var mvd = Disease1('mitral valve disease', 'dyspnea', 'cough', 'sputum',
      'palpitation', 'family history', 'null', 'null', 'null');
  var mvd2 = Disease1(
      'mitral valve disease',
      'chest pain',
      'bilateral leg edema',
      'hemoptysis',
      'null',
      'null',
      'null',
      'null',
      'null');
  var avd = Disease1('aortic valve disease', 'dyspnea', 'chest pain', 'syncope',
      'palpitation', 'null', 'PN dyspnea', 'null', 'connective tissue disease');
  var tricasp = Disease1('tricasped valve disease', 'bilateral leg edema',
      'null', 'null', 'null', 'null', 'null', 'null', 'null');
  var achd = Disease1('congenital heart disease', 'dyspnea', 'cough', 'sputum',
      'fever', 'palpitation', 'null', 'null', 'null');
  var endocar = Disease1('endocarditis', 'bilateral leg edema', 'cough',
      'sputum', 'dyspnea', 'fever', 'CKD', 'null', 'null');
  var tof = Disease1('TOF', 'dyspnea', 'cyanosis', 'null', 'null', 'null',
      'null', 'null', 'other cardiac problems');
  //myocarditis will be left to the internist

  var asthma = Disease1('asthma', 'dyspnea', 'cough', 'wheeze', 'null',
      'family history', 'asthma', 'null', 'null');
  var copd = Disease1('COPD', 'dyspnea', 'cough', 'sputum', 'hemoptysis',
      'wheeze', 'smoking', 'chronic lung disease', 'copd');
  var pneumonia = Disease1('pneumonia', 'dyspnea', 'fever', 'cough', 'sputum',
      'alcoholism', 'smoking', 'chronic lung disease', 'CVA');
  var pneumonia2 = Disease1('pneumonia', 'hemoptysis', 'chest pain', 'null',
      'null', 'null', 'null', 'null', 'null');
  var pleura = Disease1(
      'pleural effusion',
      'dyspnea',
      'chest pain',
      'fever',
      'null',
      'CKD',
      'malignancy',
      'heart failure',
      'connective tissue disease');
  var pleura2 = Disease1('empyema', 'dyspnea', 'chest pain', 'fever', 'null',
      'null', 'null', 'null', 'null');
  var pleura3 = Disease1('pneumothorax', 'dyspnea', 'chest pain', 'cyanosis',
      'palpitation', 'malignancy', 'chronic lung disease', 'null', 'null');
  var bronc = Disease1(
      'broncheictasis',
      'fever',
      'cough',
      'sputum',
      'dyspnea',
      'hemoptysis',
      'null',
      'connective tissue disease',
      'chronic lung disease');
  var calung = Disease1('ca lung', 'dyspnea', 'cough', 'sputum', 'hemoptysis',
      'smoking', 'copd', 'chest pain', 'hoarseness');
  var ards = Disease1('ARDS', 'dyspnea', 'cough', 'sputum', 'hemoptysis',
      'cyanosis', 'null', 'null', 'null');
  var pe = Disease1('pulmonary embolism', 'dyspnea', 'chest pain', 'hemoptysis',
      'null', 'pregnancy', 'null', 'null', 'null');
  var ild = Disease1('interstitial lung disease', 'dyspnea', 'cough', 'fever',
      'null', 'null', 'null', 'null', 'null');
  var ild2 = Disease1('interstitial lung disease', 'dyspnea', 'cough', 'fever',
      'null', 'null', 'null', 'null', 'null');
  var ild3 = Disease1('interstitial lung disease', 'dyspnea', 'cough', 'fever',
      'sputum', 'null', 'null', 'null', 'other respiratory problems');

  var dm = Disease1('DM', 'polyuria', 'polydipsia', 'polyphagia', 'weight loss',
      'weight gain', 'family history', 'obesity', 'physical inactivity');
  var dm2 = Disease1('DM', 'polyuria', 'polydipsia', 'null', 'null', 'null',
      'pregnancy', 'null', 'null');
  var thyrotoxicosis = Disease1('thyrotoxicosis', 'palpitation', 'sweating',
      'tremer', 'insomnia', 'previous goitre', 'null', 'null', 'null');
  var thyrotoxicosis2 = Disease1('thyrotoxicosis', 'weight loss', 'polyphagia',
      'heat sensation', 'null', 'null', 'null', 'null', 'null');
  var hypothyroidism = Disease1(
      'hypothyroidism',
      'weight gain',
      'cold sensation',
      'anorexia',
      'somnolence',
      'dry skin',
      'menorrhagia',
      'null',
      'dry hair');
  var hypothyroidism2 = Disease1('hypothyroidism', 'constipation', 'hoarseness',
      'bilateral leg edema', 'null', 'null', 'null', 'null', 'null');
  var acromeg = Disease1('acromegally', 'enlarged hand', 'enlarged foot',
      'enlarged nose', 'enlarged jaw', 'null', 'null', 'null', 'null');
  var dwarf = Disease1('dwarfisim', 'short stature', 'weight gain', 'null',
      'null', 'null', 'null', 'null', 'null');
  var prolac = Disease1(
      'prolactinemia',
      'galactorrhea',
      'amenorrhea',
      'oligomenorrhea',
      'gynecomastia',
      'female hirsutism',
      'decrease libido',
      'male infertility',
      'female infertility');
  var dinsip = Disease1('diabetes insipdus', 'polyuria', 'polydipsia', 'null',
      'null', 'null', 'null', 'null', 'null');
  var hyperpth = Disease1('hyperparathyroidism', 'polyuria', 'polydipsia',
      'generalized bone pain', 'null', 'null', 'null', 'null', 'null');
  var malerep = Disease1('male reproductive problems', 'delayed puberty',
      'gynecomastia', 'null', 'null', 'null', 'null', 'null', 'null');
  var pcos = Disease1('PCOS', 'menorrhagia', 'female hirsutism',
      'female infertility', 'weight gain', 'null', 'null', 'null', 'null');
  var cushing = Disease1('cushing', 'weight gain', 'striae', 'weight gain',
      'female hirsutism', 'null', 'null', 'null', 'null');
  var cah = Disease1('CAH', 'female hirsutism', 'null', 'null', 'null', 'null',
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
    alcohol,
    smok,
    gender
  ];
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
          cvsscore += 2;
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
          respscore += 2;
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
          endoscore += 2;
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
  FinalScore.cvsscore = cvsscore;
  FinalScore.respscore = respscore;
  FinalScore.endoscore = endoscore;
}
