class FinalScore {
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
  static int uroscore;
  static int orthoscore;
  static int neurosurgscore;
  static int plasticscore;
}

countfinal() {
  var _scoremap = {
    FinalScore.cvsscore: 'Cardiologist',
    FinalScore.respscore: 'Pulmonologist',
    FinalScore.endoscore: 'Endocrinologist',
    FinalScore.gitscore: 'Enterologist',
    FinalScore.generalscore: 'General Surgeon',
    FinalScore.thoracicscore: 'Thoracic Surgeon',
    FinalScore.erscore: 'Emergency Department',
    FinalScore.internscore: 'Internist',
    FinalScore.gynescore: 'Gynecologist',
    FinalScore.rheumatoscore: 'Rheumatologist',
    FinalScore.nephroscore: 'Nephrologist',
    FinalScore.heamatoscore: 'Heamatologist',
    FinalScore.neuroscore: 'Neurologist',
    FinalScore.uroscore: 'Urosurgeon',
    FinalScore.orthoscore: 'Orthopaedic Surgeon',
    FinalScore.neurosurgscore: 'Neurosurgeon',
    FinalScore.plasticscore: 'Plastic Surgeon'
  };
  var scores = [
    FinalScore.cvsscore,
    FinalScore.respscore,
    FinalScore.endoscore,
    FinalScore.gitscore,
    FinalScore.generalscore,
    FinalScore.thoracicscore,
    FinalScore.erscore,
    FinalScore.internscore,
    FinalScore.gynescore,
    FinalScore.neuroscore,
    FinalScore.rheumatoscore,
    FinalScore.heamatoscore,
    FinalScore.nephroscore,
    FinalScore.uroscore,
    FinalScore.orthoscore,
    FinalScore.neurosurgscore,
    FinalScore.plasticscore
  ];
  var finals = 0;
  for (var x in scores) {
    if (x > finals) {
      finals = x;
      FinalScore.speciality = _scoremap[x];
    }
  }
}
