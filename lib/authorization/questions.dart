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
  bool operator ==(dynamic other) => other != null && other is QuestionsShuffle;
  @override
  int get hashCode => super.hashCode;
  static final List questions = [
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
  static final Map choices = {
    '60 years old male with +ve PMH for HTN and DM presented to the ER complaining of central suffocating chest pain, dyspnea and vomiting OE conscious ,alert ,oriented ,looks ill ,BP 190/100,ecg shows St segment elevation in L1,avL,V5,V6 with reciprocal changes and elevated troponin,what is the most likely dx?':
        [
      'Stroke',
      'Pericarditis',
      'Pulseless electrical activity',
      'Ventricular fibrillation',
      'Acute MI',
      'Pectoralis spasm'
    ],
    '65 years old male with +ve PMH for HTN,ischemic heart disease with previous CCU admissions,presented with dyspnea ,cough and white colored sputum ,OE he was dyspneic ,BP 100/60 ,chest auscultation reveals bilateral basal crepitations he brought his previous investigations with him and his echocardiogram shows EF=30%, and his current ecg shows old ischemic changes and his current WBC count is normal but his PCV is relatively low ,what is the most likely dx?':
        [
      'Lobar pneumonia',
      'Asthma',
      'Pleural effusion',
      'Atrial septal defect',
      'Pulmonary embolism',
      'Heart failure exacerbation'
    ],
    '15 years old female pt known case of type 1 DM developed ,flu like illness and fever followed by polyuria , polydipsia,abdominal pain and vomiting , associated with fruity odor breathing ,presented to the ER , her pulse rate is 120 bpm,temp is 38 C axillary corrected, she looks tachypneic, her RBS is about 500 mg/dl and her ABG shows elevated pH,what is the most likely dx?':
        [
      'Tonsillitis',
      'Gastroenteritis',
      'Diabetes insipidus',
      'Hypercalcemia',
      'UTI',
      'DKA with intercurrent infection'
    ],
    '6 years old girl with -v PMH presented to the ER with moderate to severe abdominal pain (started few hours before presentation) in the umbilical area and shifted to the Rt iliac fossa , associated with nausea, vomiting , anorexia, fever, OE she looks ill with tachycardia , her abdominal examination shows Rt iliac fossa tenderness and positive rebound tenderness, her WBC count was > 13000,what is the most likely dx?':
        [
      'Gastroenteritis',
      'Chronic pancreatitis',
      'Inguinal hernia',
      'Acute appendicitis',
      'Abdominal aortic aneurysm',
      'Left ureteric stone'
    ],
    '70 years old male patient with +ve PMH for DM,chronic renal failure on insulin and scheduled hemodialysis presented to the ER with coma which he developed right before presentation his BP was 140/90, PR was normal ,neurological examination shows no focal neurological deficit as a matter of urgency he was given hypertonic solution with rapid regaining of his consciousness level his brain imaging was normal and his biochemistry (apart from low RBS) was acceptable, what is the most likely dx?':
        [
      'Intracranial hemorrhage',
      'Meningoencephalitis',
      'Acute attack of hypoglycemia',
      'Hyponatremia',
      'Chronic subdural hematoma',
      'Hypernatremia',
    ],
    '65 years old male heavy smoker (5 packs/day) with -ve PMH presented to the clinic with dyspnea,cough ,sputum,general examination reveals generalized muscle wasting ,chest auscultation reveals decrease air entry , normal vesicular breathing ,wheeze all over the chest,his chest X-ray reveals mediastinal narrowing and flattened diaphragm, what is the most likely dx?':
        [
      'Lobar pneumonia',
      'COPD',
      'Pulmonary embolism',
      'Pleural effusion',
      'Pericarditis',
      'Cardiac tamponade'
    ],
    '18 years old female presented to the ER with motor vehicle accident,regarding ABC of trauma ,her airway was patent ,she was looking dyspneic,OE she was hypotensive and her PR was 130 BPM ,her chest examination reveals deviation of trachea and apex beat to the left side,and diminished air entry in the right side and audible S1,S2,what is the most likely dx?':
        [
      'Foreign body aspiration',
      'Pulmonary embolism',
      'Tension pneumothorax',
      'Cardiac tamponade',
      'Asthma exacerbation',
      'HYS'
    ],
    '6 years old girl with -ve PMH , healthy wealthy was eating peanut for the first time, she suddenly developed generalized skin redness her parents brought her to the ER on there way her condition had been deteriorated, in the ER  BP was very low ,her PR was elevated and she developed cold extremities , she was given IM adrenaline with good response, what is the most likely dx?':
        [
      'Septic shock',
      'Pneumothorax',
      'Cardiogenic shock',
      'Hypovolemic shock',
      'Anaphylaxis',
      'Neurogenic shock',
    ],
    '34 years old male ,heavy weight lifter with -ve PMH , developed back pain after his exercise,treated by mobic 7.5 mg twice daily with good response after few weeks without discontinuing his treatment,he presented to the ER with abdominal pain and coffee ground vomiting,what is the most likely dx?':
        [
      'Acute appendicitis',
      'Acute pyelonephritis',
      'Peptic ulcer disease',
      'Musculoskeletal pain',
      'Colorectal CA',
      'Chronic pancreatitis'
    ],
    '58 years old female with history of unresectable CA colon developed colicky abdominal pain and constipation , the pain increased in severity and she also developed abdominal distension and vomiting,in the ER she was dehydrated and her pulse rate was elevated,abdominal auscultation reveals absent bowel sounds , her abdominal plain X-ray shows dilated bowel loops with air fluid level , what is the most likely dx?':
        [
      'Perforated DU',
      'Acute MI',
      'Non strangulated inguinal hernia',
      'Large bowel obstruction',
      'Mesenteric lymphadenitis',
      'Renal stone disease'
    ],
    '34 years old female with multiple visits to the ER for severe attacks of left flank pain that radiates to the groin, with nausea and vomiting but no fever presented with the same problem ,her back examination shows +ve left renal angle tenderness , her general urine examination shows microscopic hematuria, what is the most likely dx?':
        [
      'Right lower lobe pneumonia',
      'Disc prolapse',
      'Abdominal aortic aneurysm',
      'Nephrolithiasis',
      'Chronic pancreatitis',
      'Gastroenteritis',
    ],
    '52 years old male known case of uncontrolled HTN developed loss of consciousness after domestic stressful event,presented to the ER after few hours of his unconsciousness his BP was 240/120 mm Hg ,unconscious , dysnpneic with clear chest on auscultation , his neurological examination reveals  GCS about 8 and +ve babinski sign in the Rt side,his CT scan reveals white lesion in the left side of the brain and his biochemistry  panel was near normal , what is the most likely dx?':
        [
      'Hyponatremia',
      'Ischemic stroke',
      'Hypoglycemia',
      'Uremic encephalopathy',
      'Hypercalcemia',
      'ICH'
    ],
    '21 years old female developed butterfly rash on her face  associated with joint pain in multiple regions ,she also developed ecchymosis in multiple sites her investigations reveals elevated anti nuclear antibody and anti double stranded antibody,what is the most likely dx?':
        [
      'Contact dermatitis',
      'Osteoarthritis',
      'SLE',
      'Vitiligo',
      'Seborrheic dermatitis',
      'Fungal infection',
    ],
    '33 years old male , heavy weight lifter with -ve PMH developed , back pain few weeks ago radiated to the left thigh , associated with numbness of the left thigh his lumber spine X-ray looks normal, his MRI of lumber spine reveals normal alignment of the vertebrae but narrowing of the spinal canal between the levels L3-L4 with a bulge between the 2 vertebrae(L3-L4) ,what is the most likely dx?':
        [
      'Lumber disc prolapse',
      'B12 deficiency',
      'Cervical spine prolapse',
      'Renal stone disease',
      'Diabetic neuropathy',
      'B6 deficiency',
    ],
    '5 years old male with +ve PMH of X linked coagulation disorder developed massive knee joint swelling after falling on the ground, his joint aspiration reveals fresh blood, what is the most likely dx?':
        [
      'Hemolytic anemia',
      'Thalassemia',
      'Acquired bleeding tendency disorder',
      'Hemophilia',
      'DVT',
      'Septic arthritis'
    ],
    '7 years old male with +ve family history for x-linked RBC disorder developed generalized pallor and dark color urine  after eating fava beans, his examination reveals ,yellowish discoloration of the sclera ,his PCV was 26% , with normal WBC and platelet count his TSB was elevated with normal direct portion, what is the most likely dx?':
        [
      'Hepatitis A',
      'Common bile duct stone',
      'G6PD deficiency',
      'Iron deficiency anemia',
      'Aplastic anemia',
      'UTI',
    ],
    '40 years old female with -ve PMH , on NSAIDs for generalized joint pain that she developed few months ago , presented to the ER with severe epigastric pain and nausea , OE she looks ill her PR was elevated , abdominal examination reveals epigastric tenderness with +ve guarding and rigidity of the abdomen , her erect CXR shows air under diaphragm ,what is  the most likely dx?':
        [
      'Lower lobe pneumonia',
      'Intestinal obstruction',
      'Perforated PU',
      'Indirect inguinal hernia',
      'Direct inguinal hernia',
      'Nephrolithiasis',
    ],
    '25 years old male with untreated indirect inguinal hernia developed central colicky abdominal pain associated with tender irreducible scrotal swelling with absolute constipation and abdominal distension , OE his PR was elevated , his abdominal auscultation reveals absent bowel sounds , what is the most likely dx ?':
        [
      'Non strangulated incisional hernia',
      'Nephrolithiasis',
      'Strangulated inguinal hernia',
      'Irritable bowel syndrome',
      'Acute lower UTI',
      'Testicular trauma',
    ],
    '67 years old male with +ve PMH for DM , HTN , coronary artery disease , and previous CCU admission , developed sudden loss of consciousness at home , in the ER there were impalpable peripheral pulses , the monitor of the defibrillator shows flattening of cardiac activity , what is the most likely dx at that moment ?':
        [
      'SVT',
      'Sinus tachycardia',
      'VT with +ve pulse',
      'Asystole',
      'Atrial fibrillation',
      'Atrial flutter',
    ],
    '70 years old male smoker (5 packs/day) known case of COPD presented with recently developed continuous dyspnea , copious sputum and hemoptysis associated with hoarseness of the voice with no pyrexia , OE he was cachaxic with central cyanosis and finger clubbing , chest auscultation reveals diminished air entry , his CXR reveals upper mediastinal widening with no other significant abnormality his ESR was elevated , what is the most likely dx ?':
        [
      'Pulmonary edema',
      'Traumatic lung contusion',
      'Bronchogenic CA',
      'Pulmonary embolism',
      'Bronchospasm',
      'Bronchopneumonia',
    ],
    '20 years old pregnant female with -ve PMH developed abdominal trauma that caused her massive vaginal hemorrhage , she was brought to the ER , her pulse was low volume with elevated rate and she had cold extremities , with low BP , what is the most likely dx ?':
        [
      'Cardiogenic shock',
      'Neurogenic shock',
      'Septic shock',
      'Anaphylaxsis',
      'Hypovolemia',
      'Spontaneous pneumothorax',
    ],
    '60 years old male with +ve PMH of untreated benign prostatic hyperplasia that made him having repeated UTI , he developed , bilateral flank pain with nausea , vomiting , fever and rigor , he rejected medical advice until his condition had deteriorated , he was brought to the ER and OE he was unconscious , his PR was elevated with low volume , BP was unmeasurable , and he had cold peripheries , his WBC was 20,000 and CRP was elevated , what is the most likely dx?':
        [
      'Hypovolemia',
      'Neurogenic shock',
      'Cardiogenic shock',
      'Septic shock',
      'Massive pulmonary embolism',
      'Pneumothorax',
    ],
    '60 years old female with +ve PMH for HTN and DM presented to the ER complaining of chest pain , stabbing in nature associated with shortness of breath , her BP was 200/100 and her chest examination was near near normal , her ecg shows ST segment depression in Leads II,III,aVF , her cardiac troponins was elevated , what is the most likely dx ?':
        [
      'Musculoskeletal chest pain',
      'Non ST segment elevation MI',
      'Pleuritic chest pain',
      'Herpes zoster',
      'Asthma',
      'Pulmonary embolism',
    ],
    '23 years old female with -ve PMH developed RTA and trauma to her neck , she was admitted to the ER and her airway was patent , her breathing was near normal , her BP was very low and she had bradycardia chest examination was near normal and her abdominal US reveals no obvious abnormality , she was given 2 pints of N/S with no response , what is the most likely dx ?':
        [
      'Hypovolemic shock',
      'Anaphylaxis',
      'Cardiac tamponade',
      'Tension pneumothorax',
      'Septic shock',
      'Neurogenic shock',
    ],
    '25 years old pregnant female with with -ve PMH developed left leg pain and swelling associated with redness of the leg after few days she developed chest pain and shortness of breath , on examination her leg was warm and her chest was clear , her ecg show sinus tachycardia and her D-dimer level was elevated , what is the most likely dx ?':
        [
      'Asthma',
      'Lobar pneumonia',
      'Pleural effusion',
      'Pulmonary thromboemolism',
      'Pneumothorax',
      'Acute MI',
    ],
    '30 years old female with -ve PMH developed Rt leg pain and swelling associated with redness of the leg , OE her leg was hot and red with +ve homans sign with no other significant abnormality in examination , her D-dimer level was elevated , what is the most likely dx?':
        [
      'Rt side heart failure',
      'Cellulitis',
      'DVT',
      'Protein energy malnutrition',
      'Myxedema',
      'Chronic liver disease',
    ],
    '56 years old male non diabetic with untreated benign prostatic hyperplasia , presented to the ER with confusion associated with bilateral leg edema and generalized swelling of the body , his general examination reveals hypertension and near normal pulse , his chest examination shows decrease air entry on the right side , his abdominal examination reveals abdominal distension , his chest X-ray show Rt lower zone radio-opacity obliterating Rt costophrenic angle , his B.urea was 145 mg/dl and his S. creatinine was 2.5 mg/dl , and S.k was 5.5 mmol/l ,what is the most likely dx ?':
        [
      'Pre-renal renal impairment',
      'Nephrotoxic drug misuse',
      'Post-renal renal impairment',
      'Diabetic nephropathy',
      'Intrinsic renal disease',
      'Contrast nephropathy',
    ],
    '27 years old pregnant female developed vaginal bleeding , she was admitted to the ER , her pulse rate was elevated , BP was low , with cold peripheries her B.urea was 120 mg/dl and her serum creatinine was 2.2 mg/dl , what is the most likely cause of her elevated renal indices ?':
        [
      'Post-renal renal impairment',
      'Septic shock',
      'Intrinsic renal impairment',
      'Contrast nephropathy',
      'Neurogenic shock',
      'Hypovolemia',
    ],
  };
  static final Map answers = {
    '60 years old male with +ve PMH for HTN and DM presented to the ER complaining of central suffocating chest pain, dyspnea and vomiting OE conscious ,alert ,oriented ,looks ill ,BP 190/100,ecg shows St segment elevation in L1,avL,V5,V6 with reciprocal changes and elevated troponin,what is the most likely dx?':
        'Acute MI',
    '65 years old male with +ve PMH for HTN,ischemic heart disease with previous CCU admissions,presented with dyspnea ,cough and white colored sputum ,OE he was dyspneic ,BP 100/60 ,chest auscultation reveals bilateral basal crepitations he brought his previous investigations with him and his echocardiogram shows EF=30%, and his current ecg shows old ischemic changes and his current WBC count is normal but his PCV is relatively low ,what is the most likely dx?':
        'Heart failure exacerbation',
    '15 years old female pt known case of type 1 DM developed ,flu like illness and fever followed by polyuria , polydipsia,abdominal pain and vomiting , associated with fruity odor breathing ,presented to the ER , her pulse rate is 120 bpm,temp is 38 C axillary corrected, she looks tachypneic, her RBS is about 500 mg/dl and her ABG shows elevated pH,what is the most likely dx?':
        'DKA with intercurrent infection',
    '6 years old girl with -v PMH presented to the ER with moderate to severe abdominal pain (started few hours before presentation) in the umbilical area and shifted to the Rt iliac fossa , associated with nausea, vomiting , anorexia, fever, OE she looks ill with tachycardia , her abdominal examination shows Rt iliac fossa tenderness and positive rebound tenderness, her WBC count was > 13000,what is the most likely dx?':
        'Acute appendicitis',
    '70 years old male patient with +ve PMH for DM,chronic renal failure on insulin and scheduled hemodialysis presented to the ER with coma which he developed right before presentation his BP was 140/90, PR was normal ,neurological examination shows no focal neurological deficit as a matter of urgency he was given hypertonic solution with rapid regaining of his consciousness level his brain imaging was normal and his biochemistry (apart from low RBS) was acceptable, what is the most likely dx?':
        'Acute attack of hypoglycemia',
    '65 years old male heavy smoker (5 packs/day) with -ve PMH presented to the clinic with dyspnea,cough ,sputum,general examination reveals generalized muscle wasting ,chest auscultation reveals decrease air entry , normal vesicular breathing ,wheeze all over the chest,his chest X-ray reveals mediastinal narrowing and flattened diaphragm, what is the most likely dx?':
        'COPD',
    '18 years old female presented to the ER with motor vehicle accident,regarding ABC of trauma ,her airway was patent ,she was looking dyspneic,OE she was hypotensive and her PR was 130 BPM ,her chest examination reveals deviation of trachea and apex beat to the left side,and diminished air entry in the right side and audible S1,S2,what is the most likely dx?':
        'Tension pneumothorax',
    '6 years old girl with -ve PMH , healthy wealthy was eating peanut for the first time, she suddenly developed generalized skin redness her parents brought her to the ER on there way her condition had been deteriorated, in the ER  BP was very low ,her PR was elevated and she developed cold extremities , she was given IM adrenaline with good response, what is the most likely dx?':
        'Anaphylaxis',
    '34 years old male ,heavy weight lifter with -ve PMH , developed back pain after his exercise,treated by mobic 7.5 mg twice daily with good response after few weeks without discontinuing his treatment,he presented to the ER with abdominal pain and coffee ground vomiting,what is the most likely dx?':
        'Peptic ulcer disease',
    '58 years old female with history of unresectable CA colon developed colicky abdominal pain and constipation , the pain increased in severity and she also developed abdominal distension and vomiting,in the ER she was dehydrated and her pulse rate was elevated,abdominal auscultation reveals absent bowel sounds , her abdominal plain X-ray shows dilated bowel loops with air fluid level , what is the most likely dx?':
        'Large bowel obstruction',
    '34 years old female with multiple visits to the ER for severe attacks of left flank pain that radiates to the groin, with nausea and vomiting but no fever presented with the same problem ,her back examination shows +ve left renal angle tenderness , her general urine examination shows microscopic hematuria, what is the most likely dx?':
        'Nephrolithiasis',
    '52 years old male known case of uncontrolled HTN developed loss of consciousness after domestic stressful event,presented to the ER after few hours of his unconsciousness his BP was 240/120 mm Hg ,unconscious , dysnpneic with clear chest on auscultation , his neurological examination reveals  GCS about 8 and +ve babinski sign in the Rt side,his CT scan reveals white lesion in the left side of the brain and his biochemistry  panel was near normal , what is the most likely dx?':
        'ICH',
    '21 years old female developed butterfly rash on her face  associated with joint pain in multiple regions ,she also developed ecchymosis in multiple sites her investigations reveals elevated anti nuclear antibody and anti double stranded antibody,what is the most likely dx?':
        'SLE',
    '33 years old male , heavy weight lifter with -ve PMH developed , back pain few weeks ago radiated to the left thigh , associated with numbness of the left thigh his lumber spine X-ray looks normal, his MRI of lumber spine reveals normal alignment of the vertebrae but narrowing of the spinal canal between the levels L3-L4 with a bulge between the 2 vertebrae(L3-L4) ,what is the most likely dx?':
        'Lumber disc prolapse',
    '5 years old male with +ve PMH of X linked coagulation disorder developed massive knee joint swelling after falling on the ground, his joint aspiration reveals fresh blood, what is the most likely dx?':
        'Hemophilia',
    '7 years old male with +ve family history for x-linked RBC disorder developed generalized pallor and dark color urine  after eating fava beans, his examination reveals ,yellowish discoloration of the sclera ,his PCV was 26% , with normal WBC and platelet count his TSB was elevated with normal direct portion, what is the most likely dx?':
        'G6PD deficiency',
    '40 years old female with -ve PMH , on NSAIDs for generalized joint pain that she developed few months ago , presented to the ER with severe epigastric pain and nausea , OE she looks ill her PR was elevated , abdominal examination reveals epigastric tenderness with +ve guarding and rigidity of the abdomen , her erect CXR shows air under diaphragm ,what is  the most likely dx?':
        'Perforated PU',
    '25 years old male with untreated indirect inguinal hernia developed central colicky abdominal pain associated with tender irreducible scrotal swelling with absolute constipation and abdominal distension , OE his PR was elevated , his abdominal auscultation reveals absent bowel sounds , what is the most likely dx ?':
        'Strangulated inguinal hernia',
    '67 years old male with +ve PMH for DM , HTN , coronary artery disease , and previous CCU admission , developed sudden loss of consciousness at home , in the ER there were impalpable peripheral pulses , the monitor of the defibrillator shows flattening of cardiac activity , what is the most likely dx at that moment ?':
        'Asystole',
    '70 years old male smoker (5 packs/day) known case of COPD presented with recently developed continuous dyspnea , copious sputum and hemoptysis associated with hoarseness of the voice with no pyrexia , OE he was cachaxic with central cyanosis and finger clubbing , chest auscultation reveals diminished air entry , his CXR reveals upper mediastinal widening with no other significant abnormality his ESR was elevated , what is the most likely dx ?':
        'Bronchogenic CA',
    '20 years old pregnant female with -ve PMH developed abdominal trauma that caused her massive vaginal hemorrhage , she was brought to the ER , her pulse was low volume with elevated rate and she had cold extremities , with low BP , what is the most likely dx ?':
        'Hypovolemia',
    '60 years old male with +ve PMH of untreated benign prostatic hyperplasia that made him having repeated UTI , he developed , bilateral flank pain with nausea , vomiting , fever and rigor , he rejected medical advice until his condition had deteriorated , he was brought to the ER and OE he was unconscious , his PR was elevated with low volume , BP was unmeasurable , and he had cold peripheries , his WBC was 20,000 and CRP was elevated , what is the most likely dx?':
        'Septic shock',
    '60 years old female with +ve PMH for HTN and DM presented to the ER complaining of chest pain , stabbing in nature associated with shortness of breath , her BP was 200/100 and her chest examination was near near normal , her ecg shows ST segment depression in Leads II,III,aVF , her cardiac troponins was elevated , what is the most likely dx ?':
        'Non ST segment elevation MI',
    '23 years old female with -ve PMH developed RTA and trauma to her neck , she was admitted to the ER and her airway was patent , her breathing was near normal , her BP was very low and she had bradycardia chest examination was near normal and her abdominal US reveals no obvious abnormality , she was given 2 pints of N/S with no response , what is the most likely dx ?':
        'Neurogenic shock',
    '25 years old pregnant female with with -ve PMH developed left leg pain and swelling associated with redness of the leg after few days she developed chest pain and shortness of breath , on examination her leg was warm and her chest was clear , her ecg show sinus tachycardia and her D-dimer level was elevated , what is the most likely dx ?':
        'Pulmonary thromboemolism',
    '30 years old female with -ve PMH developed Rt leg pain and swelling associated with redness of the leg , OE her leg was hot and red with +ve homans sign with no other significant abnormality in examination , her D-dimer level was elevated , what is the most likely dx?':
        'DVT',
    '56 years old male non diabetic with untreated benign prostatic hyperplasia , presented to the ER with confusion associated with bilateral leg edema and generalized swelling of the body , his general examination reveals hypertension and near normal pulse , his chest examination shows decrease air entry on the right side , his abdominal examination reveals abdominal distension , his chest X-ray show Rt lower zone radio-opacity obliterating Rt costophrenic angle , his B.urea was 145 mg/dl and his S. creatinine was 2.5 mg/dl , and S.k was 5.5 mmol/l ,what is the most likely dx ?':
        'Post-renal renal impairment',
    '27 years old pregnant female developed vaginal bleeding , she was admitted to the ER , her pulse rate was elevated , BP was low , with cold peripheries her B.urea was 120 mg/dl and her serum creatinine was 2.2 mg/dl , what is the most likely cause of her elevated renal indices ?':
        'Hypovolemia',
  };
}
