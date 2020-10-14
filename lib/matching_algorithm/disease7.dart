import 'package:project_doctor/matching_algorithm/final_score.dart';

class disease7 {
  String name;
  String sym1;
  String sym2;
  String sym3;
  String sym4;
  String rf1;
  String rf2;
  String rf3;
  String rf4;
  disease7(this.name, this.sym1, this.sym2, this.sym3, this.sym4, this.rf1,
      this.rf2, this.rf3, this.rf4);
}

maindisease7(
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
  var ophth = disease7(
      'ophthalmic disease',
      'blurred vision',
      'squint',
      'eye redness',
      'eye pain',
      'eye discharge',
      'eye itching',
      'eye pigmentation',
      'photophobia');
  var ophth2 = disease7(
      'ophthalmic disease',
      'periorbital edema',
      'eyelid deformity',
      'dry eye',
      'null',
      'blindness',
      'ophthalmoplegia',
      'other ophthalmological problems',
      'null');
  var ophth3 = disease7(
      'ophthalmic disease',
      'blurred vision',
      'squint',
      'eye redness',
      'eye pain',
      'eye discharge',
      'eye itching',
      'eye pigmentation',
      'photophobia');
  var ophth4 = disease7(
      'ophthalmic disease',
      'periorbital edema',
      'eyelid deformity',
      'dry eye',
      'null',
      'blindness',
      'ophthalmoplegia',
      'other ophthalmological problems',
      'null');
  var ophth5 = disease7(
      'ophthalmic disease',
      'blurred vision',
      'squint',
      'eye redness',
      'eye pain',
      'eye discharge',
      'eye itching',
      'eye pigmentation',
      'photophobia');
  var ophth6 = disease7(
      'ophthalmic disease',
      'periorbital edema',
      'eyelid deformity',
      'dry eye',
      'null',
      'blindness',
      'ophthalmoplegia',
      'other ophthalmological problems',
      'null');

  var derma = disease7(
      'dermatology',
      'skin appendage',
      'skin redness',
      'skin itching',
      'ulcer',
      'hair problems',
      'acne',
      'skin pigmentation',
      'other dermatological problems');
  var derma2 = disease7('dermatology', 'skin lesion', 'skin rash',
      'nail problems', 'dry skin', 'dry hair', 'skin lesion', 'null', 'null');
  var derma3 = disease7(
      'dermatology',
      'skin appendage',
      'skin redness',
      'skin itching',
      'ulcer',
      'hair problems',
      'acne',
      'skin pigmentation',
      'other dermatological problems');
  var derma4 = disease7('dermatology', 'skin lesion', 'skin rash',
      'nail problems', 'dry skin', 'dry hair', 'skin lesion', 'null', 'null');
  var derma5 = disease7(
      'dermatology',
      'skin appendage',
      'skin redness',
      'skin itching',
      'ulcer',
      'hair problems',
      'acne',
      'skin pigmentation',
      'other dermatological problems');
  var derma6 = disease7('dermatology', 'skin lesion', 'skin rash',
      'nail problems', 'dry skin', 'dry hair', 'skin lesion', 'null', 'null');

  var psych = disease7(
      'psychaitry',
      'depression',
      'hallucination/delusion',
      'phobia',
      'null',
      'obsession',
      'attention deficit',
      'hyperactivity',
      'null');
  var psych2 = disease7(
      'psychiatry',
      'stress',
      'psychological trauma',
      'addiction',
      'null',
      'encorporesis',
      'null',
      'other psychological problems',
      'null');
  var psych3 = disease7(
      'psychaitry',
      'depression',
      'hallucination/delusion',
      'phobia',
      'null',
      'obsession',
      'attention deficit',
      'hyperactivity',
      'null');
  var psych4 = disease7(
      'psychiatry',
      'stress',
      'psychological trauma',
      'addiction',
      'null',
      'encorporesis',
      'null',
      'other psychological problems',
      'null');
  var psych5 = disease7(
      'psychaitry',
      'depression',
      'hallucination/delusion',
      'phobia',
      'null',
      'obsession',
      'attention deficit',
      'hyperactivity',
      'null');
  var psych6 = disease7(
      'psychiatry',
      'stress',
      'psychological trauma',
      'addiction',
      'null',
      'encorporesis',
      'null',
      'other psychological problems',
      'null');

  //neck mass will be left
  var ent = disease7('ent', 'sore throat', 'hoarseness', 'deafness', 'vertigo',
      'nasal discharge', 'nasal bleeding', 'nasal obstruction', 'tinnitus');
  var ent2 = disease7(
      'ent',
      'nasal pain',
      'ear pain',
      'nasal mass',
      'nasal deformity',
      'sneezing',
      'nasal itching',
      'anosmia',
      'ear discharge');
  var ent3 = disease7('ent', 'ear redness', 'other ent problems', 'null',
      'null', 'null', 'null', 'null', 'null');
  var ent4 = disease7('ent', 'sore throat', 'hoarseness', 'deafness', 'vertigo',
      'nasal discharge', 'nasal bleeding', 'nasal obstruction', 'tinnitus');
  var ent5 = disease7(
      'ent',
      'nasal pain',
      'ear pain',
      'nasal mass',
      'nasal deformity',
      'sneezing',
      'nasal itching',
      'anosmia',
      'ear discharge');
  var ent6 = disease7('ent', 'ear redness', 'other ent problems', 'null',
      'null', 'null', 'null', 'null', 'null');
  var ent7 = disease7('ent', 'sore sthroat', 'hoarseness', 'deafness', 'vertigo',
      'nasal discharge', 'nasal bleeding', 'nasal obstruction', 'tinnitus');
  var ent8 = disease7(
      'ent',
      'nasal pain',
      'ear pain',
      'nasal mass',
      'nasal deformity',
      'sneezing',
      'nasal itching',
      'anosmia',
      'ear discharge');
  var ent9 = disease7('ent', 'ear redness', 'other ent problems', 'null',
      'null', 'null', 'null', 'null', 'null');

  var optha = [ophth, ophth2, ophth3, ophth4, ophth5, ophth6];
  var op = 0;
  var opt = optha.length;
  var opsym = [
    optha[op].sym1,
    optha[op].sym2,
    optha[op].sym3,
    optha[op].sym4,
    optha[op].rf1,
    optha[op].rf2,
    optha[op].rf3,
    optha[op].rf4
  ];
  var opkey = 0;
  var oplen = opsym.length;

  var psyc = [psych, psych2, psych3, psych4, psych5, psych6];
  var psy = 0;
  var pslen = psyc.length;
  var psysym = [
    psyc[psy].sym1,
    psyc[psy].sym2,
    psyc[psy].sym3,
    psyc[psy].sym4,
    psyc[psy].rf1,
    psyc[psy].rf2,
    psyc[psy].rf3,
    psyc[psy].rf4
  ];
  var psylen = psysym.length;
  var psykey = 0;

  var derm = [derma, derma2, derma3, derma4, derma5, derma6];
  var d = 0;
  var dd = derm.length;
  var dersym = [
    derm[d].sym1,
    derm[d].sym2,
    derm[d].sym3,
    derm[d].sym4,
    derm[d].rf1,
    derm[d].rf2,
    derm[d].rf3,
    derm[d].rf4
  ];
  var derkey = 0;
  var derlen = dersym.length;

  var ents = [ent, ent2, ent3, ent4, ent5, ent6, ent7, ent8, ent9];
  var e = 0;
  var ee = ents.length;
  var entsym = [
    ents[e].sym1,
    ents[e].sym2,
    ents[e].sym3,
    ents[e].sym4,
    ents[e].rf1,
    ents[e].rf2,
    ents[e].rf3,
    ents[e].rf4
  ];
  var entlen = entsym.length;
  var entkey = 0;

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
    alcohol,
    gender
  ];
  var o = 0;
  var oo = others.length;
  var r = 0;
  var rr = riskf.length;

  var opscore = 0;
  var derscore = 0;
  var psyscore = 0;
  var entscore = 0;

  while (opt > 0) {
    while (oplen > 0) {
      if (chiefcom == opsym[opkey]) {
        opscore += 10;
      }
      while (oo > 0) {
        if (others[o] == opsym[opkey]) {
          opscore += 1;
        }
        o += 1;
        oo -= 1;
      }
      while (rr > 0) {
        if (riskf == opsym[opkey]) {
          opscore += 1;
        }
        r += 1;
        rr -= 1;
      }
      o = 0;
      oo = others.length;
      r = 0;
      rr = riskf.length;
      oplen -= 1;
      opkey += 1;
    }
    op += 1;
    opt -= 1;
    if (opt > 0) {
      opsym = [
        optha[op].sym1,
        optha[op].sym2,
        optha[op].sym3,
        optha[op].sym4,
        optha[op].rf1,
        optha[op].rf2,
        optha[op].rf3,
        optha[op].rf4
      ];
      opkey = 0;
      oplen = opsym.length;
    }
  }
  while (dd > 0) {
    while (derlen > 0) {
      if (chiefcom == dersym[derkey]) {
        derscore += 10;
      }
      while (oo > 0) {
        if (others[o] == dersym[derkey]) {
          derscore += 1;
        }
        o += 1;
        oo -= 1;
      }
      while (rr > 0) {
        if (riskf == dersym[derkey]) {
          derscore += 1;
        }
        r += 1;
        rr -= 1;
      }
      o = 0;
      oo = others.length;
      r = 0;
      rr = riskf.length;
      derlen -= 1;
      derkey += 1;
    }
    d += 1;
    dd -= 1;
    if (dd > 0) {
      dersym = [
        derm[d].sym1,
        derm[d].sym2,
        derm[d].sym3,
        derm[d].sym4,
        derm[d].rf1,
        derm[d].rf2,
        derm[d].rf3,
        derm[d].rf4
      ];
      derkey = 0;
      derlen = dersym.length;
    }
  }
  while (pslen > 0) {
    while (psylen > 0) {
      if (chiefcom == psysym[psykey]) {
        psyscore += 10;
      }
      while (oo > 0) {
        if (others[o] == psysym[psykey]) {
          psyscore += 1;
        }
        o += 1;
        oo -= 1;
      }
      while (rr > 0) {
        if (riskf == psysym[psykey]) {
          psyscore += 1;
        }
        r += 1;
        rr -= 1;
      }
      o = 0;
      oo = others.length;
      r = 0;
      rr = riskf.length;
      psylen -= 1;
      psykey += 1;
    }
    psy += 1;
    pslen -= 1;
    if (pslen > 0) {
      psysym = [
        psyc[psy].sym1,
        psyc[psy].sym2,
        psyc[psy].sym3,
        psyc[psy].sym4,
        psyc[psy].rf1,
        psyc[psy].rf2,
        psyc[psy].rf3,
        psyc[psy].rf4
      ];
      psylen = psysym.length;
      psykey = 0;
    }
  }
  while (ee > 0) {
    while (entlen > 0) {
      if (chiefcom == entsym[entkey]) {
        entscore += 10;
      }
      while (oo > 0) {
        if (others[o] == entsym[entkey]) {
          entscore += 1;
        }
        o += 1;
        oo -= 1;
      }
      while (rr > 0) {
        if (riskf == entsym[entkey]) {
          entscore += 1;
        }
        r += 1;
        rr -= 1;
      }
      o = 0;
      oo = others.length;
      r = 0;
      rr = riskf.length;
      entlen -= 1;
      entkey += 1;
    }
    e += 1;
    ee -= 1;
    if (ee > 0) {
      entsym = [
        ents[e].sym1,
        ents[e].sym2,
        ents[e].sym3,
        ents[e].sym4,
        ents[e].rf1,
        ents[e].rf2,
        ents[e].rf3,
        ents[e].rf4
      ];
      entlen = entsym.length;
      entkey = 0;
    }
  }
  print(opscore);
  print(derscore);
  print(psyscore);
  print(entscore);
  FinalScore.psychoscore = psyscore;
  FinalScore.dermascore = derscore;
  FinalScore.opthascore = opscore;
  FinalScore.entscore = entscore;
}
