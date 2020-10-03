class finalscore {
  static int finale;
  static String speciality;
  static int cvsscore;
  static int respscore;
  static int endoscore;
  static int gitscore;
  static int generalscore;
  static int thoracicscore;
}

countfinal() {
  var _scoremap = {
    finalscore.cvsscore: 'cardiologist',
    finalscore.respscore: 'respiratory',
    finalscore.endoscore: 'endocrinologist',
    finalscore.gitscore: 'enterologist',
    finalscore.generalscore: 'general surgeon',
    finalscore.thoracicscore: 'thoracic surgeon'
  };
  var scores = [
    finalscore.cvsscore,
    finalscore.respscore,
    finalscore.endoscore,
    finalscore.gitscore,
    finalscore.generalscore,
    finalscore.thoracicscore
  ];
  var finals = 0;
  for (var x in scores) {
    if (x > finals) {
      finals = x;
      finalscore.speciality = _scoremap[x];
    }
  }
}
