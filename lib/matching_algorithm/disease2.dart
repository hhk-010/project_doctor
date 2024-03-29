import 'package:project_doctor/matching_algorithm/final_score.dart';

class Disease2 {
  String name;
  String sym1;
  String sym2;
  String sym3;
  String sym4;
  String rf1;
  String rf2;
  String rf3;
  String rf4;
  Disease2(this.name, this.sym1, this.sym2, this.sym3, this.sym4, this.rf1,
      this.rf2, this.rf3, this.rf4);
}

maindisease2(
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
  var achal = Disease2('achalasia', 'dysphagia', 'odynophagia', 'null', 'null',
      'null', 'null', 'null', 'null');
  var esospa = Disease2('diffuse esophageal spasm', 'dysphagia', 'odynophagia',
      'null', 'null', 'null', 'null', 'null', 'null');
  var nutcrak = Disease2('nutcraker esophagus', 'dysphagia', 'odynophagia',
      'null', 'null', 'null', 'null', 'null', 'null');
  var diver = Disease2('diverticulae', 'dysphagia', 'odynophagia', 'null',
      'null', 'null', 'null', 'null', 'null');
  var esoring = Disease2('esophagial rings', 'dysphagia', 'odynophagia', 'null',
      'null', 'null', 'null', 'null', 'null');
  var claud = Disease2('claudication', 'leg pain during walking', 'HTN', 'DM',
      'smoking', 'obesity', 'family history', 'null', 'null');

  // peptic ulcer and pancreatitis to be seen

  var gasent = Disease2(
      'gastroenteritis',
      'watery diarrhea',
      'mucousy diarrhea',
      'bloody diarrhea',
      'abdominal pain',
      'null',
      'null',
      'null',
      'null');
  var ibd = Disease2(
      'indflammatory bowel disease',
      'bloody diarrhea',
      'mucousy diarrhea',
      'abdominal pain',
      'vomiting',
      'weight loss',
      'tenesmus',
      'family history',
      'null');
  var sprue = Disease2('tropical sprue', 'watery diarrhea', 'weight loss',
      'anorexia', 'null', 'null', 'null', 'null', 'null');
  var bliloop = Disease2(
      'small bowel bacovergrowth or blind loop syndrome',
      'watery diarrhea',
      'mucousy diarrhea',
      'weight loss',
      'null',
      'null',
      'null',
      'null',
      'null');
  var sbs = Disease2(
      'short bowel syndrome',
      'watery diarrhea',
      'mucousy diarrhea',
      'weight loss',
      'null',
      'null',
      'null',
      'null',
      'null');
  // ple is overlappped with other conditions
  var ple = Disease2('protein losing enteropathy', 'watery diarrhea',
      'bilateral leg edema', 'null', 'null', 'null', 'null', 'null', 'null');
  var ibs = Disease2(
      'irritable bowel syndrome',
      'watery diarrhea',
      'abdominal pain',
      'mucousy diarrhea',
      'tenesmus',
      'null',
      'null',
      'null',
      'null');
  var celiac = Disease2('celiac disease', 'watery diarrhea', 'weight loss',
      'bilateral leg edema', 'null', 'null', 'null', 'null', 'null');
  var vipoma = Disease2('vipoma', 'watery diarrhea', 'abdominal pain', 'null',
      'null', 'null', 'null', 'null', 'null');
  var carcin = Disease2(
      'carcinoid syndrome',
      'watery diarrhea',
      'abdominal pain',
      'null',
      'null',
      'null',
      'null',
      'null',
      'other git problems');

  var liver = Disease2(
      'liver disease',
      'jaundice',
      'jaundice',
      'jaundice',
      'jaundice',
      'family history',
      'alcoholism',
      'fever',
      'connective tissue disease');
  //gastric and pancreatic and mouth diseases will be left and to be viewed

  var gastritis = Disease2('gastririts', 'nausea', 'vomiting', 'abdominal pain',
      'anorexia', 'alcoholism', 'null', 'null', 'null');
  var peptic = Disease2('peptic ulcer', 'abdominal pain', 'nausea', 'vomiting',
      'anorexia', 'alcoholism', 'null', 'null', 'null');
  var gasca = Disease2('gastric ca', 'abdominal pain', 'nausea', 'vomiting',
      'null', 'anorexia', 'null', 'null', 'null');
  var panc = Disease2('pancreatitis', 'abdominal pain', 'nausea', 'vomiting',
      'null', 'alcoholism', 'null', 'null', 'null');
  var capanc = Disease2('pancreatic ca', 'abdominal pain', 'nausea', 'vomiting',
      'null', 'anorexia', 'alcoholism', 'null', 'null');
  var livab = Disease2('liver abscess', 'abdominal pain', 'fever', 'anorexia',
      'null', 'null', 'null', 'null', 'null');
  var gallstone = Disease2('gallstone', 'abdominal pain', 'nausea', 'vomiting',
      'fever', 'null', 'null', 'null', 'null');
  var cagall = Disease2('gallbladder ca', 'abdominal pain', 'nausea',
      'anorexia', 'null', 'null', 'null', 'null', 'null');
  //ca bile duct is overlapped
  var periton = Disease2('peritonitis', 'abdominal pain', 'nausea', 'vomiting',
      'fever', 'null', 'null', 'null', 'null');
  var periab = Disease2('peritoneal abscess', 'abdominal pain', 'fever',
      'anorexia', 'hiccough', 'hiccough', 'null', 'null', 'null');
  //portal hypertension and upper GI bleeding will be left
  var obs = Disease2('intestinal obstruction', 'abdominal pain', 'constipation',
      'abdominal distension', 'vomiting', 'malignancy', 'null', 'null', 'null');
  var divert = Disease2(
      'diverticular disease',
      'abdominal pain',
      'nausea',
      'vomiting',
      'bleeding per rectum',
      'constipation',
      'abdominal distension',
      'null',
      'null');
  var intstumers = Disease2(
      'small intestinal tumers',
      'abdominal pain',
      'vomiting',
      'anorexia',
      'constipation',
      'bleeding per rectum',
      'abdominal distension',
      'smoking',
      'alcoholism');
  var colotumer = Disease2(
      'colonic tumers',
      'abdominal pain',
      'vomiting',
      'abdominal distension',
      'constipation',
      'bleeding per rectum',
      'family history',
      'null',
      'null');
  var perianal = Disease2(
      'perianal diseases',
      'perianal pain',
      'bleeding per rectum',
      'perianal discharge',
      'anal incontinence',
      'perianal itching',
      'anorexia',
      'perianal pain',
      'malignancy');
  var breast = Disease2(
      'breast disease',
      'breast mass',
      'breast pain',
      'breast discharge',
      'breast lump',
      'family history',
      'breast skin lesion',
      'other breast problems',
      'gynecomastia');
  var thyroid = Disease2('thyroid swelling', 'neck swelling', 'neck swelling',
      'neck swelling', 'gynecomastia', 'gynecomastia', 'null', 'null', 'null');
  var hernia = Disease2('hernia', 'scrotal swelling', 'abdominal wall swelling',
      'null', 'null', 'null', 'null', 'null', 'null');
  var lumpandulcer = Disease2('lump and ulcer', 'lump', 'lump', 'lump', 'ulcer',
      'ulcer', 'ulcer', 'null', 'null');
  var aaa = Disease2('AAA', 'abdominal pain', 'null', 'null', 'HTN', 'smoking',
      'DM', 'null', 'null');
  var appendix = Disease2('acute appendicitis', 'abdominal pain', 'nausea',
      'vomiting', 'fever', 'anorexia', 'null', 'null', 'null');

  var thora = [achal, esospa, nutcrak, diver, esoring, claud];
  var t = 0;
  var tt = thora.length;
  var thorsym = [
    thora[t].sym1,
    thora[t].sym2,
    thora[t].sym3,
    thora[t].sym4,
    thora[t].rf1,
    thora[t].rf2,
    thora[t].rf3,
    thora[t].rf4
  ];
  var thorkey = 0;
  var thorlen = thorsym.length;

  var git = [
    gasent,
    ibd,
    sprue,
    bliloop,
    sbs,
    ple,
    ibs,
    celiac,
    vipoma,
    carcin,
    liver
  ];
  var g = 0;
  var gg = git.length;
  var gitsym = [
    git[g].sym1,
    git[g].sym2,
    git[g].sym3,
    git[g].sym4,
    git[g].rf1,
    git[g].rf2,
    git[g].rf3,
    git[g].rf4
  ];
  var gitkey = 0;
  var gitlen = gitsym.length;

  var general = [
    gastritis,
    peptic,
    gasca,
    panc,
    capanc,
    livab,
    gallstone,
    cagall,
    periton,
    periab,
    obs,
    divert,
    intstumers,
    colotumer,
    perianal,
    breast,
    thyroid,
    hernia,
    lumpandulcer,
    aaa,
    appendix
  ];
  var gs = 0;
  var gsgs = general.length;
  var gssym = [
    general[gs].sym1,
    general[gs].sym2,
    general[gs].sym3,
    general[gs].sym4,
    general[gs].rf1,
    general[gs].rf2,
    general[gs].rf3,
    general[gs].rf4
  ];
  var gskey = 0;
  var gslen = gssym.length;

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
    alcohol,
    gender
  ];
  var r = 0;
  var rr = riskf.length;
  var gitscore = 0;
  var gsscore = 0;
  var thorscore = 0;

  while (gg > 0) {
    while (gitlen > 0) {
      if (chiefcom == gitsym[gitkey]) {
        gitscore += 10;
      }
      while (oo > 0) {
        if (others[o] == gitsym[gitkey]) {
          gitscore += 2;
        }
        o += 1;
        oo -= 1;
      }
      while (rr > 0) {
        if (riskf[r] == gitsym[gitkey]) {
          gitscore += 1;
        }
        r += 1;
        rr -= 1;
      }
      o = 0;
      oo = others.length;
      r = 0;
      rr = riskf.length;
      gitlen -= 1;
      gitkey += 1;
    }
    g += 1;
    gg -= 1;
    if (gg > 0) {
      gitsym = [
        git[g].sym1,
        git[g].sym2,
        git[g].sym3,
        git[g].sym4,
        git[g].rf1,
        git[g].rf2,
        git[g].rf3,
        git[g].rf4
      ];
      gitkey = 0;
      gitlen = gitsym.length;
    }
  }
  while (gsgs > 0) {
    while (gslen > 0) {
      if (chiefcom == gssym[gskey]) {
        gsscore += 10;
      }
      while (oo > 0) {
        if (others[o] == gssym[gskey]) {
          gsscore += 2;
        }
        o += 1;
        oo -= 1;
      }
      while (rr > 0) {
        if (riskf[r] == gssym[gskey]) {
          gsscore += 1;
        }
        r += 1;
        rr -= 1;
      }
      o = 0;
      oo = others.length;
      r = 0;
      rr = riskf.length;
      gslen -= 1;
      gskey += 1;
    }
    gs += 1;
    gsgs -= 1;
    if (gsgs > 0) {
      gssym = [
        general[gs].sym1,
        general[gs].sym2,
        general[gs].sym3,
        general[gs].sym4,
        general[gs].rf1,
        general[gs].rf2,
        general[gs].rf3,
        general[gs].rf4
      ];
      gskey = 0;
      gslen = gssym.length;
    }
  }
  while (tt > 0) {
    while (thorlen > 0) {
      if (chiefcom == thorsym[thorkey]) {
        thorscore += 10;
      }
      while (oo > 0) {
        if (others[o] == thorsym[thorkey]) {
          thorscore += 2;
        }
        o += 1;
        oo -= 1;
      }
      while (rr > 0) {
        if (riskf[r] == thorsym[thorkey]) {
          thorscore += 1;
        }
        r += 1;
        rr -= 1;
      }
      o = 0;
      oo = others.length;
      r = 0;
      rr = riskf.length;
      thorlen -= 1;
      thorkey += 1;
    }
    t += 1;
    tt -= 1;
    if (tt > 0) {
      thorsym = [
        thora[t].sym1,
        thora[t].sym2,
        thora[t].sym3,
        thora[t].sym4,
        thora[t].rf1,
        thora[t].rf2,
        thora[t].rf3,
        thora[t].rf4
      ];
      thorkey = 0;
      thorlen = thorsym.length;
    }
  }
  FinalScore.gitscore = gitscore;
  FinalScore.generalscore = gsscore;
  FinalScore.thoracicscore = thorscore;
  countfinal();
}
