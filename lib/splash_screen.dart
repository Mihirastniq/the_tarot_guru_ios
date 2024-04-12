import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_tarot_guru/MainScreens/Login/login_pin.dart';
import 'package:the_tarot_guru/demo.dart';
import 'package:the_tarot_guru/introduction_animation/introduction_animation_screen.dart';

// class SplashScreen extends StatefulWidget {
//   @override
//   _SplashScreenState createState() => _SplashScreenState();
// }
//
// class _SplashScreenState extends State<SplashScreen> {
//   bool _assetsDownloaded = false;
//
//   @override
//   void initState() {
//     super.initState();
//     checkAndDownloadAssets();
//   }
//
//   Future<void> checkAndDownloadAssets() async {
//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//     bool isLoggedIn = prefs.getBool("isLogin") ?? false;
//     if (isLoggedIn) {
//       isTarotCardFolderEmpty();
//       // Get.off(PinEntryScreen());
//     } else {
//       final status = await Permission.manageExternalStorage.request();
//       if (status.isGranted) {
//         final bool tarotCardFolderEmpty = await isTarotCardFolderEmpty();
//         if (tarotCardFolderEmpty) {
//           await downloadAndExtractAssets();
//           // Get.off(IntroductionAnimationScreen());
//         } else {
//           // Get.off(IntroductionAnimationScreen());
//         }
//       } else {
//         // Handle if storage permission is denied
//         // For example, show a message to the user or take appropriate action
//       }
//     }
//   }
//
//   Future<bool> isTarotCardFolderEmpty() async {
//     final appDirectory = await getApplicationDocumentsDirectory();
//     final extractPath = '${appDirectory.path}/tarot_assets';
//     Directory directory = Directory(extractPath);
//     if (await directory.exists()) {
//       print('Tarot card folder exists at: ${directory.path}');
//       var contents = directory.listSync();
//       return contents.isEmpty;
//     } else {
//       print('still false');
//     }
//     return true;
//   }
//
//   Future<void> downloadAndExtractAssets() async {
//     // Download assets zip
//     final url = 'https://thetarotguru.com/tarotapi/assets.zip';
//     final response = await http.get(Uri.parse(url));
//     final appDirectory = await getApplicationDocumentsDirectory();
//     final extractPath = '${appDirectory.path}/tarot_assets';
//
//     print('Extract directory path is : $extractPath');
//
//     Directory directory = Directory(extractPath);
//     if (!await directory.exists()) {
//       await directory.create(recursive: true);
//       print('Extract directory created at: $extractPath');
//     } else {
//       print('Extract directory already exists at: $extractPath');
//     }
//
//       // Save zip file
//       final zipPath = '$extractPath/assets.zip';
//       final zipFile = File(zipPath);
//       await zipFile.writeAsBytes(response.bodyBytes);
//
//       // Extract zip file
//       await Directory(extractPath).create(recursive: true);
//       await Process.run('unzip', ['-o', zipPath, '-d', extractPath]);
//
//       setState(() {
//         _assetsDownloaded = true;
//       });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         fit: StackFit.expand,
//         children: <Widget>[
//           Image.asset(
//             'assets/images/Screen_Backgrounds/introbgdark.jpg',
//             fit: BoxFit.cover,
//           ),
//           Center(
//             child: Container(
//               width: 200,
//               height: 200,
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 shape: BoxShape.circle,
//               ),
//               child: Center(
//                 child: Text(
//                   'Your Logo',
//                   style: TextStyle(
//                     fontSize: 24,
//                     color: Colors.black,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _assetsDownloaded = false;

  @override
  void initState() {
    super.initState();
    // checkAndDownloadAssets();
  }

  // Future<void> checkAndDownloadAssets() async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   bool isLoggedIn = prefs.getBool("isLogin") ?? false;
  //   if (isLoggedIn) {
  //     isTarotCardFolderEmpty();
  //     Get.off(PinEntryScreen());
  //   } else {
  //     final status = await Permission.manageExternalStorage.request();
  //     if (status.isGranted) {
  //       final bool tarotCardFolderEmpty = await isTarotCardFolderEmpty();
  //       if (tarotCardFolderEmpty) {
  //         await downloadAndExtractAssets();
  //         Get.off(IntroductionAnimationScreen());
  //       } else {
  //         Get.off(IntroductionAnimationScreen());
  //       }
  //     } else {
  //       // Handle if storage permission is denied
  //       // For example, show a message to the user or take appropriate action
  //     }
  //   }
  // }
  //
  // Future<bool> isTarotCardFolderEmpty() async {
  //   final appDirectory = await getApplicationDocumentsDirectory();
  //   final extractPath = '${appDirectory.path}/tarot_assets';
  //   Directory directory = Directory(extractPath);
  //   if (await directory.exists()) {
  //     print('Tarot card folder exists at: ${directory.path}');
  //     var contents = directory.listSync();
  //     if (contents.isNotEmpty) {
  //       print('Tarot card folder is not empty. Contents:');
  //       for (var content in contents) {
  //         print(content.path);
  //       }
  //     } else {
  //       print('Tarot card folder is empty.');
  //     }
  //     return contents.isEmpty;
  //   } else {
  //     print('Tarot card folder does not exist at: $extractPath');
  //   }
  //   return true;
  // }
  //
  // Future<void> downloadAndExtractAssets() async {
  //   // Download assets zip
  //   final url = 'https://thetarotguru.com/tarotapi/assets.zip';
  //   final response = await http.get(Uri.parse(url));
  //   final appDirectory = await getApplicationDocumentsDirectory();
  //   final extractPath = '${appDirectory.path}/tarot_assets';
  //
  //   print('Extract directory path is : $extractPath');
  //
  //   Directory directory = Directory(extractPath);
  //   if (!await directory.exists()) {
  //     await directory.create(recursive: true);
  //     print('Extract directory created at: $extractPath');
  //   } else {
  //     print('Extract directory already exists at: $extractPath');
  //   }
  //
  //   // Save zip file
  //   final zipPath = '$extractPath/assets.zip';
  //   final zipFile = File(zipPath);
  //   await zipFile.writeAsBytes(response.bodyBytes);
  //
  //   print('Zip file saved at: $zipPath');
  //
  //   // Extract zip file
  //   await Process.run('unzip', ['-o', zipPath, '-d', extractPath]);
  //   print('Zip file extracted to: $extractPath');
  //
  //   setState(() {
  //     _assetsDownloaded = true;
  //   });
  // }

  @override
  Widget build(BuildContext context) {

    Timer(
      Duration(seconds: 4),
          () async {
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        bool isLoggedIn = prefs.getBool("isLogin") ?? false;

        if (isLoggedIn) {
          Get.off(PinEntryScreen());
        } else {
          Get.off(IntroductionAnimationScreen());
        }
      },
    );

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Image.asset(
            'assets/images/Screen_Backgrounds/introbgdark.jpg',
            fit: BoxFit.cover,
          ),
          Center(
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  'Your Logo',
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
