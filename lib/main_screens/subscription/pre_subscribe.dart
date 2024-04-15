import 'package:flutter/material.dart';
import 'package:the_tarot_guru/home.dart';
import 'package:the_tarot_guru/main_screens/reuseable_blocks.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PreSubscribeUSer extends StatefulWidget {
  const PreSubscribeUSer({super.key});

  @override
  State<PreSubscribeUSer> createState() => _PreSubscribeUSerState();
}

class _PreSubscribeUSerState extends State<PreSubscribeUSer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFF161F58),
                    Color(0xFF0C0E27),
                  ],
                ),
              ),
            ),
            Positioned.fill(
              child: Image.asset(
                'assets/images/Screen_Backgrounds/bg1.png', // Replace with your image path
                fit: BoxFit.cover,
                opacity: const AlwaysStoppedAnimation(.2),
              ),
            ),
            Center(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Container(
                    width: MediaQuery.sizeOf(context).width * 0.8,
                    // height: MediaQuery.sizeOf(context).height * 0.8,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25)
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: (){
                            Navigator.pop(context);
                          },
                          child: Container(
                            height: 35,
                            margin: EdgeInsets.only(top: 25),
                            width: 35,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(35),
                            ),
                            child: Icon(
                                Icons.close,color: Colors.black
                            ),
                          ),
                        ),
                        Center(
                          child: Image.asset(
                            'assets/images/other/tick.png',
                            width: MediaQuery.sizeOf(context).width *0.6,
                            height: MediaQuery.sizeOf(context).height *0.3,
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text('${AppLocalizations.of(context)!.presubscribemaintitle}',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 35,
                              fontWeight: FontWeight.w800
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        FullWidthButton(text: '${AppLocalizations.of(context)!.backtohome}', onPressed: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => AppSelect()),
                          );
                        })
                      ],
                    ),
                  ),
                )
            ),
          ],
        ),
      ),
    );
  }
}
