import 'package:project_doctor/matching_algorithm/final_score.dart';

class Disease4 {
  String name;
  String sym1;
  String sym2;
  String sym3;
  String sym4;
  String rf1;
  String rf2;
  String rf3;
  String rf4;
  Disease4(this.name, this.sym1, this.sym2, this.sym3, this.sym4, this.rf1,
      this.rf2, this.rf3, this.rf4);
}

maindisease4(
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
    gender) {
  var obs = Disease4(
      'obstetric diseases',
      'abnormal vaginal bleeding',
      'prolong pregnancy',
      'abdominal pain',
      'vaginal discharge',
      'miscarriage',
      'menorrhagia',
      'null',
      'pregnancy');
  var gyne = Disease4(
      'gyne diseases',
      'amenorrhea',
      'abnormal cycle',
      'abnormal vaginal bleeding',
      'vaginal discharge',
      'decrease  libido',
      'genital region mass',
      'pain during cycle',
      'female infertility');
  var gyne2 = Disease4(
      'gyne diseases',
      'oligomenorrhea',
      'postmenopausal bleeding',
      'abdominal pain',
      'other gynecological and obstetrical problems',
      'null',
      'null',
      'null',
      'null');
  var obs2 = Disease4(
      'obstetric diseases',
      'abnormal vaginal bleeding',
      'prolong pregnancy',
      'abdominal pain',
      'vaginal discharge',
      'miscarriage',
      'menorrhagia',
      'null',
      'pregnancy');
  var gyne3 = Disease4(
      'gyne diseases',
      'amenorrhea',
      'abnormal cycle',
      'abnormal vaginal bleeding',
      'vaginal discharge',
      'decrease  libido',
      'genital region mass',
      'pain during cycle',
      'female infertility');
  var gyne4 = Disease4(
      'gyne diseases',
      'oligomenorrhea',
      'postmenopausal bleeding',
      'abdominal pain',
      'other gynecological and obstetrical problems',
      'null',
      'null',
      'null',
      'null');
  var obs3 = Disease4(
      'obstetric diseases',
      'abnormal vaginal bleeding',
      'prolong pregnancy',
      'abdominal pain',
      'vaginal discharge',
      'miscarriage',
      'menorrhagia',
      'null',
      'pregnancy');
  var gyne5 = Disease4(
      'gyne diseases',
      'amenorrhea',
      'abnormal cycle',
      'abnormal vaginal bleeding',
      'vaginal discharge',
      'decrease  libido',
      'genital region mass',
      'pain during cycle',
      'female infertility');
  var gyne6 = Disease4(
      'gyne diseases',
      'oligomenorrhea',
      'postmenopausal bleeding',
      'abdominal pain',
      'other gynecological and obstetrical problems',
      'null',
      'null',
      'null',
      'null');

  var obst = [obs, obs2, obs3, gyne, gyne2, gyne3, gyne4, gyne5, gyne6];
  var ob = 0;
  var obgy = obst.length;
  var obsym = [
    obst[ob].sym1,
    obst[ob].sym2,
    obst[ob].sym3,
    obst[ob].sym4,
    obst[ob].rf1,
    obst[ob].rf2,
    obst[ob].rf3,
    obst[ob].rf4
  ];
  var obskey = 0;
  var obslen = obsym.length;

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

  var obscore = 0;

  while (obgy > 0) {
    while (obslen > 0) {
      if (chiefcom == obsym[obskey]) {
        obscore += 10;
      }
      while (oo > 0) {
        if (others[o] == obsym[obskey]) {
          obscore += 2;
        }
        o += 1;
        oo -= 1;
      }
      while (rr > 0) {
        if (riskf == obsym[obskey]) {
          obscore += 1;
        }
        r += 1;
        rr -= 1;
      }
      o = 0;
      oo = others.length;
      r = 0;
      rr = riskf.length;
      obslen -= 1;
      obskey += 1;
    }
    ob += 1;
    obgy -= 1;
    if (obgy > 0) {
      obsym = [
        obst[ob].sym1,
        obst[ob].sym2,
        obst[ob].sym3,
        obst[ob].sym4,
        obst[ob].rf1,
        obst[ob].rf2,
        obst[ob].rf3,
        obst[ob].rf4
      ];
      obskey = 0;
      obslen = obsym.length;
    }
  }

  FinalScore.gynescore = obscore;
}
