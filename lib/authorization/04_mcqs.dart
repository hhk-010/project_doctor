import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project_doctor/constants/theme.dart';
import 'package:project_doctor/services/database.dart';
import 'package:provider/provider.dart';

class MCQS extends StatefulWidget {
  final Function premcq;
  final Function mcq;
  final Function toggleview;
  MCQS({this.premcq, this.mcq, this.toggleview});
  @override
  _MCQSState createState() => _MCQSState();
}

class _MCQSState extends State<MCQS> {
  bool _isInternet = true;
  checkInternet() async {
    try {
      final response = await InternetAddress.lookup('google.com');
      if (response.isNotEmpty && response[0].rawAddress.isNotEmpty) {
        _isInternet = true; // internet
        setState(() {});
      }
    } on SocketException catch (_) {
      _isInternet = false; // no internet
      setState(() {});
    }
  }

  //-----------------this function will return a snackbar instead of the old one
  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();
  _showSnackBar() {
    final _snackbar = new SnackBar(
      content: Text(
        QuestionsShuffle.snackerror,
        style: TextStyle(fontSize: 15),
      ),
      backgroundColor: Colors.deepOrange,
    );
    _scaffoldkey.currentState.showSnackBar(_snackbar);
  }

  @override
  void initState() {
    checkInternet();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamProvider<QuerySnapshot>.value(
      value: DatabaseService().doctorDataProfileStream,
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Scaffold(
          key: _scaffoldkey,
          backgroundColor: Colors.grey[200],
          appBar: AppBar(
            backgroundColor: Colors.deepOrange,
            actions: [
              // FlatButton.icon(
              //   onPressed: () {
              //     widget.premcq();
              //   },
              //   icon: Icon(
              //     Icons.arrow_back,
              //     color: Colors.white,
              //   ),
              //   label: Text(
              //     'Sign in',
              //     style: TextStyle(color: Colors.white),
              //   ),
              // ),
              FlatButton.icon(
                onPressed: () {
                  checkInternet();
                  if (_isInternet) {
                    getscore1b();
                    getscore2b();
                    getscore3b();
                    //getscore4b();
                    if (QuestionsShuffle.score >= 3) {
                      if (QuestionsShuffle.lenght > 3) {
                        setState(() {
                          QuestionsShuffle.counter += 3;
                          QuestionsShuffle.lenght -= 3;
                        });
                      } else {
                        setState(() {
                          QuestionsShuffle.counter = 0;
                          QuestionsShuffle.lenght =
                              QuestionsShuffle.questions.length;
                        });
                      }
                      DatabaseService(uid: QuestionsShuffle.uid).updateUserData(
                          QuestionsShuffle.counter.toString(),
                          'counter',
                          '0101001101010022',
                          QuestionsShuffle.lenght.toString(),
                          0.0000023003,
                          0.0000054003,
                          '',
                          '',
                          '');
                      widget.mcq();
                    } else {
                      setState(() {
                        QuestionsShuffle.snackerror =
                            'Please , answer the questions correctly';
                      });
                      _showSnackBar();
                    }
                  } else {
                    setState(() {
                      QuestionsShuffle.snackerror = 'No internet connection';
                    });
                    _showSnackBar();
                  }
                  setState(() {
                    QuestionsShuffle.score = 0;
                  });
                },
                icon: Icon(
                  Icons.arrow_forward,
                  color: Colors.white,
                ),
                label: Text(
                  'Next',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
          body: Questions(),
        ),
      ),
    );
  }
}

class Questions extends StatefulWidget {
  @override
  _QuestionsState createState() => _QuestionsState();
}

class _QuestionsState extends State<Questions> {
  @override
  Widget build(BuildContext context) {
    final questInfo = Provider.of<QuerySnapshot>(context);
    if (questInfo != null) {
      for (var y in questInfo.docs) {
        if (y.data()['phoneNumber'] == '0101001101010022') {
          QuestionsShuffle.uid = y.id;
          QuestionsShuffle.counter = int.parse(y.data()['name']);
          QuestionsShuffle.lenght = int.parse(y.data()['province']);
        }
      }
    }
  
    
   

    return Directionality(
      textDirection: TextDirection.ltr,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                'To register , answer the following :',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 15.0,
              ),
              Container(
                decoration: boxDecorationPatient,
                padding: EdgeInsets.symmetric(vertical: 30.0, horizontal: 30.0),
                child: Column(
                  children: [
                    Center(
                      child: Text(
                        QuestionsShuffle.questions[QuestionsShuffle.counter],
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    DropdownButton(
                      // value: QuestionsShuffle.value1,
                      isExpanded: true,
                      hint: Text('Choose the Right answer'),
                      items: [
                        DropdownMenuItem<String>(
                          value: '0',
                          child: Text(
                            QuestionsShuffle.choices[QuestionsShuffle
                                .questions[QuestionsShuffle.counter]][0],
                            textAlign: TextAlign.left,
                          ),
                        ),
                        DropdownMenuItem<String>(
                          value: '1',
                          child: Text(QuestionsShuffle.choices[QuestionsShuffle
                              .questions[QuestionsShuffle.counter]][1]),
                        ),
                        DropdownMenuItem<String>(
                          value: '2',
                          child: Text(QuestionsShuffle.choices[QuestionsShuffle
                              .questions[QuestionsShuffle.counter]][2]),
                        ),
                        DropdownMenuItem<String>(
                          value: '3',
                          child: Text(QuestionsShuffle.choices[QuestionsShuffle
                              .questions[QuestionsShuffle.counter]][3]),
                        ),
                        DropdownMenuItem<String>(
                          value: '4',
                          child: Text(QuestionsShuffle.choices[QuestionsShuffle
                              .questions[QuestionsShuffle.counter]][4]),
                        ),
                        DropdownMenuItem<String>(
                          value: '5',
                          child: Text(QuestionsShuffle.choices[QuestionsShuffle
                              .questions[QuestionsShuffle.counter]][5]),
                        ),
                      ],
                      onChanged: (value) => selected1b(value),
                      // value: QuestionsShuffle.value1,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              Container(
                decoration: boxDecorationPatient,
                padding: EdgeInsets.symmetric(vertical: 30.0, horizontal: 30.0),
                child: Column(
                  children: [
                    Center(
                      child: Text(
                        QuestionsShuffle
                            .questions[QuestionsShuffle.counter + 1],
                        textAlign: TextAlign.justify,
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    DropdownButton(
                      isExpanded: true,
                      hint: Text('Choose the Right answer'),
                      items: [
                        DropdownMenuItem<String>(
                          value: '0',
                          child: Text(QuestionsShuffle.choices[QuestionsShuffle
                              .questions[QuestionsShuffle.counter + 1]][0]),
                        ),
                        DropdownMenuItem<String>(
                          value: '1',
                          child: Text(QuestionsShuffle.choices[QuestionsShuffle
                              .questions[QuestionsShuffle.counter + 1]][1]),
                        ),
                        DropdownMenuItem<String>(
                          value: '2',
                          child: Text(QuestionsShuffle.choices[QuestionsShuffle
                              .questions[QuestionsShuffle.counter + 1]][2]),
                        ),
                        DropdownMenuItem<String>(
                          value: '3',
                          child: Text(QuestionsShuffle.choices[QuestionsShuffle
                              .questions[QuestionsShuffle.counter + 1]][3]),
                        ),
                        DropdownMenuItem<String>(
                          value: '4',
                          child: Text(QuestionsShuffle.choices[QuestionsShuffle
                              .questions[QuestionsShuffle.counter + 1]][4]),
                        ),
                        DropdownMenuItem<String>(
                          value: '5',
                          child: Text(QuestionsShuffle.choices[QuestionsShuffle
                              .questions[QuestionsShuffle.counter + 1]][5]),
                        ),
                      ],
                      onChanged: (value) => selected2b(value),
                      // value: QuestionsShuffle.value2,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              Container(
                decoration: boxDecorationPatient,
                padding: EdgeInsets.symmetric(vertical: 30.0, horizontal: 30.0),
                child: Column(
                  children: [
                    Center(
                      child: Text(
                        QuestionsShuffle
                            .questions[QuestionsShuffle.counter + 2],
                        textAlign: TextAlign.justify,
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    DropdownButton(
                      isExpanded: true,
                      hint: Text('Choose the Right answer'),
                      items: [
                        DropdownMenuItem<String>(
                          value: '0',
                          child: Text(QuestionsShuffle.choices[QuestionsShuffle
                              .questions[QuestionsShuffle.counter + 2]][0]),
                        ),
                        DropdownMenuItem<String>(
                          value: '1',
                          child: Text(QuestionsShuffle.choices[QuestionsShuffle
                              .questions[QuestionsShuffle.counter + 2]][1]),
                        ),
                        DropdownMenuItem<String>(
                          value: '2',
                          child: Text(QuestionsShuffle.choices[QuestionsShuffle
                              .questions[QuestionsShuffle.counter + 2]][2]),
                        ),
                        DropdownMenuItem<String>(
                          value: '3',
                          child: Text(QuestionsShuffle.choices[QuestionsShuffle
                              .questions[QuestionsShuffle.counter + 2]][3]),
                        ),
                        DropdownMenuItem<String>(
                          value: '4',
                          child: Text(QuestionsShuffle.choices[QuestionsShuffle
                              .questions[QuestionsShuffle.counter + 2]][4]),
                        ),
                        DropdownMenuItem<String>(
                          value: '5',
                          child: Text(QuestionsShuffle.choices[QuestionsShuffle
                              .questions[QuestionsShuffle.counter + 2]][5]),
                        ),
                      ],
                      onChanged: (value) => selected3b(value),
                      // value: QuestionsShuffle.value3,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class QuestionsShuffle {
  static var uid;
  static int counter = 0;
  static int lenght = questions.length;
  static String value1;
  static String value2;
  static String value3;
  static String value4;
  static int score = 0;
  static String snackerror = '';
  static List questions = [
    '60 years old male with +ve PMH for HTN and DM presented to the ER complaining of central suffocating chest pain, dyspnea and vomiting OE conscious ,alert ,oriented ,looks ill ,BP 190/100,ecg shows St segment elevation in L1,avL,V5,V6 with reciprocal changes and elevated troponin,what is the most likely dx?',
    '65 years old male with +ve PMH for HTN,ischemic heart disease with previous CCU admissions,presented with dyspnea ,cough and white colored sputum ,OE he was dyspneic ,BP 100/60 ,chest auscultation reveals bilateral basal crepitations he brought his previous investigations with him and his echocardiogram shows EF=30%, and his current ecg shows old ischemic changes and his current WBC count is normal but his PCV is relatively low ,what is the most likely dx?',
    '15 years old female pt known case of type 1 DM developed ,flu like illness and fever followed by polyuria , polydipsia,abdominal pain and vomiting , associated with fruity odor breathing ,presented to the ER , her pulse rate is 120 bpm,temp is 38 C axillary corrected, she looks tachypneic, her RBS is about 500 mg/dl and her ABG shows elevated pH,what is the most likely dx?',
    '6 years old girl with -v PMH presented to the ER with moderate to severe abdominal pain (started few hours before presentation) in the umbilical area and shifted to the Rt iliac fossa , associated with nausea, vomiting , anorexia, fever, OE she looks ill with tachycardia , her abdominal examination shows Rt iliac fossa tenderness and positive rebound tenderness, her WBC count was > 13000,what is the most likely dx?',
    '70 years old male patient with +ve PMH for DM,chronic renal failure on insulin and scheduled hemodialysis presented to the ER with coma which he developed right before presentation his BP was 140/90, PR was normal ,neurological examination shows no focal neurological deficit as a matter of urgency he was given hypertonic solution with rapid regaining of his consciousness level his brain imaging was normal and his biochemistry (apart from low RBS) was acceptable, what is the most likely dx?',
    '65 years old male heavy smoker (5 packs/day) with -ve PMH presented to the clinic with dyspnea,cough ,sputum,general examination reveals generalized muscle wasting ,chest auscultation reveals decrease air entry , normal vesicular breathing ,wheeze all over the chest,his chest X-ray reveals mediastinal narrowing and flattened diaphragm, what is the most likely dx?',
    '18 years old female presented to the ER with motor vehicle accident,regarding ABC of trauma ,her airway was patent ,she was looking dyspneic,OE she was hypotensive and her PR was 130 BPM ,her chest examination reveals deviation of trachea and apex beat to the left side,and diminished air entry in the right side and audible S1,S2,what is the most likely dx?',
    '6 years old girl with -ve PMH , healthy wealthy was eating peanut for the first time, she suddenly developed generalized skin redness her parents brought her to the ER on there way her condition had been deteriorated, in the ER  BP was very low ,her PR was elevated and she developed cold extremities , she was given IM adrenaline with good response, what is the most likely dx?',
    '34 years old male ,heavy weight lifter with -ve PMH , developed back pain after his exercise,treated by mobic 7.5 mg twice daily with good response after few weeks without discontinuing his treatment,he presented to the ER with abdominal pain and coffee ground vomiting,what is the most likely dx?',
    '30 years old female with -ve PMH developed Rt leg pain and swelling associated with redness of the leg , OE her leg was hot and red with +ve homans sign with no other significant abnormality in examination , her D-dimer level was elevated , what is the most likely dx?',
    '58 years old female with history of unresectable CA colon developed colicky abdominal pain and constipation , the pain increased in severity and she also developed abdominal distension and vomiting,in the ER she was dehydrated and her pulse rate was elevated,abdominal auscultation reveals absent bowel sounds , her abdominal plain X-ray shows dilated bowel loops with air fluid level , what is the most likely dx?',
    '34 years old female with multiple visits to the ER for severe attacks of left flank pain that radiates to the groin, with nausea and vomiting but no fever presented with the same problem ,her back examination shows +ve left renal angle tenderness , her general urine examination shows microscopic hematuria, what is the most likely dx?',
    '52 years old male known case of uncontrolled HTN developed loss of consciousness after domestic stressful event,presented to the ER after few hours of his unconsciousness his BP was 240/120 mm Hg ,unconscious , dysnpneic with clear chest on auscultation , his neurological examination reveals  GCS about 8 and +ve babinski sign in the Rt side,his CT scan reveals white lesion in the left side of the brain and his biochemistry  panel was near normal , what is the most likely dx?',
    /**/ '21 years old female developed butterfly rash on her face  associated with joint pain in multiple regions ,she also developed ecchymosis in multiple sites her investigations reveals elevated anti nuclear antibody and anti double stranded antibody,what is the most likely dx?',
    '33 years old male , heavy weight lifter with -ve PMH developed , back pain few weeks ago radiated to the left thigh , associated with numbness of the left thigh his lumber spine X-ray looks normal, his MRI of lumber spine reveals normal alignment of the vertebrae but narrowing of the spinal canal between the levels L3-L4 with a bulge between the 2 vertebrae(L3-L4) ,what is the most likely dx?',
    '5 years old male with +ve PMH of X linked coagulation disorder developed massive knee joint swelling after falling on the ground, his joint aspiration reveals fresh blood, what is the most likely dx?',
    '7 years old male with +ve family history for x-linked RBC disorder developed generalized pallor and dark color urine  after eating fava beans, his examination reveals ,yellowish discoloration of the sclera ,his PCV was 26% , with normal WBC and platelet count his TSB was elevated with normal direct portion, what is the most likely dx?',
    '40 years old female with -ve PMH , on NSAIDs for generalized joint pain that she developed few months ago , presented to the ER with severe epigastric pain and nausea , OE she looks ill her PR was elevated , abdominal examination reveals epigastric tenderness with +ve guarding and rigidity of the abdomen , her erect CXR shows air under diaphragm ,what is  the most likely dx?',
    '25 years old male with untreated indirect inguinal hernia developed central colicky abdominal pain associated with tender irreducible scrotal swelling with absolute constipation and abdominal distension , OE his PR was elevated , his abdominal auscultation reveals absent bowel sounds , what is the most likely dx ?',
    '67 years old male with +ve PMH for DM , HTN , coronary artery disease , and previous CCU admission , developed sudden loss of consciousness at home , in the ER there were impalpable peripheral pulses , the monitor of the defibrillator shows flattening of cardiac activity , what is the most likely dx at that moment ?',
    '70 years old male smoker (5 packs/day) known case of COPD presented with recently developed continuous dyspnea , copious sputum and hemoptysis associated with hoarseness of the voice with no pyrexia , OE he was cachaxic with central cyanosis and finger clubbing , chest auscultation reveals diminished air entry , his CXR reveals upper mediastinal widening with no other significant abnormality his ESR was elevated , what is the most likely dx ?',
    '20 years old pregnant female with -ve PMH developed abdominal trauma that caused her massive vaginal hemorrhage , she was brought to the ER , her pulse was low volume with elevated rate and she had cold extremities , with low BP , what is the most likely dx ?',
    '60 years old male with +ve PMH of untreated benign prostatic hyperplasia that made him having repeated UTI , he developed , bilateral flank pain with nausea , vomiting , fever and rigor , he rejected medical advice until his condition had deteriorated , he was brought to the ER and OE he was unconscious , his PR was elevated with low volume , BP was unmeasurable , and he had cold peripheries , his WBC was 20,000 and CRP was elevated , what is the most likely dx?',
    '60 years old female with +ve PMH for HTN and DM presented to the ER complaining of chest pain , stabbing in nature associated with shortness of breath , her BP was 200/100 and her chest examination was near near normal , her ecg shows ST segment depression in Leads II,III,aVF , her cardiac troponins was elevated , what is the most likely dx ?',
    '23 years old female with -ve PMH developed RTA and trauma to her neck , she was admitted to the ER and her airway was patent , her breathing was near normal , her BP was very low and she had bradycardia chest examination was near normal and her abdominal US reveals no obvious abnormality , she was given 2 pints of N/S with no response , what is the most likely dx ?',
    '25 years old pregnant female with with -ve PMH developed left leg pain and swelling associated with redness of the leg after few days she developed chest pain and shortness of breath , on examination her leg was warm and her chest was clear , her ecg show sinus tachycardia and her D-dimer level was elevated , what is the most likely dx ?',
    '27 years old pregnant female developed vaginal bleeding , she was admitted to the ER , her pulse rate was elevated , BP was low , with cold peripheries her B.urea was 120 mg/dl and her serum creatinine was 2.2 mg/dl , what is the most likely cause of her elevated renal indices ?',
    //'56 years old male non diabetic with untreated benign prostatic hyperplasia , presented to the ER with confusion associated with bilateral leg edema and generalized swelling of the body , his general examination reveals hypertension and near normal pulse , his chest examination shows decrease air entry on the right side , his abdominal examination reveals abdominal distension , his chest X-ray show Rt lower zone radio-opacity obliterating Rt costophrenic angle , his B.urea was 145 mg/dl and his S. creatinine was 2.5 mg/dl , and S.k was 5.5 mmol/l ,what is the most likely dx ?',
  ];
  static Map choices = {
    '60 years old male with +ve PMH for HTN and DM presented to the ER complaining of central suffocating chest pain, dyspnea and vomiting OE conscious ,alert ,oriented ,looks ill ,BP 190/100,ecg shows St segment elevation in L1,avL,V5,V6 with reciprocal changes and elevated troponin,what is the most likely dx?':
        [
      '-stroke',
      '-pericarditis',
      '-pulseless electrical activity',
      '-ventricular fibrillation',
      '-acute MI',
      '-pectoralis spasm'
    ],
    '65 years old male with +ve PMH for HTN,ischemic heart disease with previous CCU admissions,presented with dyspnea ,cough and white colored sputum ,OE he was dyspneic ,BP 100/60 ,chest auscultation reveals bilateral basal crepitations he brought his previous investigations with him and his echocardiogram shows EF=30%, and his current ecg shows old ischemic changes and his current WBC count is normal but his PCV is relatively low ,what is the most likely dx?':
        [
      '-lobar pneumonia',
      '-asthma',
      '-pleural effusion',
      '-atrial septal defect',
      '-pulmonary embolism',
      '-heart failure exacerbation'
    ],
    '15 years old female pt known case of type 1 DM developed ,flu like illness and fever followed by polyuria , polydipsia,abdominal pain and vomiting , associated with fruity odor breathing ,presented to the ER , her pulse rate is 120 bpm,temp is 38 C axillary corrected, she looks tachypneic, her RBS is about 500 mg/dl and her ABG shows elevated pH,what is the most likely dx?':
        [
      '-tonsillitis',
      '-gastroenteritis',
      '-diabetes insipidus',
      '-hypercalcemia',
      '-UTI',
      '-DKA with intercurrent infection'
    ],
    '6 years old girl with -v PMH presented to the ER with moderate to severe abdominal pain (started few hours before presentation) in the umbilical area and shifted to the Rt iliac fossa , associated with nausea, vomiting , anorexia, fever, OE she looks ill with tachycardia , her abdominal examination shows Rt iliac fossa tenderness and positive rebound tenderness, her WBC count was > 13000,what is the most likely dx?':
        [
      '-gastroenteritis',
      '-chronic pancreatitis',
      '-inguinal hernia',
      '-acute appendicitis',
      '-abdominal aortic aneurysm',
      '-left ureteric stone'
    ],
    '70 years old male patient with +ve PMH for DM,chronic renal failure on insulin and scheduled hemodialysis presented to the ER with coma which he developed right before presentation his BP was 140/90, PR was normal ,neurological examination shows no focal neurological deficit as a matter of urgency he was given hypertonic solution with rapid regaining of his consciousness level his brain imaging was normal and his biochemistry (apart from low RBS) was acceptable, what is the most likely dx?':
        [
      '-intracranial hemorrhage',
      '-meningoencephalitis',
      '-acute attack of hypoglycemia',
      '-hyponatremia',
      '-chronic subdural hematoma',
      '-hypernatremia',
    ],
    '65 years old male heavy smoker (5 packs/day) with -ve PMH presented to the clinic with dyspnea,cough ,sputum,general examination reveals generalized muscle wasting ,chest auscultation reveals decrease air entry , normal vesicular breathing ,wheeze all over the chest,his chest X-ray reveals mediastinal narrowing and flattened diaphragm, what is the most likely dx?':
        [
      '-lobar pneumonia',
      '-COPD',
      '-pulmonary embolism',
      '-pleural effusion',
      '-pericarditis',
      '-cardiac tamponade'
    ],
    '18 years old female presented to the ER with motor vehicle accident,regarding ABC of trauma ,her airway was patent ,she was looking dyspneic,OE she was hypotensive and her PR was 130 BPM ,her chest examination reveals deviation of trachea and apex beat to the left side,and diminished air entry in the right side and audible S1,S2,what is the most likely dx?':
        [
      '-foreign body aspiration',
      '-pulmonary embolism',
      '-tension pneumothorax',
      '-cardiac tamponade',
      '-asthma exacerbation',
      '-HYS'
    ],
    '6 years old girl with -ve PMH , healthy wealthy was eating peanut for the first time, she suddenly developed generalized skin redness her parents brought her to the ER on there way her condition had been deteriorated, in the ER  BP was very low ,her PR was elevated and she developed cold extremities , she was given IM adrenaline with good response, what is the most likely dx?':
        [
      '-septic shock',
      '-pneumothorax',
      '-cardiogenic shock',
      '-hypovolemic shock',
      '-anaphylaxis',
      '-neurogenic shock',
    ],
    '34 years old male ,heavy weight lifter with -ve PMH , developed back pain after his exercise,treated by mobic 7.5 mg twice daily with good response after few weeks without discontinuing his treatment,he presented to the ER with abdominal pain and coffee ground vomiting,what is the most likely dx?':
        [
      '-acute appendicitis',
      '-acute pyelonephritis',
      '-peptic ulcer disease',
      '-musculoskeletal pain',
      '-colorectal ca',
      '-chronic pancreatitis'
    ],
    '58 years old female with history of unresectable CA colon developed colicky abdominal pain and constipation , the pain increased in severity and she also developed abdominal distension and vomiting,in the ER she was dehydrated and her pulse rate was elevated,abdominal auscultation reveals absent bowel sounds , her abdominal plain X-ray shows dilated bowel loops with air fluid level , what is the most likely dx?':
        [
      '-perforated DU',
      '-acute MI',
      '-non strangulated inguinal hernia',
      '-large bowel obstruction',
      '-mesenteric lymphadenitis',
      '-renal stone disease'
    ],
    '34 years old female with multiple visits to the ER for severe attacks of left flank pain that radiates to the groin, with nausea and vomiting but no fever presented with the same problem ,her back examination shows +ve left renal angle tenderness , her general urine examination shows microscopic hematuria, what is the most likely dx?':
        [
      '-Right lower lobe pneumonia',
      '-disc prolapse',
      '-abdominal aortic aneurysm',
      '-nephrolithiasis',
      '-chronic pancreatitis',
      '-gastroenteritis',
    ],
    '52 years old male known case of uncontrolled HTN developed loss of consciousness after domestic stressful event,presented to the ER after few hours of his unconsciousness his BP was 240/120 mm Hg ,unconscious , dysnpneic with clear chest on auscultation , his neurological examination reveals  GCS about 8 and +ve babinski sign in the Rt side,his CT scan reveals white lesion in the left side of the brain and his biochemistry  panel was near normal , what is the most likely dx?':
        [
      '-hyponatremia',
      '-ischemic stroke',
      '-hypoglycemia',
      '-uremic encephalopathy',
      '-hypercalcemia',
      '-ICH'
    ],
    '21 years old female developed butterfly rash on her face  associated with joint pain in multiple regions ,she also developed ecchymosis in multiple sites her investigations reveals elevated anti nuclear antibody and anti double stranded antibody,what is the most likely dx?':
        [
      '-contact dermatitis',
      '-osteoarthritis',
      '-SLE',
      '-vitiligo',
      '-seborrheic dermatitis',
      '-fungal infection',
    ],
    '33 years old male , heavy weight lifter with -ve PMH developed , back pain few weeks ago radiated to the left thigh , associated with numbness of the left thigh his lumber spine X-ray looks normal, his MRI of lumber spine reveals normal alignment of the vertebrae but narrowing of the spinal canal between the levels L3-L4 with a bulge between the 2 vertebrae(L3-L4) ,what is the most likely dx?':
        [
      '-lumber disc prolapse',
      '-B12 deficiency',
      '-cervical spine prolapse',
      '-renal stone disease',
      '-diabetic neuropathy',
      '-B6 deficiency',
    ],
    '5 years old male with +ve PMH of X linked coagulation disorder developed massive knee joint swelling after falling on the ground, his joint aspiration reveals fresh blood, what is the most likely dx?':
        [
      '-hemolytic anemia',
      '-thalassemia',
      '-acquired bleeding tendency disorder',
      '-hemophilia',
      '-DVT',
      '-septic arthritis'
    ],
    '7 years old male with +ve family history for x-linked RBC disorder developed generalized pallor and dark color urine  after eating fava beans, his examination reveals ,yellowish discoloration of the sclera ,his PCV was 26% , with normal WBC and platelet count his TSB was elevated with normal direct portion, what is the most likely dx?':
        [
      '-hepatitis A',
      '-common bile duct stone',
      '-G6PD deficiency',
      '-iron deficiency anemia',
      '-aplastic anemia',
      '-UTI',
    ],
    '40 years old female with -ve PMH , on NSAIDs for generalized joint pain that she developed few months ago , presented to the ER with severe epigastric pain and nausea , OE she looks ill her PR was elevated , abdominal examination reveals epigastric tenderness with +ve guarding and rigidity of the abdomen , her erect CXR shows air under diaphragm ,what is  the most likely dx?':
        [
      '-lower lobe pneumonia',
      '-intestinal obstruction',
      '-perforated PU',
      '-indirect inguinal hernia',
      '-direct inguinal hernia',
      '-nephrolithiasis',
    ],
    '25 years old male with untreated indirect inguinal hernia developed central colicky abdominal pain associated with tender irreducible scrotal swelling with absolute constipation and abdominal distension , OE his PR was elevated , his abdominal auscultation reveals absent bowel sounds , what is the most likely dx ?':
        [
      '-non strangulated incisional hernia',
      '-nephrolithiasis',
      '-strangulated inguinal hernia',
      '-irritable bowel syndrome',
      '-acute lower UTI',
      '-testicular trauma',
    ],
    '67 years old male with +ve PMH for DM , HTN , coronary artery disease , and previous CCU admission , developed sudden loss of consciousness at home , in the ER there were impalpable peripheral pulses , the monitor of the defibrillator shows flattening of cardiac activity , what is the most likely dx at that moment ?':
        [
      '-SVT',
      '-sinus tachycardia',
      '-VT with +ve pulse',
      '-asystole',
      '-atrial fibrillation',
      '-atrial flutter',
    ],
    '70 years old male smoker (5 packs/day) known case of COPD presented with recently developed continuous dyspnea , copious sputum and hemoptysis associated with hoarseness of the voice with no pyrexia , OE he was cachaxic with central cyanosis and finger clubbing , chest auscultation reveals diminished air entry , his CXR reveals upper mediastinal widening with no other significant abnormality his ESR was elevated , what is the most likely dx ?':
        [
      '-pulmonary edema',
      '-traumatic lung contusion',
      '-bronchogenic CA',
      '-pulmonary embolism',
      '-bronchospasm',
      '-bronchopneumonia',
    ],
    '20 years old pregnant female with -ve PMH developed abdominal trauma that caused her massive vaginal hemorrhage , she was brought to the ER , her pulse was low volume with elevated rate and she had cold extremities , with low BP , what is the most likely dx ?':
        [
      '-cardiogenic shock',
      '-neurogenic shock',
      '-septic shock',
      '-anaphylaxsis',
      '-hypovolemia',
      '-spontaneous pneumothorax',
    ],
    '60 years old male with +ve PMH of untreated benign prostatic hyperplasia that made him having repeated UTI , he developed , bilateral flank pain with nausea , vomiting , fever and rigor , he rejected medical advice until his condition had deteriorated , he was brought to the ER and OE he was unconscious , his PR was elevated with low volume , BP was unmeasurable , and he had cold peripheries , his WBC was 20,000 and CRP was elevated , what is the most likely dx?':
        [
      '-hypovolemia',
      '-neurogenic shock',
      '-cardiogenic shock',
      '-septic shock',
      '-massive pulmonary embolism',
      '-pneumothorax',
    ],
    '60 years old female with +ve PMH for HTN and DM presented to the ER complaining of chest pain , stabbing in nature associated with shortness of breath , her BP was 200/100 and her chest examination was near near normal , her ecg shows ST segment depression in Leads II,III,aVF , her cardiac troponins was elevated , what is the most likely dx ?':
        [
      '-musculoskeletal chest pain',
      '-Non ST segment elevation MI',
      '-pleuritic chest pain',
      '-herpes zoster',
      '-asthma',
      '-pulmonary embolism',
    ],
    '23 years old female with -ve PMH developed RTA and trauma to her neck , she was admitted to the ER and her airway was patent , her breathing was near normal , her BP was very low and she had bradycardia chest examination was near normal and her abdominal US reveals no obvious abnormality , she was given 2 pints of N/S with no response , what is the most likely dx ?':
        [
      '-hypovolemic shock',
      '-anaphylaxis',
      '-cardiac tamponade',
      '-tension pneumothorax',
      '-septic shock',
      '-neurogenic shock',
    ],
    '25 years old pregnant female with with -ve PMH developed left leg pain and swelling associated with redness of the leg after few days she developed chest pain and shortness of breath , on examination her leg was warm and her chest was clear , her ecg show sinus tachycardia and her D-dimer level was elevated , what is the most likely dx ?':
        [
      '-asthma',
      '-lobar pneumonia',
      '-pleural effusion',
      '-pulmonary thromboemolism',
      '-pneumothorax',
      '-acute MI',
    ],
    '30 years old female with -ve PMH developed Rt leg pain and swelling associated with redness of the leg , OE her leg was hot and red with +ve homans sign with no other significant abnormality in examination , her D-dimer level was elevated , what is the most likely dx?':
        [
      '-Rt side heart failure',
      '-cellulitis',
      '-DVT',
      '-protein energy malnutrition',
      '-myxedema',
      '-chronic liver disease',
    ],
    '56 years old male non diabetic with untreated benign prostatic hyperplasia , presented to the ER with confusion associated with bilateral leg edema and generalized swelling of the body , his general examination reveals hypertension and near normal pulse , his chest examination shows decrease air entry on the right side , his abdominal examination reveals abdominal distension , his chest X-ray show Rt lower zone radio-opacity obliterating Rt costophrenic angle , his B.urea was 145 mg/dl and his S. creatinine was 2.5 mg/dl , and S.k was 5.5 mmol/l ,what is the most likely dx ?':
        [
      '-pre-renal renal impairment',
      '-nephrotoxic drug misuse',
      '-post-renal renal impairment',
      '-diabetic nephropathy',
      '-intrinsic renal disease',
      '-contrast nephropathy',
    ],
    '27 years old pregnant female developed vaginal bleeding , she was admitted to the ER , her pulse rate was elevated , BP was low , with cold peripheries her B.urea was 120 mg/dl and her serum creatinine was 2.2 mg/dl , what is the most likely cause of her elevated renal indices ?':
        [
      '-post-renal renal impairment',
      '-septic shock',
      '-intrinsic renal impairment',
      '-contrast nephropathy',
      '-neurogenic shock',
      '-hypovolemia',
    ],
  };
  static Map answers = {
    '60 years old male with +ve PMH for HTN and DM presented to the ER complaining of central suffocating chest pain, dyspnea and vomiting OE conscious ,alert ,oriented ,looks ill ,BP 190/100,ecg shows St segment elevation in L1,avL,V5,V6 with reciprocal changes and elevated troponin,what is the most likely dx?':
        '-acute MI',
    '65 years old male with +ve PMH for HTN,ischemic heart disease with previous CCU admissions,presented with dyspnea ,cough and white colored sputum ,OE he was dyspneic ,BP 100/60 ,chest auscultation reveals bilateral basal crepitations he brought his previous investigations with him and his echocardiogram shows EF=30%, and his current ecg shows old ischemic changes and his current WBC count is normal but his PCV is relatively low ,what is the most likely dx?':
        '-heart failure exacerbation',
    '15 years old female pt known case of type 1 DM developed ,flu like illness and fever followed by polyuria , polydipsia,abdominal pain and vomiting , associated with fruity odor breathing ,presented to the ER , her pulse rate is 120 bpm,temp is 38 C axillary corrected, she looks tachypneic, her RBS is about 500 mg/dl and her ABG shows elevated pH,what is the most likely dx?':
        '-DKA with intercurrent infection',
    '6 years old girl with -v PMH presented to the ER with moderate to severe abdominal pain (started few hours before presentation) in the umbilical area and shifted to the Rt iliac fossa , associated with nausea, vomiting , anorexia, fever, OE she looks ill with tachycardia , her abdominal examination shows Rt iliac fossa tenderness and positive rebound tenderness, her WBC count was > 13000,what is the most likely dx?':
        '-acute appendicitis',
    '70 years old male patient with +ve PMH for DM,chronic renal failure on insulin and scheduled hemodialysis presented to the ER with coma which he developed right before presentation his BP was 140/90, PR was normal ,neurological examination shows no focal neurological deficit as a matter of urgency he was given hypertonic solution with rapid regaining of his consciousness level his brain imaging was normal and his biochemistry (apart from low RBS) was acceptable, what is the most likely dx?':
        '-acute attack of hypoglycemia',
    '65 years old male heavy smoker (5 packs/day) with -ve PMH presented to the clinic with dyspnea,cough ,sputum,general examination reveals generalized muscle wasting ,chest auscultation reveals decrease air entry , normal vesicular breathing ,wheeze all over the chest,his chest X-ray reveals mediastinal narrowing and flattened diaphragm, what is the most likely dx?':
        '-COPD',
    '18 years old female presented to the ER with motor vehicle accident,regarding ABC of trauma ,her airway was patent ,she was looking dyspneic,OE she was hypotensive and her PR was 130 BPM ,her chest examination reveals deviation of trachea and apex beat to the left side,and diminished air entry in the right side and audible S1,S2,what is the most likely dx?':
        '-tension pneumothorax',
    '6 years old girl with -ve PMH , healthy wealthy was eating peanut for the first time, she suddenly developed generalized skin redness her parents brought her to the ER on there way her condition had been deteriorated, in the ER  BP was very low ,her PR was elevated and she developed cold extremities , she was given IM adrenaline with good response, what is the most likely dx?':
        '-anaphylaxis',
    '34 years old male ,heavy weight lifter with -ve PMH , developed back pain after his exercise,treated by mobic 7.5 mg twice daily with good response after few weeks without discontinuing his treatment,he presented to the ER with abdominal pain and coffee ground vomiting,what is the most likely dx?':
        '-peptic ulcer disease',
    '58 years old female with history of unresectable CA colon developed colicky abdominal pain and constipation , the pain increased in severity and she also developed abdominal distension and vomiting,in the ER she was dehydrated and her pulse rate was elevated,abdominal auscultation reveals absent bowel sounds , her abdominal plain X-ray shows dilated bowel loops with air fluid level , what is the most likely dx?':
        '-large bowel obstruction',
    '34 years old female with multiple visits to the ER for severe attacks of left flank pain that radiates to the groin, with nausea and vomiting but no fever presented with the same problem ,her back examination shows +ve left renal angle tenderness , her general urine examination shows microscopic hematuria, what is the most likely dx?':
        '-nephrolithiasis',
    '52 years old male known case of uncontrolled HTN developed loss of consciousness after domestic stressful event,presented to the ER after few hours of his unconsciousness his BP was 240/120 mm Hg ,unconscious , dysnpneic with clear chest on auscultation , his neurological examination reveals  GCS about 8 and +ve babinski sign in the Rt side,his CT scan reveals white lesion in the left side of the brain and his biochemistry  panel was near normal , what is the most likely dx?':
        '-ICH',
    '21 years old female developed butterfly rash on her face  associated with joint pain in multiple regions ,she also developed ecchymosis in multiple sites her investigations reveals elevated anti nuclear antibody and anti double stranded antibody,what is the most likely dx?':
        '-SLE',
    '33 years old male , heavy weight lifter with -ve PMH developed , back pain few weeks ago radiated to the left thigh , associated with numbness of the left thigh his lumber spine X-ray looks normal, his MRI of lumber spine reveals normal alignment of the vertebrae but narrowing of the spinal canal between the levels L3-L4 with a bulge between the 2 vertebrae(L3-L4) ,what is the most likely dx?':
        '-lumber disc prolapse',
    '5 years old male with +ve PMH of X linked coagulation disorder developed massive knee joint swelling after falling on the ground, his joint aspiration reveals fresh blood, what is the most likely dx?':
        '-hemophilia',
    '7 years old male with +ve family history for x-linked RBC disorder developed generalized pallor and dark color urine  after eating fava beans, his examination reveals ,yellowish discoloration of the sclera ,his PCV was 26% , with normal WBC and platelet count his TSB was elevated with normal direct portion, what is the most likely dx?':
        '-G6PD deficiency',
    '40 years old female with -ve PMH , on NSAIDs for generalized joint pain that she developed few months ago , presented to the ER with severe epigastric pain and nausea , OE she looks ill her PR was elevated , abdominal examination reveals epigastric tenderness with +ve guarding and rigidity of the abdomen , her erect CXR shows air under diaphragm ,what is  the most likely dx?':
        '-perforated PU',
    '25 years old male with untreated indirect inguinal hernia developed central colicky abdominal pain associated with tender irreducible scrotal swelling with absolute constipation and abdominal distension , OE his PR was elevated , his abdominal auscultation reveals absent bowel sounds , what is the most likely dx ?':
        '-strangulated inguinal hernia',
    '67 years old male with +ve PMH for DM , HTN , coronary artery disease , and previous CCU admission , developed sudden loss of consciousness at home , in the ER there were impalpable peripheral pulses , the monitor of the defibrillator shows flattening of cardiac activity , what is the most likely dx at that moment ?':
        '-asystole',
    '70 years old male smoker (5 packs/day) known case of COPD presented with recently developed continuous dyspnea , copious sputum and hemoptysis associated with hoarseness of the voice with no pyrexia , OE he was cachaxic with central cyanosis and finger clubbing , chest auscultation reveals diminished air entry , his CXR reveals upper mediastinal widening with no other significant abnormality his ESR was elevated , what is the most likely dx ?':
        '-bronchogenic CA',
    '20 years old pregnant female with -ve PMH developed abdominal trauma that caused her massive vaginal hemorrhage , she was brought to the ER , her pulse was low volume with elevated rate and she had cold extremities , with low BP , what is the most likely dx ?':
        '-hypovolemia',
    '60 years old male with +ve PMH of untreated benign prostatic hyperplasia that made him having repeated UTI , he developed , bilateral flank pain with nausea , vomiting , fever and rigor , he rejected medical advice until his condition had deteriorated , he was brought to the ER and OE he was unconscious , his PR was elevated with low volume , BP was unmeasurable , and he had cold peripheries , his WBC was 20,000 and CRP was elevated , what is the most likely dx?':
        '-septic shock',
    '60 years old female with +ve PMH for HTN and DM presented to the ER complaining of chest pain , stabbing in nature associated with shortness of breath , her BP was 200/100 and her chest examination was near near normal , her ecg shows ST segment depression in Leads II,III,aVF , her cardiac troponins was elevated , what is the most likely dx ?':
        '-Non ST segment elevation MI',
    '23 years old female with -ve PMH developed RTA and trauma to her neck , she was admitted to the ER and her airway was patent , her breathing was near normal , her BP was very low and she had bradycardia chest examination was near normal and her abdominal US reveals no obvious abnormality , she was given 2 pints of N/S with no response , what is the most likely dx ?':
        '-neurogenic shock',
    '25 years old pregnant female with with -ve PMH developed left leg pain and swelling associated with redness of the leg after few days she developed chest pain and shortness of breath , on examination her leg was warm and her chest was clear , her ecg show sinus tachycardia and her D-dimer level was elevated , what is the most likely dx ?':
        '-pulmonary thromboemolism',
    '30 years old female with -ve PMH developed Rt leg pain and swelling associated with redness of the leg , OE her leg was hot and red with +ve homans sign with no other significant abnormality in examination , her D-dimer level was elevated , what is the most likely dx?':
        '-DVT',
    '56 years old male non diabetic with untreated benign prostatic hyperplasia , presented to the ER with confusion associated with bilateral leg edema and generalized swelling of the body , his general examination reveals hypertension and near normal pulse , his chest examination shows decrease air entry on the right side , his abdominal examination reveals abdominal distension , his chest X-ray show Rt lower zone radio-opacity obliterating Rt costophrenic angle , his B.urea was 145 mg/dl and his S. creatinine was 2.5 mg/dl , and S.k was 5.5 mmol/l ,what is the most likely dx ?':
        '-post-renal renal impairment',
    '27 years old pregnant female developed vaginal bleeding , she was admitted to the ER , her pulse rate was elevated , BP was low , with cold peripheries her B.urea was 120 mg/dl and her serum creatinine was 2.2 mg/dl , what is the most likely cause of her elevated renal indices ?':
        '-hypovolemia',
  };
}

void selected1b(_value) {
  QuestionsShuffle.value1 = QuestionsShuffle
          .choices[QuestionsShuffle.questions[QuestionsShuffle.counter]]
      [int.parse(_value)];
  print(QuestionsShuffle.value1);
}

void selected2b(_value) {
  QuestionsShuffle.value2 = QuestionsShuffle
          .choices[QuestionsShuffle.questions[QuestionsShuffle.counter + 1]]
      [int.parse(_value)];
  print(QuestionsShuffle.value2);
}

void selected3b(_value) {
  QuestionsShuffle.value3 = QuestionsShuffle
          .choices[QuestionsShuffle.questions[QuestionsShuffle.counter + 2]]
      [int.parse(_value)];
  print(QuestionsShuffle.value3);
}

/*void selected4b(_value) {
  QuestionsShuffle.value4 = QuestionsShuffle
          .choices[QuestionsShuffle.questions[QuestionsShuffle.counter + 3]]
      [int.parse(_value)];
  print(QuestionsShuffle.value4);
}*/

getscore1b() {
  if (QuestionsShuffle.value1 ==
      QuestionsShuffle
          .answers[QuestionsShuffle.questions[QuestionsShuffle.counter]]) {
    QuestionsShuffle.score += 1;
  }
}

getscore2b() {
  if (QuestionsShuffle.value2 ==
      QuestionsShuffle
          .answers[QuestionsShuffle.questions[QuestionsShuffle.counter + 1]]) {
    QuestionsShuffle.score += 1;
  }
}

getscore3b() {
  if (QuestionsShuffle.value3 ==
      QuestionsShuffle
          .answers[QuestionsShuffle.questions[QuestionsShuffle.counter + 2]]) {
    QuestionsShuffle.score += 1;
  }
}

/*getscore4b() {
  if (QuestionsShuffle.value4 ==
      QuestionsShuffle
          .answers[QuestionsShuffle.questions[QuestionsShuffle.counter + 3]]) {
    QuestionsShuffle.score += 1;
  }
}*/
