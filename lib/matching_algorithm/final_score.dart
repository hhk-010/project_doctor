class FinalScore {
  static int finale;
  static String speciality = '';
  static String speciality2 = '';
  static String soeciality22 = '';
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
  static int opthascore;
  static int dermascore;
  static int psychoscore;
  static int entscore;
  static int age;
  static String or;
}

countfinal() {
  var _scoremap = {
    FinalScore.cvsscore: ['Cardiologist', 'Internist'],
    FinalScore.respscore: ['Pulmonologist', 'Internist'],
    FinalScore.endoscore: ['Endocrinologist', 'Internist'],
    FinalScore.gitscore: ['Enterologist', 'Internist'],
    FinalScore.generalscore: ['General Surgeon', 'General Surgeon'],
    FinalScore.thoracicscore: ['ThoracoVascular Surgeon', 'ThoracoVascular Surgeon'],
    FinalScore.erscore: ['Emergency physician', 'Emergency physician'],
    FinalScore.internscore: ['Internist', 'Internist'],
    FinalScore.gynescore: ['Gynecologist', 'Gynecologist'],
    FinalScore.rheumatoscore: ['Rheumatologist', 'Rheumatologist'],
    FinalScore.nephroscore: ['Nephrologist', 'Internist'],
    FinalScore.heamatoscore: ['Heamatologist', 'Internist'],
    FinalScore.neuroscore: ['Neurologist', 'Neurologist'],
    FinalScore.uroscore: ['Urosurgeon', 'Urosurgeon'],
    FinalScore.orthoscore: ['Orthopaedic Surgeon', 'Orthopaedic Surgeon'],
    FinalScore.neurosurgscore: ['Neurosurgeon', 'Neurosurgeon'],
    FinalScore.plasticscore: ['Plastic Surgeon', 'Plastic Surgeon'],
    FinalScore.opthascore: ['Ophthalmologist', 'Ophthalmologist'],
    FinalScore.dermascore: ["Dermatologist", "Dermatologist"],
    FinalScore.psychoscore: ['Psychiatrist', 'Psychiatrist'],
    FinalScore.entscore: ["Laryngologist", "Laryngologist"]
  };
  if (FinalScore.age < 15) {
    _scoremap[FinalScore.cvsscore][0] = 'Pediatrician';
    _scoremap[FinalScore.cvsscore][1] = 'Pediatrician';
    _scoremap[FinalScore.respscore][0] = 'Pediatrician';
    _scoremap[FinalScore.respscore][1] = 'Pediatrician';
    _scoremap[FinalScore.endoscore][0] = 'Pediatrician';
    _scoremap[FinalScore.endoscore][1] = 'Pediatrician';
    _scoremap[FinalScore.gitscore][0] = 'Pediatrician';
    _scoremap[FinalScore.gitscore][1] = 'Pediatrician';
    _scoremap[FinalScore.generalscore][0] = 'Pediatric Surgeon';
    _scoremap[FinalScore.generalscore][1] = 'Pediatric Surgeon';
    _scoremap[FinalScore.internscore][0] = 'Pediatrician';
    _scoremap[FinalScore.internscore][1] = 'Pediatrician';
    _scoremap[FinalScore.rheumatoscore][0] = 'Pediatrician';
    _scoremap[FinalScore.rheumatoscore][1] = 'Pediatrician';
    _scoremap[FinalScore.nephroscore][0] = 'Pediatrician';
    _scoremap[FinalScore.nephroscore][1] = 'Pediatrician';
    _scoremap[FinalScore.heamatoscore][0] = 'Pediatrician';
    _scoremap[FinalScore.heamatoscore][1] = 'Pediatrician';
    _scoremap[FinalScore.neuroscore][0] = 'Pediatrician';
    _scoremap[FinalScore.neuroscore][1] = 'Pediatrician';
  }

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
    FinalScore.plasticscore,
    FinalScore.dermascore,
    FinalScore.psychoscore,
    FinalScore.entscore,
    FinalScore.opthascore
  ];
  var finals = 0;
  for (var x in scores) {
    if (x > finals) {
      finals = x;
      FinalScore.speciality = _scoremap[x][0];
      if (_scoremap[x][0] != _scoremap[x][1]) {
        FinalScore.speciality2 = _scoremap[x][1];
        FinalScore.or = "Or";
      } else {
        FinalScore.speciality2 = '';
        FinalScore.or = "";
      }
    }
  }
}
