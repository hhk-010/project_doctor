import 'package:project_doctor/services/finalscore.dart';

class disease5{
  String name;
  String sym1;
  String sym2;
  String sym3;
  String sym4;
  String rf1;
  String rf2;
  String rf3;
  String rf4;
  disease5(this.name,this.sym1,this.sym2,this.sym3,this.sym4,this.rf1,this.rf2,this.rf3,this.rf4);
}
maindisease5(String cc,
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
    String smok){
  //bleeding mean spontaneous not traumatic or un stoppable traumatic
  var ida=disease5('iron deficiency anemia','fatigue','palpitation','pallor','dyspnea','pregnancy','null','chronic intestinal disease','null');
  var mega=disease5('megaloblastic anemia','fatigue','palpitation','pallor','dyspnea','pregnancy','alcoholism','chronic intestinal disease','null');
  var aplas=disease5('aplastic anemia','fatigue','palpitation','pallor','dyspnea','bruising','bleeding','fever','null');
  var itp=disease5('itp','bruising','bleeding','bleeding','bruising','connective tissue disease','pregnancy','null','null');
  var ttp=disease5('TTP','pallor','palpitation','fatigue','bleeding','bruising','fever','fit','connective tissue disease');
  var heamop=disease5('heamophilia','bleeding','bleeding','joint swelling','null','family history','null','null','null');
  var vwd=disease5('von willbrand disease','bleeding','bleeding','bruising','null','family history','null','null','null');
  var dic=disease5('DIC','bleeding','bruising','jaundice','null','pregnancy','null','null','null');
  var henoch=disease5('henoch','joint pain','bruising','skin rash','bloody diarrhea','joint pain','null','null','null');
  var dvt=disease5('DVT','unilateral leg swelling','unilateral leg pain','null','null','pregnancy','null','null','null');
  //polycythemia to be left to the internist
  var aleu=disease5('acute leukemia','fatigue','palpitation','pallor','dyspnea','fever','bruising','bleeding','null');
  //cml will be left to the internist
  var cll=disease5('CLL','fatigue','palpitation','pallor','fever','null','null','null','null');
  // other leukemias to be left to the internist
  var hoglym=disease5('hodgkin lymphoma','lump','lump','fever','sweating','weight loss','null','null','null');
  //non hodgkin and mm will be left to internist
  var heamoly=disease5('heamolytic anemia','fatigue','palpitation','pallor','dyspnea','jaundice','family hsitory','null','null');



  var headache=disease5('primary and seconadary headache','headache','jaw pain','blindness','vomiting','pregnancy','obesity','null','null');
  var stroke=disease5('ischemic stroke','weakness','numbness','ataxia','blindness','DM','HTN','smoking','obesity');
  var stroke2=disease5('ischemic stroke','slurred speech','null','null','null','alcoholism','family history','null','null');
  //ich will be left as ER
  //seizure will be left as ER
  var mdis=disease5('movement disorders','tremer','abnormal movement','spasm','dysphagia','family history','null','null','null');
  var perneur=disease5('peripheral neuropathy','weakness','numbness','null','null','DM','connective tissue disease','null','null');
  var als=disease5('ALS','weakness','null','null','null','null','null','null','null');
  var dementia=disease5('dementia','memory loss','cognitive impairement','behavioral impairement','null','null','null','null','null');
  var ataxia=disease5('ataxia','ataxia','tremer','slurred speech','fever','DM','HTN','alcoholism','family history');
  var wernick=disease5('korsakoff syndrome','confusion','ataxia','double vision','memory loss','alcohlolism','pregnancy','malignancy','CKD');
  var oculopalsey=disease5('3rd nerve palsey','double vision','lid drop','numbness','null','DM','HTN','null','null');
  var facial=disease5('facial palsey','open eye','taste loss','mouth deviation','null','null','null','null','null');
  var ms=disease5('MS','weakness','numbness','blindness','double vision','slurred speech','ataxia','incontinence','tremer');
  var ms2=disease5('MS','slurred speech','dysphagia','null','null','null','null','null','null');
  var meningitis=disease5('meningitis','headache','fever','vomiting','double vision','photophobia','confusion','skin rash','weakness');
  var myopath=disease5('myopathies','weakness','null','null','null','family history','null','null','null');
  var myasthenia=disease5('myasthenia gravis','double vision','lid drop','weakness','dysphagia','null','null','null','null');
  var epilepsy=disease5('epilepsy','fit','other neurological problems','null','null','null','null','null','null');



  var oa=disease5('oa','joint pain','limitation of movement','null','null','family history','obesity','null','null');
  var ra=disease5('ra','joint pain','joint swelling','null','limitation of movement','family history','null','null','null');
  //osteomalacia to internist
  //osteoporosis to ortho
  var sle=disease5('SLE','skin lesion','hair problems','bleeding','bruising','fever','pallor','fatigue','joint pain');
  var sle2=disease5('SLE','dyspnea','confusion','chest pain','miscarriage','null','pregnancy','null','null');
  var sclero=disease5('scleroderma','skin lesion','skin redness','joint pain','limitation of movement','dyspnea','dysphagia','null','null');
  //sjogren ==diseases of  mouth will be left to the internist
  var polymyo=disease5('poly and dermatomyositis','weakness','skin lesion','skin redness','dyspnea','null','null','null','other msk problems');
  var gout=disease5('gout','joint pain','joint swelling','null','null','HTN','obesity','family history','alcoholism');
  var septic=disease5('septic arithritis','joint pain','joint swelling','limitation of movement','fever','null','null','null','null');
  var psorar=disease5('psoiatic arithritis','joint pain','joint swelling','limlitation of movement','skin lesion','deformity','family history','null','null');
  var juvar=disease5('juvenile arthritis','joint pain','joint swelling','limitation of movement','skin lesion','fever','null','null','null');
  var ass=disease5('ankylosing spondylitis','back pain','joint pain','joint swelling','limitation of movement','null','family history','null','null');
  var rea=disease5('reactive arthritis','joint pain','joint swelling','limitation of movement','back pain','null','family history','null','null');
  var vasculitis=disease5('vasculitis','joint pain','limitation of movement','dyspnea','heamoptysis','cough','skin lesion','confusion','connective tissue disease');
  var vasculitis2=disease5('vasculitis','heamaturia','null','null','null','null','null','null','null');


  var akickd=disease5('AKI and CKD','high blood urea > 90','high serum creatinine > 2','null','null','DM','HTN','null','null');
  var nephrotic=disease5('nephrotic syndrome','bilateral leg edema','null','null','null','null','null','null','null');


  var heam=[ida,mega,aplas,itp,ttp,heamop,vwd,dic,henoch,dvt,aleu,cll,hoglym,heamoly];
  var neuro=[headache,stroke,stroke2,mdis,perneur,als,dementia,ataxia,wernick,oculopalsey,facial,ms,ms2,meningitis,myopath,myasthenia,epilepsy];
  var rheum=[oa,ra,sle,sle2,sclero,polymyo,gout,septic,psorar,juvar,ass,rea,vasculitis,vasculitis2];
  var uro=[akickd,nephrotic];
  var h=0;
  var hh=heam.length;

  var n=0;
  var nn=neuro.length;

  var rh=0;
  var rhr=rheum.length;

  var u=0;
  var uu=uro.length;

  var heamsym=[heam[h].sym1,heam[h].sym2,heam[h].sym3,heam[h].sym4,heam[h].rf1,heam[h].rf2,heam[h].rf3,heam[h].rf4];
  var heamkey=0;
  var heamlen=heamsym.length;
  var neurosym=[neuro[n].sym1,neuro[n].sym2,neuro[n].sym3,neuro[n].sym4,neuro[n].rf1,neuro[n].rf2,neuro[n].rf3,neuro[n].rf4];
  var neurokey=0;
  var neurolen=neurosym.length;
  var rheusym=[rheum[rh].sym1,rheum[rh].sym2,rheum[rh].sym3,rheum[rh].sym4,rheum[rh].rf1,rheum[rh].rf2,rheum[rh].rf3,rheum[rh].rf4];
  var rheukey=0;
  var rheulen=rheusym.length;
  var urosym=[uro[u].sym1,uro[u].sym2,uro[u].sym3,uro[u].sym4,uro[u].rf1,uro[u].rf2,uro[u].rf3,uro[u].rf4];
  var urokey=0;
  var urolen=urosym.length;
  var chiefcom=cc;
  var others=[s2, s3, s4, s5, s6, s7];
  var o=0;
  var oo=others.length;
  var riskf=[c1,
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
    alcohol];
  var r=0;
  var rr=riskf.length;
  var heamscore=0;
  var neuroscore=0;
  var rheuscore=0;
  var nephroscore=0;
  while (hh>0){
    while(heamlen>0){
      if (chiefcom==heamsym[heamkey]){
        heamscore+=10;
      }
      while(oo>0){
        if (others[o]==heamsym[heamkey]){
          heamscore+=1;
        }
        o+=1;
        oo-=1;
      }
      while(rr>0){
        if (riskf[r]==heamsym[heamkey]){
          heamscore+=1;
        }
        r+=1;
        rr-=1;
      }
      o=0;
      oo=others.length;
      r=0;
      rr=riskf.length;
      heamlen-=1;
      heamkey+=1;
    }
    h+=1;
    hh-=1;
    if (hh>0){
      heamsym=[heam[h].sym1,heam[h].sym2,heam[h].sym3,heam[h].sym4,heam[h].rf1,heam[h].rf2,heam[h].rf3,heam[h].rf4];
      heamkey=0;
      heamlen=heamsym.length;
    }
  }
  while (nn>0){
    while(neurolen>0){
      if (chiefcom==neurosym[neurokey]){
        neuroscore+=10;
      }
      while(oo>0){
        if (others[o]==neurosym[neurokey]){
          neuroscore+=1;
        }
        o+=1;
        oo-=1;
      }
      while(rr>0){
        if (riskf[r]==neurosym[neurokey]){
          neuroscore+=1;
        }
        r+=1;
        rr-=1;
      }
      o=0;
      oo=others.length;
      r=0;
      rr=riskf.length;
      neurolen-=1;
      neurokey+=1;
    }
    n+=1;
    nn-=1;
    if (nn>0){
      neurosym=[neuro[n].sym1,neuro[n].sym2,neuro[n].sym3,neuro[n].sym4,neuro[n].rf1,neuro[n].rf2,neuro[n].rf3,neuro[n].rf4];
      neurokey=0;
      neurolen=neurosym.length;
    }
  }
  while (rhr>0){
    while(rheulen>0){
      if (chiefcom==rheusym[rheukey]){
        rheuscore+=10;
      }
      while(oo>0){
        if (others[o]==rheusym[rheukey]){
          rheuscore+=1;
        }
        o+=1;
        oo-=1;
      }
      while(rr>0){
        if (riskf[r]==rheusym[rheukey]){
          rheuscore+=1;
        }
        r+=1;
        rr-=1;
      }
      o=0;
      oo=others.length;
      r=0;
      rr=riskf.length;
      rheulen-=1;
      rheukey+=1;
    }
    rh+=1;
    rhr-=1;
    if (rhr>0){
      rheusym=[rheum[rh].sym1,rheum[rh].sym2,rheum[rh].sym3,rheum[rh].sym4,rheum[rh].rf1,rheum[rh].rf2,rheum[rh].rf3,rheum[rh].rf4];
      rheukey=0;
      rheulen=rheusym.length;
    }
  }
  while (uu>0){
    while(urolen>0){
      if (chiefcom==urosym[urokey]){
        nephroscore+=10;
      }
      while(oo>0){
        if (others[o]==urosym[urokey]){
          nephroscore+=1;
        }
        o+=1;
        oo-=1;
      }
      while(rr>0){
        if (riskf[r]==urosym[urokey]){
          nephroscore+=1;
        }
        r+=1;
        rr-=1;
      }
      o=0;
      oo=others.length;
      r=0;
      rr=riskf.length;
      urolen-=1;
      urokey+=1;
    }
    u+=1;
    uu-=1;
    if (uu>0){
      urosym=[uro[u].sym1,uro[u].sym2,uro[u].sym3,uro[u].sym4,uro[u].rf1,uro[u].rf2,uro[u].rf3,uro[u].rf4];
      urokey=0;
      urolen=urosym.length;
    }
  }
  print(heamscore);
  print(neuroscore);
  print(rheuscore);
  print(nephroscore);
  finalscore.nephroscore=nephroscore;
  finalscore.heamatoscore=heamscore;
  finalscore.neuroscore=neuroscore;
  finalscore.rheumatoscore=rheuscore;

}