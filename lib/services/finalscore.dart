class finalscore {
  static int finale;
  static String speciality;
  static int cvsscore;
  static int respscore;
  static int endoscore;
  static int gitscore;
  static int generalscore;
  static int thoracicscore;
  static int erscore;
  static int internscore;
  static int gynescore;
}

countfinal() {
  var _scoremap = {
    finalscore.cvsscore: 'Cardiologist',
    finalscore.respscore: 'Pulmonologist',
    finalscore.endoscore: 'Endocrinologist',
    finalscore.gitscore: 'Enterologist',
    finalscore.generalscore: 'General Surgeon',
    finalscore.thoracicscore: 'Thoracic Surgeon',
    finalscore.erscore:'Emergency Department',
    finalscore.internscore:'Internist',
    finalscore.gynescore:'Gynecologist'
  };
  var scores = [
    finalscore.cvsscore,
    finalscore.respscore,
    finalscore.endoscore,
    finalscore.gitscore,
    finalscore.generalscore,
    finalscore.thoracicscore,
    finalscore.erscore,
    finalscore.internscore,
    finalscore.gynescore
  ];
  var finals = 0;
  for (var x in scores) {
    if (x > finals) {
      finals = x;
      finalscore.speciality = _scoremap[x];
    }
  }
}
