import 'package:project_doctor/services/finalscore.dart';

class Disease6 {
  String name;
  String sym1;
  String sym2;
  String sym3;
  String sym4;
  String rf1;
  String rf2;
  String rf3;
  String rf4;
  Disease6(this.name, this.sym1, this.sym2, this.sym3, this.sym4, this.rf1,
      this.rf2, this.rf3, this.rf4);
}

maindisease6(
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
  var undtest = Disease6('undescended testes', 'empty scrotum', 'null', 'null',
      'null', 'null', 'null', 'null', 'other urological problems');
  var hypsp = Disease6(
      'hypospadias and others',
      'abnormal urethral openning site',
      'abnormal penile size',
      'penile mass',
      'other penile problems',
      'null',
      'null',
      'null',
      'null');
  var uti = Disease6('uti', 'heamaturia', 'dysuria', 'polyuria',
      'suprapubic pain', 'flank pain', 'nausea', 'vomiting', 'fever');
  var uti2 = Disease6('uti', 'frequency', 'urgency', 'perianal pain',
      'scrotal pain', 'scrotal swelling', 'female', 'pregnancy', 'null');
  var incon = Disease6('urinary incontinence', 'incontinence', 'incontinence',
      'null', 'null', 'DM', 'pregnancy', 'null', 'null');
  //non traumatic and traumatic urological EM will be left
  var neurblad = Disease6('neuropathic bladder', 'incontinence', 'frequency',
      'urgency', 'retention', 'DM', 'null', 'null', 'null');
  var stone = Disease6('urinary stone', 'flank pain', 'nausea', 'vomiting',
      'fever', 'dysuria', 'frequency', 'urgency', 'heamaturia');
  var mass = Disease6('renal tumer', 'heamaturia', 'flank pain', 'fever',
      'nausea', 'vomiting', 'null', 'null', 'null');
  var hydro = Disease6('hydrocele', 'scrotal swelling', 'null', 'null', 'null',
      'null', 'null', 'null', 'null');
  var varic = Disease6('varicocele', 'scrotal swelling', 'null', 'null', 'null',
      'null', 'null', 'null', 'null');
  var testum = Disease6(
      'testicular tumers',
      'scrotal swelling',
      'scrotal swelling',
      'scrotal pain',
      'null',
      'null',
      'null',
      'null',
      'null');
  var bladca = Disease6('bladder ca', 'heamaturia', 'frequency', 'urgency',
      'dysuria', 'smoking', 'family history', 'null', 'null');
  var bph = Disease6('bph', 'retention', 'frequency', 'urgency', 'dysuria',
      'nocturia', 'null', 'null', 'null');
  var caprost = Disease6('prostatic ca', 'heamaturia', 'heamatospermia',
      'retention', 'null', 'null', 'family history', 'null', 'null');
  var impo = Disease6('impotence', 'impotence', 'impotence', 'null', 'null',
      'DM', 'null', 'null', 'null');
  var infer = Disease6(
      'infertility',
      'male infertility',
      'male infertility',
      'male infertility',
      'null',
      'null',
      'null',
      'null',
      'other urological problems');

  var frac = Disease6('fracture', 'fracture', 'fracture', 'fracture', 'null',
      'null', 'null', 'null', 'null');
  var disloc = Disease6('dislocation', 'dislocation', 'dislocation', 'null',
      'null', 'null', 'null', 'null', 'null');
  var injury = Disease6('msk injury', 'msk injury', 'msk injury', 'limb pain',
      'limb pain', 'sport injury', 'sport injury', 'sport injury', 'null');
  var tumer = Disease6('bone tumers', 'limb pain', 'limb pain', 'limb pain',
      'null', 'null', 'null', 'null', 'null');
  var fodeform = Disease6('deformity', 'deformity', 'deformity', 'deformity',
      'foot ulcer', 'null', 'null', 'null', 'null');
  var shinst = Disease6('shoulder instability', 'dislocation', 'dislocation',
      'deformity', 'null', 'null', 'null', 'null', 'null');
  var elbdef = Disease6('elbow deformity', 'deformity', 'deformity',
      'deformity', 'null', 'null', 'null', 'null', 'other msk problems');
  //hand should be transferred to the plastic surgery
  //var hadef=disease('hand deformity','deformity','deformity','deformity','skin appendage','extra digit','joined digit','loss digit','lump');
  var hipdef = Disease6('hip deformity', 'diformity', 'deformity', 'null',
      'null', 'null', 'null', 'null', 'null');
  var knedef = Disease6('knee deformity', 'deformity', 'deformity', 'deformity',
      'null', 'null', 'null', 'null', 'null');

  var ntd = Disease6('neural tube defect', 'back openning', 'back mass', 'null',
      'null', 'null', 'null', 'null', 'null');
  var hydroce = Disease6('hydrocephalus', 'large head', 'large head', 'null',
      'null', 'null', 'null', 'null', 'null');
  var cran = Disease6(
      'craniocynostosis',
      'abnormal head shape',
      'abnormal head shape',
      'other skull problems',
      'null',
      'null',
      'null',
      'null',
      'null');
  var neck = Disease6('cervical spondylosis', 'neck pain', 'neck pain',
      'numbness', 'weakness', 'null', 'null', 'null', 'null');
  var back = Disease6('limber spodylosis', 'back pain', 'back pain', 'weakness',
      'numbness', 'incontinence', 'retention', 'null', 'null');

  var burn = Disease6(
      'burn', 'burn', 'burn', 'null', 'null', 'null', 'null', 'null', 'null');
  var cleft = Disease6('cleft lip', 'cleft lip', 'cleft palate', 'null', 'null',
      'null', 'null', 'null', 'null');
  var hand = Disease6(
      'diseases of the hand',
      'extra digit',
      'hand deformity',
      'skin lesion',
      'skin appendage',
      'other hand problems',
      'hand swelling',
      'hand lump',
      'joined digit');

  // pediatric and thoracovascular surgery will be left now and to be seen

  var uro = [
    undtest,
    hypsp,
    uti,
    uti2,
    incon,
    neurblad,
    stone,
    mass,
    hydro,
    varic,
    testum,
    bladca,
    bph,
    caprost,
    infer,
    impo
  ];
  var u = 0;
  var uu = uro.length;
  var urosym = [
    uro[u].sym1,
    uro[u].sym2,
    uro[u].sym3,
    uro[u].sym4,
    uro[u].rf1,
    uro[u].rf2,
    uro[u].rf3,
    uro[u].rf4
  ];
  var urokey = 0;
  var urolen = urosym.length;

  var ortho = [
    frac,
    disloc,
    injury,
    tumer,
    fodeform,
    shinst,
    elbdef,
    hipdef,
    knedef
  ];
  var or = 0;
  var ort = ortho.length;
  var ortsym = [
    ortho[or].sym1,
    ortho[or].sym2,
    ortho[or].sym3,
    ortho[or].sym4,
    ortho[or].rf1,
    ortho[or].rf2,
    ortho[or].rf3,
    ortho[or].rf4
  ];
  var ortkey = 0;
  var ortlen = ortsym.length;

  var neus = [ntd, hydroce, cran, neck, back];
  var n = 0;
  var nn = neus.length;
  var neusym = [
    neus[n].sym1,
    neus[n].sym2,
    neus[n].sym3,
    neus[n].sym4,
    neus[n].rf1,
    neus[n].rf2,
    neus[n].rf3,
    neus[n].rf4
  ];
  var neukey = 0;
  var neulen = neusym.length;

  var plas = [burn, cleft, hand];
  var p = 0;
  var pp = plas.length;
  var plasym = [
    plas[p].sym1,
    plas[p].sym2,
    plas[p].sym3,
    plas[p].sym4,
    plas[p].rf1,
    plas[p].rf2,
    plas[p].rf3,
    plas[p].rf4
  ];
  var plaskey = 0;
  var plaslen = plasym.length;

  var chiefcom = cc;
  var others = [s2, s3, s4, s5, s6, s7];
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
  var o = 0;
  var oo = others.length;
  var r = 0;
  var rr = riskf.length;

  var uroscore = 0;
  var ortscore = 0;
  var neuscore = 0;
  var plascore = 0;
  while (uu > 0) {
    while (urolen > 0) {
      if (chiefcom == urosym[urokey]) {
        uroscore += 10;
      }
      while (oo > 0) {
        if (others[o] == urosym[urokey]) {
          uroscore += 1;
        }
        o += 1;
        oo -= 1;
      }
      while (rr > 0) {
        if (riskf == urosym[urokey]) {
          uroscore += 1;
        }
        r += 1;
        rr -= 1;
      }
      o = 0;
      oo = others.length;
      r = 0;
      rr = riskf.length;
      urolen -= 1;
      urokey += 1;
    }
    u += 1;
    uu -= 1;
    if (uu > 0) {
      urosym = [
        uro[u].sym1,
        uro[u].sym2,
        uro[u].sym3,
        uro[u].sym4,
        uro[u].rf1,
        uro[u].rf2,
        uro[u].rf3,
        uro[u].rf4
      ];
      urokey = 0;
      urolen = urosym.length;
    }
  }
  while (ort > 0) {
    while (ortlen > 0) {
      if (chiefcom == ortsym[ortkey]) {
        ortscore += 10;
      }
      while (oo > 0) {
        if (others[o] == ortsym[ortkey]) {
          ortscore += 1;
        }
        o += 1;
        oo -= 1;
      }
      while (rr > 0) {
        if (riskf == ortsym[ortkey]) {
          ortscore += 1;
        }
        r += 1;
        rr -= 1;
      }
      o = 0;
      oo = others.length;
      r = 0;
      rr = riskf.length;
      ortlen -= 1;
      ortkey += 1;
    }
    or += 1;
    ort -= 1;
    if (ort > 0) {
      ortsym = [
        ortho[or].sym1,
        ortho[or].sym2,
        ortho[or].sym3,
        ortho[or].sym4,
        ortho[or].rf1,
        ortho[or].rf2,
        ortho[or].rf3,
        ortho[or].rf4
      ];
      ortkey = 0;
      ortlen = ortsym.length;
    }
  }
  while (nn > 0) {
    while (neulen > 0) {
      if (chiefcom == neusym[neukey]) {
        neuscore += 10;
      }
      while (oo > 0) {
        if (others[o] == neusym[neukey]) {
          neuscore += 1;
        }
        o += 1;
        oo -= 1;
      }
      while (rr > 0) {
        if (riskf == neusym[neukey]) {
          neuscore += 1;
        }
        r += 1;
        rr -= 1;
      }
      o = 0;
      oo = others.length;
      r = 0;
      rr = riskf.length;
      neulen -= 1;
      neukey += 1;
    }
    n += 1;
    nn -= 1;
    if (nn > 0) {
      neusym = [
        neus[n].sym1,
        neus[n].sym2,
        neus[n].sym3,
        neus[n].sym4,
        neus[n].rf1,
        neus[n].rf2,
        neus[n].rf3,
        neus[n].rf4
      ];
      neukey = 0;
      neulen = neusym.length;
    }
  }
  while (pp > 0) {
    while (plaslen > 0) {
      if (chiefcom == plasym[plaskey]) {
        plascore += 10;
      }
      while (oo > 0) {
        if (others[o] == plasym[plaskey]) {
          plascore += 1;
        }
        o += 1;
        oo -= 1;
      }
      while (rr > 0) {
        if (riskf == plasym[plaskey]) {
          plascore += 1;
        }
        r += 1;
        rr -= 1;
      }
      o = 0;
      oo = others.length;
      r = 0;
      rr = riskf.length;
      plaslen -= 1;
      plaskey += 1;
    }
    p += 1;
    pp -= 1;
    if (pp > 0) {
      plasym = [
        plas[p].sym1,
        plas[p].sym2,
        plas[p].sym3,
        plas[p].sym4,
        plas[p].rf1,
        plas[p].rf2,
        plas[p].rf3,
        plas[p].rf4
      ];
      plaskey = 0;
      plaslen = plasym.length;
    }
  }
  print(uroscore);
  print(ortscore);
  print(neuscore);
  print(plascore);
  FinalScore.uroscore = uroscore;
  FinalScore.orthoscore = ortscore;
  FinalScore.neurosurgscore = neuscore;
  FinalScore.plasticscore = plascore;
}
