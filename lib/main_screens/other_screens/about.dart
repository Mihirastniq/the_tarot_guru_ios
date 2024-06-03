// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// class AboutScreen extends StatefulWidget {
//   @override
//   _AboutState createState() => _AboutState();
// }
//
// class _AboutState extends State<AboutScreen> {
//   late double TitleFontsSize = 23;
//   late double SubTitleFontsSize = 18;
//   late double ContentFontsSize =16 ;
//   late double ButtonFontsSize =25;
//   @override
//   void initState() {
//     super.initState();
//     _loadLocalData();
//   }
//   _loadLocalData() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     setState(() {
//       TitleFontsSize = prefs.getDouble('TitleFontSize') ?? 23;
//       SubTitleFontsSize = prefs.getDouble('SubtitleFontSize') ?? 18;
//       ContentFontsSize = prefs.getDouble('ContentFontSize') ?? 16;
//       ButtonFontsSize = prefs.getDouble('ButtonFontSize') ?? 25;
//     });
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       extendBodyBehindAppBar: true,
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         title: const Text(
//           'New Spread',
//           style: TextStyle(
//             color: Colors.white,
//             fontSize: 20.0,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//       ),
//       body: Stack(
//         children: [
//           Container(
//             decoration: const BoxDecoration(
//               // borderRadius: BorderRadius.all('10'),
//               image: DecorationImage(
//                 image: AssetImage('assets/images/pngbackround.jpg'),
//                 fit: BoxFit.cover,
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.fromLTRB(20, 20, 20, 5),
//             child: Container(
//               child: Text('About The Tarot Guru'),
//             )
//           ),
//         ],
//       ),
//     );
//   }
// }