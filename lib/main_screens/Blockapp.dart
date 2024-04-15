// import 'package:flutter/material.dart';
// import 'reuseable_blocks.dart';
// import 'controller/session_controller.dart';
//
// class BlockApp extends StatefulWidget {
//   @override
//   _BlockAppState createState() => _BlockAppState();
// }
//
// class _BlockAppState extends State<BlockApp> {
//
//   @override
//   void initState() {
//     super.initState();
//   }
//
//   final LoginController loginController = Get.put(LoginController());
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           Container(
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 begin: Alignment.topCenter,
//                 end: Alignment.bottomCenter,
//                 colors: [
//                   Theme.of(context).primaryColor,
//                   Theme.of(context).scaffoldBackgroundColor,
//                 ],
//               ),
//             ),
//           ),
//           Positioned.fill(
//             child: Image.asset(
//               'assets/images/pngbackround.png',
//               fit: BoxFit.cover,
//             ),
//           ),
//           SingleChildScrollView(
//             scrollDirection: Axis.vertical,
//             child: Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
