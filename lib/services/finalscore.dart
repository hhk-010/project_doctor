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
  static int neuroscore;
  static int rheumatoscore;
  static int heamatoscore;
  static int nephroscore;
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
    finalscore.gynescore:'Gynecologist',
    finalscore.rheumatoscore:'Rheumatologist',
    finalscore.nephroscore:'Nephrologist',
    finalscore.heamatoscore:'Heamatologist',
    finalscore.neuroscore:'Neurologist'
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
    finalscore.gynescore,
    finalscore.neuroscore,
    finalscore.rheumatoscore,
    finalscore.heamatoscore,
    finalscore.nephroscore
  ];
  var finals = 0;
  for (var x in scores) {
    if (x > finals) {
      finals = x;
      finalscore.speciality = _scoremap[x];
    }
  }
}
