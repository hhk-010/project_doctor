class finalscore {
  static int finale;
  static String speciality;
}

countfinal(int cvsscore, int respscore, int endoscore) {
  var _scoremap = {cvsscore: 'cardio',respscore:'respiratory',endoscore:'endocrine'};
  var scores=[cvsscore,respscore,endoscore];
  var finals=0;
  for (var x in scores){
    if (x>finals){
      finals=x;
      finalscore.speciality=_scoremap[x];
    }
  }
}
