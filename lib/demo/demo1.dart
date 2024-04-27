import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:the_tarot_guru/main_screens/controller/functions.dart';

class DemoDesignOne extends StatefulWidget {
  const DemoDesignOne({super.key});

  @override
  State<DemoDesignOne> createState() => _DemoDesignOneState();
}

class _DemoDesignOneState extends State<DemoDesignOne> {

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width * 0.9;
    double screenHeight = MediaQuery.of(context).size.height * 0.75;
    double imageAspectRatio = 671 / 457;
    double containerWidth = screenWidth / 2 - 10;
    double containerHeightWithAspectRatio = containerWidth * imageAspectRatio;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color.fromRGBO(19, 14, 42, 1),
                      Theme.of(context).primaryColor.withOpacity(0.2),
                    ],
                  ),
                ),
              ),
              Positioned.fill(
                child: Image.asset(
                  'assets/images/Screen_Backgrounds/bg3.png', // Replace with your image path
                  fit: BoxFit.cover,
                  opacity: const AlwaysStoppedAnimation(.3),
                ),
              ),
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  title: Text(
                    'Spread Details',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  actions: [
                    IconButton(
                      icon: Icon(Icons.palette),
                      color: Colors.white,
                      onPressed: () {
                        changeTheme(context);
                      },
                    ),
                  ],
                ),
              ),
              Center(
                child: Container(
                  margin: EdgeInsets.only(
                      left: 10,
                      right: 10,
                      top: AppBar().preferredSize.height +15
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            Image.asset(
                                width: containerWidth,
                                height: containerHeightWithAspectRatio,
                                'assets/images/tarot_cards/Osho Zen/Fire/1_KING_OF_ FIRE_ THE_CREATOR_PNG.png'
                            ),
                            SizedBox(
                              height: 35,
                            ),
                            Container(
                              padding: EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor.withOpacity(0.6),
                                  borderRadius: BorderRadius.circular(15)
                              ),
                              width: MediaQuery.sizeOf(context).width*0.9,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Icon(Icons.star,color: Colors.white,),
                                      Text('Card name',style: _getTitleTextStyle(context)),
                                      Icon(Icons.star,color: Colors.white,)
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text('Card category: Fire',style: _getCustomTextStyle(context),),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text("एक सृजनकर्ता की सबसे बड़ी खुशी, उसके द्वारा की गई स्वयं की संरचना है, उसके लिए, इससे बड़ा कोई अन्य पुरस्कार ही नहीं ! दुनिया में दो प्रकार के रचनाकार अथवा सृजनकर्ता होते हैं। प्रथम प्रकार के सर्जक उस वस्तु अथवा अपने उद्देश्य का सृजन करते हैं - जिनमें कवि, पेन्टर आदि सम्मिलित हैं; वे वस्तु का सृजन करते हैं । दूसरे प्रकार के सर्जक अपने विषय का सृजन करते हैं, अर्थात् व्यक्तिनिष्ठ सर्जन करते हैं, जिनमें वे स्वयं के सृजन का कार्य करते हैं। ऐसे सर्जक ही वास्तविक सर्जक और वास्तविक कवि हैं, जो स्वयं की सर्वोत्तम रचना करते हैं । इस ब्रह्माण्ड में करोडों लोग जीते हैं। परन्तु वे कोई भी सर्जन नहीं करते; कोई भी रचना नहीं करते। जीवन का आधारभूत तथ्य यही है कि जबतक आप कोई सृजन अथवा संरचना नहीं करते, भले ही वह पेन्टिंग हो, संगीत और नृत्य हो, तब तक आप आनन्दमय नहीं हो सकते। आप सर्वथा दुःख का ही अनुभव करते रहेंगे। सर्जकता ही आपको गौरव प्रदान कर सकती है। यहाँ पर एक बात याद रखिए कि भीड़ का हिस्सा बनकर सृजन नहीं किया जा सकता। सर्जन का मार्ग आप से होकर आपके अन्दर तक पहुंचता है। जब तक अकेला और अपने सृजन में तन्मय नहीं हो जाते, तब तक कोई भी संरचना नहीं कर सकते । एक वास्तविक सर्जक महत्त्वाकांक्षी नहीं होता । वह रहस्यमय होता है और स्वयं का सृजन करता है। सर्जक किसी वस्तु विशेष पर कार्य करता है । एक कवि, संगीतकार, चित्रकार, आदि सच्चे सर्जक हैं। एक वास्तविक सर्जक को अपनी ख्याति और श्रेष्ठता का लोभ नहीं होता। वे लोग, जो महत्त्वाकांक्षी और अपनी ख्याति के लोभी हैं, वे तृतीय श्रेणी के मानव हैं। वे कम्पोज कर सकते हैं परन्तु सृजन नहीं। एक सर्जक को अपनी प्रसिद्धि तथा मान-प्रतिष्ठा की आकांक्षा नहीं होती । उसकी समग्र शक्ति, उसके द्वारा हो रहे सृजन में ही व्यय होती है।",
                                    style: _getCustomTextStyle(context)),
                                ],
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 35,
                        ),
                        Column(
                          children: [
                            Image.asset(
                                width: containerWidth,
                                height: containerHeightWithAspectRatio,
                                'assets/images/tarot_cards/Osho Zen/Fire/1_KING_OF_ FIRE_ THE_CREATOR_PNG.png'
                            ),
                            SizedBox(
                              height: 35,
                            ),
                            Container(
                              padding: EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor.withOpacity(0.6),
                                  borderRadius: BorderRadius.circular(15)
                              ),
                              width: MediaQuery.sizeOf(context).width*0.9,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Icon(Icons.star,color: Colors.white,),
                                      Text('Card name',style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 22,
                                          fontWeight: FontWeight.w800
                                      ),),
                                      Icon(Icons.star,color: Colors.white,)
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text('Card category: Fire',style: TextStyle(fontSize: 20,color: Colors.white),),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text("एक सृजनकर्ता की सबसे बड़ी खुशी, उसके द्वारा की गई स्वयं की संरचना है, उसके लिए, इससे बड़ा कोई अन्य पुरस्कार ही नहीं ! दुनिया में दो प्रकार के रचनाकार अथवा सृजनकर्ता होते हैं। प्रथम प्रकार के सर्जक उस वस्तु अथवा अपने उद्देश्य का सृजन करते हैं - जिनमें कवि, पेन्टर आदि सम्मिलित हैं; वे वस्तु का सृजन करते हैं । दूसरे प्रकार के सर्जक अपने विषय का सृजन करते हैं, अर्थात् व्यक्तिनिष्ठ सर्जन करते हैं, जिनमें वे स्वयं के सृजन का कार्य करते हैं। ऐसे सर्जक ही वास्तविक सर्जक और वास्तविक कवि हैं, जो स्वयं की सर्वोत्तम रचना करते हैं । इस ब्रह्माण्ड में करोडों लोग जीते हैं। परन्तु वे कोई भी सर्जन नहीं करते; कोई भी रचना नहीं करते। जीवन का आधारभूत तथ्य यही है कि जबतक आप कोई सृजन अथवा संरचना नहीं करते, भले ही वह पेन्टिंग हो, संगीत और नृत्य हो, तब तक आप आनन्दमय नहीं हो सकते। आप सर्वथा दुःख का ही अनुभव करते रहेंगे। सर्जकता ही आपको गौरव प्रदान कर सकती है। यहाँ पर एक बात याद रखिए कि भीड़ का हिस्सा बनकर सृजन नहीं किया जा सकता। सर्जन का मार्ग आप से होकर आपके अन्दर तक पहुंचता है। जब तक अकेला और अपने सृजन में तन्मय नहीं हो जाते, तब तक कोई भी संरचना नहीं कर सकते । एक वास्तविक सर्जक महत्त्वाकांक्षी नहीं होता । वह रहस्यमय होता है और स्वयं का सृजन करता है। सर्जक किसी वस्तु विशेष पर कार्य करता है । एक कवि, संगीतकार, चित्रकार, आदि सच्चे सर्जक हैं। एक वास्तविक सर्जक को अपनी ख्याति और श्रेष्ठता का लोभ नहीं होता। वे लोग, जो महत्त्वाकांक्षी और अपनी ख्याति के लोभी हैं, वे तृतीय श्रेणी के मानव हैं। वे कम्पोज कर सकते हैं परन्तु सृजन नहीं। एक सर्जक को अपनी प्रसिद्धि तथा मान-प्रतिष्ठा की आकांक्षा नहीं होती । उसकी समग्र शक्ति, उसके द्वारा हो रहे सृजन में ही व्यय होती है।",
                                    style: TextStyle(fontSize: 20,color: Colors.white),),
                                ],
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 35,
                        ),
                        Column(
                          children: [
                            Image.asset(
                                width: containerWidth,
                                height: containerHeightWithAspectRatio,
                                'assets/images/tarot_cards/Osho Zen/Fire/1_KING_OF_ FIRE_ THE_CREATOR_PNG.png'
                            ),
                            SizedBox(
                              height: 35,
                            ),
                            Container(
                              padding: EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor.withOpacity(0.6),
                                  borderRadius: BorderRadius.circular(15)
                              ),
                              width: MediaQuery.sizeOf(context).width*0.9,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Icon(Icons.star,color: Colors.white,),
                                      Text('Card name',style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 22,
                                          fontWeight: FontWeight.w800
                                      ),),
                                      Icon(Icons.star,color: Colors.white,)
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text('Card category: Fire',style: TextStyle(fontSize: 20,color: Colors.white),),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text("एक सृजनकर्ता की सबसे बड़ी खुशी, उसके द्वारा की गई स्वयं की संरचना है, उसके लिए, इससे बड़ा कोई अन्य पुरस्कार ही नहीं ! दुनिया में दो प्रकार के रचनाकार अथवा सृजनकर्ता होते हैं। प्रथम प्रकार के सर्जक उस वस्तु अथवा अपने उद्देश्य का सृजन करते हैं - जिनमें कवि, पेन्टर आदि सम्मिलित हैं; वे वस्तु का सृजन करते हैं । दूसरे प्रकार के सर्जक अपने विषय का सृजन करते हैं, अर्थात् व्यक्तिनिष्ठ सर्जन करते हैं, जिनमें वे स्वयं के सृजन का कार्य करते हैं। ऐसे सर्जक ही वास्तविक सर्जक और वास्तविक कवि हैं, जो स्वयं की सर्वोत्तम रचना करते हैं । इस ब्रह्माण्ड में करोडों लोग जीते हैं। परन्तु वे कोई भी सर्जन नहीं करते; कोई भी रचना नहीं करते। जीवन का आधारभूत तथ्य यही है कि जबतक आप कोई सृजन अथवा संरचना नहीं करते, भले ही वह पेन्टिंग हो, संगीत और नृत्य हो, तब तक आप आनन्दमय नहीं हो सकते। आप सर्वथा दुःख का ही अनुभव करते रहेंगे। सर्जकता ही आपको गौरव प्रदान कर सकती है। यहाँ पर एक बात याद रखिए कि भीड़ का हिस्सा बनकर सृजन नहीं किया जा सकता। सर्जन का मार्ग आप से होकर आपके अन्दर तक पहुंचता है। जब तक अकेला और अपने सृजन में तन्मय नहीं हो जाते, तब तक कोई भी संरचना नहीं कर सकते । एक वास्तविक सर्जक महत्त्वाकांक्षी नहीं होता । वह रहस्यमय होता है और स्वयं का सृजन करता है। सर्जक किसी वस्तु विशेष पर कार्य करता है । एक कवि, संगीतकार, चित्रकार, आदि सच्चे सर्जक हैं। एक वास्तविक सर्जक को अपनी ख्याति और श्रेष्ठता का लोभ नहीं होता। वे लोग, जो महत्त्वाकांक्षी और अपनी ख्याति के लोभी हैं, वे तृतीय श्रेणी के मानव हैं। वे कम्पोज कर सकते हैं परन्तु सृजन नहीं। एक सर्जक को अपनी प्रसिद्धि तथा मान-प्रतिष्ठा की आकांक्षा नहीं होती । उसकी समग्र शक्ति, उसके द्वारा हो रहे सृजन में ही व्यय होती है।",
                                    style: TextStyle(fontSize: 20,color: Colors.white),),
                                ],
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        )
      ),
    );
  }
  TextStyle _getCustomTextStyle(BuildContext context) {
    double lineHeight = 1.8;

    // Define default text style
    TextStyle defaultStyle = GoogleFonts.anekDevanagari(
        fontSize: 20,
        fontWeight: FontWeight.w400,
        color: Colors.white,
        height: lineHeight
    );

    // Check the language and set appropriate font
    if (Localizations.localeOf(context).languageCode == 'hi') {
      return GoogleFonts.anekDevanagari(
          fontSize: 20,
          fontWeight: FontWeight.w400,
          color: Colors.white,
          height: lineHeight
      );
    } else {
      return defaultStyle;
    }
  }
  TextStyle _getTitleTextStyle(BuildContext context) {
    // Define default text style
    TextStyle defaultStyle = GoogleFonts.anekDevanagari(
        color: Colors.white,
        fontSize: 23,
        fontWeight:
        FontWeight.w600
    );

    // Check the language and set appropriate font
    if (Localizations.localeOf(context).languageCode == 'hi') {
      return GoogleFonts.anekDevanagari(
          color: Colors.white,
          fontSize: 23,
          fontWeight:
          FontWeight.w600
      );
    } else {
      return defaultStyle;
    }
  }
}
