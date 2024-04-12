import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_tarot_guru/MainScreens/controller/session_controller.dart';
import 'package:the_tarot_guru/MainScreens/reuseable_blocks.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:the_tarot_guru/MainScreens/subscription/success.dart';

class SubscribeApp extends StatefulWidget {
  @override
  _SubscribeAppState createState() => _SubscribeAppState();
}

class _SubscribeAppState extends State<SubscribeApp> {
  LoginController loginController = Get.put(LoginController());
  late Razorpay _razorpay;

  String firstName = '';
  String lastName = '';
  int? userid = 0;
  String email = '';


  _loadFirstName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      firstName = prefs.getString('firstName') ?? '';
      lastName = prefs.getString('lastName') ?? '';
      userid = prefs.getInt('userid') ?? 0;
      email = prefs.getString('email') ?? '';
    });
    print('First name is :${firstName}');
    print('lastName is :${lastName}');
    print('userid is :${userid}');
  }

  @override
  void initState() {
    super.initState();
    _loadFirstName();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {

    String apiKey = 'rzp_live_0Zk9RSsYyWRK1m';
    String? paymentId = response.paymentId;
    // fetchPaymentDetails(apiKey, paymentId!);

    var url = 'https://thetarotguru.com/tarotapi/subscription.php';
    var body = {
      'user_id': userid.toString(),
      'payment_amount': '1499',
      'payment_method': 'razorpay',
      'transaction_id': response.paymentId,
      'payment_date': DateTime.now().toIso8601String(),
      'payment_status': 'Success',
      'payment_type': 'subscription',
    };
    print('body is : ${body}');

    var webresponse = await http.post(Uri.parse(url), body: body);
    var responseData = json.decode(webresponse.body);
    if (responseData['status'] == 'success') {
      print('Payment details updated successfully');
      print('Message: ${responseData['message']}');
      print('id is ${responseData['id']}');
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SubscriptionSuccessPage(title: 'Thank you for subscribe',)),
      );
    } else {
      print('Failed to update payment details');
      print('Error Message: ${responseData['message']}');
    }
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    print('Payment Error Response: $response');
    print('Error or fail');
    print(response);
    Navigator.pop(context);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    print('External Wallet Response: $response');
    print('External wallet');
    // Navigate back to subscription screen
    Navigator.pop(context);
  }

  void _startPayment() {
    print('Processs Start');
    var userDetails = {
        'userId': userid,
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
      };
    var options = {
      'key': 'rzp_test_wTcTwzsmdJyIpK',
      'amount': 100,
      'name': 'The Tarot Guru',
      'description': 'Subscription Payment',
      'prefill': {'contact': '7878765502', 'email': 'mihirgopani@gmail.com'},
      'external': {
        'wallets': ['paytm']
      },
      'notes': userDetails,
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      print('Error : ${e}');
      debugPrint('Error: $e');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Dark astrology theme
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.subscriptions, // Subscription icon
              size: 50.0,
              color: Colors.white,
            ),
            Text(
              'Subscribe Now', // Subscribe Now text
              style: TextStyle(color: Colors.white, fontSize: 20.0),
            ),
            Text(
              'Free trial Expires on: 1 April 2024', // Free trial expiration date
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 20.0),
            Divider(
              color: Colors.white,
            ),
            SizedBox(height: 20.0),
            Container(
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Colors.grey[800],
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Text(
                'Amount: ₹1499', // Subscription amount
                style: TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              'Features:',
              style: TextStyle(color: Colors.white, fontSize: 18.0),
            ),
            SizedBox(height: 10.0),
            Text(
              '- Access to Osho Zen Tarot & Rider Waite Tarot', // Feature 1
              style: TextStyle(color: Colors.white),
            ),
            Text(
              '- Ad-free experience', // Feature 2
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 20.0),
            Text(
              'Note: Once you make payment, it is not refundable', // Note
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: _startPayment,
              child: Text('Subscribe Now'), // Subscribe Now button
            ),
            ElevatedButton(
              onPressed: () {loginController.logout(context);},
              child: Text('Log out'), // Subscribe Now button
            ),
          ],
        ),
      ),
    );
  }
}



// class SubscribeApp extends StatefulWidget {
//   @override
//   _SubscribeAppState createState() => _SubscribeAppState();
// }
//
// class _SubscribeAppState extends State<SubscribeApp> {
//   @override
//   void initState() {
//     super.initState();
//   }
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
//                   Color.fromRGBO(19, 14, 42, 1),
//                   Color.fromRGBO(19, 14, 42, 1),
//                 ],
//               ),
//             ),
//           ),
//           Positioned.fill(
//             child: Image.asset(
//               'assets/images/Screen_Backgrounds/bg1.png', // Replace with your image path
//               fit: BoxFit.cover,
//               opacity: const AlwaysStoppedAnimation(.3),
//             ),
//           ),
//           Column(
//             children: [
//               SizedBox(
//                 height: AppBar().preferredSize.height+100,
//               ),
//               Center(
//                 child: SingleChildScrollView(
//                     scrollDirection: Axis.vertical,
//                     child: Column(
//                       children: [
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: [
//                             Container(
//                               width:100,
//                               height: 100,
//                               decoration: BoxDecoration(
//                                 color: Colors.deepPurple,
//                                 shape: BoxShape.circle,
//                               ),
//                               child: Icon(Icons.workspace_premium,size: 50,color: Colors.white,),
//                             ),
//                             SizedBox(
//                               height: 15,
//                             ),
//                             Text('Subscribe App',style: TextStyle(
//                               color: Colors.amber,
//                               fontSize: 35,
//                               fontWeight: FontWeight.w800
//                             ),
//                             ),
//                             SizedBox(
//                               height: 15,
//                             ),
//                             Text("Free Trial expire in: 21 Days",style: TextStyle(
//                               color: Colors.white
//                             ),
//                             ),
//
//                             Container(
//                               height: 100,
//                               padding: EdgeInsets.symmetric(horizontal: 15,vertical: 15),
//                               width: MediaQuery.of(context).size.width*0.8,
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(10),
//                                 border: Border.all(
//                                   width: 2,
//                                   color: Colors.white
//                                 )
//                               ),
//                               child: Text(
//                                 'FUll App Access',
//                                 style: TextStyle(
//                                   fontSize: 20,
//                                   color: Colors.white
//                                 ),
//                               ),
//                             )
//
//                           ],
//                         )
//                       ],
//                     )
//                 ),
//               ),
//
//             ],
//           )
//         ],
//       ),
//     );
//   }
// }