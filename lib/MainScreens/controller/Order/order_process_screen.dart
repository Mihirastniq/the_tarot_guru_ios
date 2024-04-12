import 'package:dynamic_multi_step_form/dynamic_json_form.dart';
import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:the_tarot_guru/MainScreens/OtherScreens/addaddress.dart';
import 'package:the_tarot_guru/MainScreens/Products/cart.dart';
import 'package:the_tarot_guru/MainScreens/subscription/success.dart';
import '../../Products/cart_functions.dart';

class OrderProcessScreen extends StatefulWidget {
  @override
  _OrderProcessScreenState createState() => _OrderProcessScreenState();
}

class _OrderProcessScreenState extends State<OrderProcessScreen> {
  late SharedPreferences _prefs;
  String _firstName = '';
  String _lastName = '';
  String _email = '';
  String _phoneNumber = '';
  String _billingName = '';
  List<Map<String, dynamic>> _addresses = [];
  List<Map<String, dynamic>> _cartItems = [];
  double _totalValue = 0.0;
  int _currentPart = 1;
  int _selectedAddressIndex = 0; // Add this line
  late Razorpay _razorpay;
  int? userid = 0;

  @override
  void initState() {
    _retrieveUserData();
    _retrieveBillingDetails();
    _fetchCartItems();

    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    String apiKey = 'rzp_live_0Zk9RSsYyWRK1m';
    String? paymentId = response.paymentId;
    var url = 'https://thetarotguru.com/tarotapi/orderHandler.php';

    // Create a list to store the products
    List<Map<String, dynamic>> products = [];

    // Populate the products list from the cart items
    for (var item in _cartItems) {
      products.add({
        'product_id': item['productId'].toString(),
        'quantity': item['quantity'].toString(),
      });
    }

    // Construct the body
    var body = {
      "type": "order",
      'user_id': userid.toString(),
      'payment_amount': _totalCartValue.toString(),
      'payment_mode': 'razorpay',
      'payment_id': response.paymentId,
      'payment_date': DateTime.now().toIso8601String(),
      'payment_status': 'Success',
      'payment_type': 'order',
      'user_name': _firstName + _lastName,
      'billing_name': _addresses[_selectedAddressIndex]['billing_name'],
      'address_id': (_selectedAddressIndex+1).toString(),
      'order_date': DateTime.now().toString(),
      'total_price': _totalCartValue.toString(),
      'products': json.encode(products), // Convert products list to JSON string
    };

    try {
      await _cartService.clearCart();
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
    } catch (e) {
      print('Error: $e');
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
      'firstName': _firstName,
      'lastName': _lastName,
      'email': _email,
    };
    var options = {
      'key': 'rzp_test_wTcTwzsmdJyIpK',
      'amount': _totalCartValue * 100,
      'name': 'The Tarot Guru',
      'description': 'Order',
      'prefill': {'contact': '$_phoneNumber', 'email': '$_email'},
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

  Future<void> _retrieveUserData() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      _firstName = _prefs.getString('firstName') ?? '';
      _lastName = _prefs.getString('lastName') ?? '';
      _email = _prefs.getString('email') ?? '';
      _phoneNumber = _phoneNumber = (_prefs.getInt('phone') ?? 0).toString();
      userid = _prefs.getInt('userid') ?? 0;
    });

  }
  Future<void> _retrieveBillingDetails() async {
    _prefs = await SharedPreferences.getInstance();
    int userId = _prefs.getInt('userid') ?? 0;
    if (userId != 0) {
      try {
        String uri = "https://thetarotguru.com/tarotapi/addresses.php";
        var requestBody = {
          "user_id": (userId).toString(),
          "type":'fetchAddress',
        };
        print("req body = ${requestBody}");
        var response = await http.post(Uri.parse(uri), body: requestBody);
        print('Response is : ${response.body}');

        // Parse the response and update _addresses list
        var jsonResponse = json.decode(response.body);
        if (jsonResponse['status'] == 'success') {
          List<Map<String, dynamic>> addresses = [];
          for (int i = 0; jsonResponse[i.toString()] != null; i++) {
            addresses.add(Map<String, dynamic>.from(jsonResponse[i.toString()]));
          }
          setState(() {
            _addresses = addresses;
          });
        } else {
          print('Failed to retrieve addresses: ${jsonResponse['message']}');
        }
      } catch (e) {
        print('Error fetching addresses: $e');
      }
    }
  }


  CartService _cartService = CartService();
  double _totalCartValue = 0.0;

  Future<void> _fetchCartItems() async {
    try {
      List<Map<String, dynamic>> cart = await _cartService.getCart();
      setState(() {
        _cartItems = cart;
        _updateTotalCartValue();
      });
    } catch (e) {
      print('Error fetching cart items: $e');
    }
  }

  void _updateTotalCartValue() {
    double totalValue = 0.0;
    for (var item in _cartItems) {
      totalValue += (item['productPrice'] * item['quantity']);
    }
    setState(() {
      _totalCartValue = totalValue;
    });
  }

  void _nextPart() {
    setState(() {
      _currentPart++;
    });
  }

  void _previousPart() {
    setState(() {
      _currentPart--;
    });
  }

  Widget _buildPart1() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'User Details',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16),
        Text(
          'First Name',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            color: Colors.lightGreen.withOpacity(0.2),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: TextField(
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
            ),
            style: TextStyle(fontSize: 16.0),
            controller: TextEditingController(text: _firstName),
            onChanged: (value) => _firstName = value,
          ),
        ),
        SizedBox(height: 16),
        Text(
          'Last Name',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            color: Colors.lightGreen.withOpacity(0.2),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: TextField(
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
            ),
            style: TextStyle(fontSize: 16.0),
            controller: TextEditingController(text: _lastName),
            onChanged: (value) => _lastName = value,
          ),
        ),
        SizedBox(height: 16),
        Text(
          'E-mail',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            color: Colors.lightGreen.withOpacity(0.2),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: TextField(
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
            ),
            style: TextStyle(fontSize: 16.0),
            controller: TextEditingController(text: _email),
            onChanged: (value) => _email = value,
          ),
        ),
        SizedBox(height: 16),
        Text(
          'Phone Number',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            color: Colors.lightGreen.withOpacity(0.2),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: TextField(
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
            ),
            style: TextStyle(fontSize: 16.0),
            controller: TextEditingController(text: _phoneNumber),
            onChanged: (value) => _phoneNumber = value,
          ),
        ),
      ],
    );
  }

  Widget _buildPart2() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Billing Details',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16),
        _addresses.isEmpty
            ? Text(
          'No address found',
          style: TextStyle(fontSize: 16),
        )
            : Column(
          children: List.generate(
            _addresses.length,
                (index) {
              Map<String, dynamic> address = _addresses[index];
              return Column(
                children: [
                  ListTile(
                    title: Text(address['billing_name']),
                    subtitle: Text(
                        '${address['address_line1']}, ${address['address_line2']}, ${address['city']}, ${address['state']}, ${address['country']} - ${address['postal_code']}'),
                    tileColor: _selectedAddressIndex == index
                        ? Colors.lightGreen.withOpacity(0.2)
                        : Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      side: BorderSide(
                        color: _selectedAddressIndex == index
                            ? Colors.black
                            : Colors.grey,
                        width: _selectedAddressIndex == index ? 2 : 1,
                      ),
                    ),
                    onTap: () {
                      setState(() {
                        _selectedAddressIndex = index;
                      });
                    },
                  ),
                  SizedBox(height: 8), // Add space between each address
                ],
              );
            },
          ),
        ),
        SizedBox(height: 16),
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddAddressScreen(),
              ),
            );
          },
          child: Text('Add Address'),
        ),
        ElevatedButton(
          onPressed: () {
            _retrieveBillingDetails();
          },
          child: Text('Reload'),
        ),
        SizedBox(height: 16),
      ],
    );
  }

  Widget _buildPart3() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('Billing Details', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Name: ${_addresses[_selectedAddressIndex]['billing_name']}'),
              Text('Phone: $_phoneNumber'),
              Text('Address: ${_addresses[_selectedAddressIndex]['address_line1']} ${_addresses[_selectedAddressIndex]['address_line2']} \n ${_addresses[_selectedAddressIndex]['city']}, ${_addresses[_selectedAddressIndex]['state']} ${_addresses[_selectedAddressIndex]['postal_code']} ')
            ],
          ),
          SizedBox(height: 20),
          Text('Items', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          Container(
            height: double.infinity,
            child: ListView.builder(
              itemCount: _cartItems.length,
              itemBuilder: (context, index) {
                final cartItem = _cartItems[index];
                return ListTile(
                  title: Text(cartItem['productName']),
                  subtitle: Row(
                    children: [],
                  ),
                  trailing: Text('\₹${cartItem['productPrice']}'),
                );
              },
            ),
          )
        ],
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    Widget currentPart;
    switch (_currentPart) {
      case 1:
        currentPart = _buildPart1();
        break;
      case 2:
        currentPart = _buildPart2();
        break;
      case 3:
        currentPart = _buildPart3();
        break;
      default:
        currentPart = SizedBox.shrink();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Place Order'),
        leading: IconButton(
            onPressed: _currentPart > 1 ? _previousPart : () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CartPage()
                  ));
            },
            icon: Icon(
              Icons.arrow_back
            )
        ),
      ),
      backgroundColor: Colors.white, // Set background color to white
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'User Details',
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Billing',
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Overview',
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: CustomProgressBar(
                        currentPart: _currentPart,
                        totalParts: 3, // Adjust based on the total number of parts
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 32),
                Container(
                  child: currentPart,
                ),
              ],
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total:',
                        style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '\₹$_totalCartValue',
                        style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: ElevatedButton(
                    onPressed: _currentPart < 3 ? _nextPart : () {_startPayment();},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black, // Set button color to black
                      minimumSize: Size(double.infinity, 50), // Set full width
                    ),
                    child: Text(
                      _currentPart < 3 ? 'Next' : 'Checkout',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0, // Increase font size
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      )
    );
  }

}

class CustomProgressBar extends StatelessWidget {
  final int currentPart;
  final int totalParts;

  const CustomProgressBar({
    Key? key,
    required this.currentPart,
    required this.totalParts,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: List.generate(
            totalParts,
                (index) => Expanded(
              child: Container(
                height: 4,
                color: index + 1 <= currentPart ? Colors.green : Colors.grey.withOpacity(0.5),
              ),
            ),
          ),
        ),
        SizedBox(height: 8),
      ],
    );
  }
}
