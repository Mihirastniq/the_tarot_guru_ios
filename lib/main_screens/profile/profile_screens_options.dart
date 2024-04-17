import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_tarot_guru/main_screens/other_screens/add_address.dart';

class UserDetailsScreen extends StatefulWidget {
  const UserDetailsScreen({Key? key}) : super(key: key);

  @override
  State<UserDetailsScreen> createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  late String _firstName = '';
  late String _lastName = '';
  late String _email = '';
  late int _phone = 0;
  late int _appPin = 0;
  late String _language = '';
  late String _createdAt = '';
  late int _subscriptionStatus = 0;

  @override
  void initState() {
    super.initState();
    _getUserDetails();
  }

  Future<void> _getUserDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _firstName = prefs.getString('firstName') ?? '';
    _lastName = prefs.getString('lastName') ?? '';
    _email = prefs.getString('email') ?? '';
    _phone = prefs.getInt('phone') ?? 0;
    _appPin = prefs.getInt('appPin') ?? 0;
    _language = prefs.getString('lang') ?? '';
    _createdAt = prefs.getString('created_at') ?? '';
    _subscriptionStatus = prefs.getInt('subscription_status') ?? 0;
    setState(() {}); // Update the UI with fetched data
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF1C1C2D),
                  Color(0xFF1C1C2D),
                ],
              ),
            ),
          ),
          Positioned(
            top: 5,
            left: 0,
            right: 0,
            child: AppBar(
              leading: Builder(
                builder: (context) => IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                    size: 35,
                  ),
                ),
              ),
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: Text(
                'Profile',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Center(
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                margin:
                    EdgeInsets.only(top: AppBar().preferredSize.height + 50),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'User Name:',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        SizedBox(height: 8),
                        Text(
                          '$_firstName $_lastName',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                        // Display other user details similarly
                      ],
                    ),
                    const Divider(
                      height: 45,
                      thickness: 1,
                      indent: 5,
                      endIndent: 0,
                      color: Colors.grey,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'E-mail:',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        SizedBox(height: 8),
                        Text(
                          '$_email',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                        // Display other user details similarly
                      ],
                    ),
                    const Divider(
                      height: 45,
                      thickness: 1,
                      indent: 5,
                      endIndent: 0,
                      color: Colors.grey,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Phone Number:',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        SizedBox(height: 8),
                        Text(
                          '$_phone',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                        // Display other user details similarly
                      ],
                    ),
                    const Divider(
                      height: 45,
                      thickness: 1,
                      indent: 5,
                      endIndent: 0,
                      color: Colors.grey,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'App login Pin',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        SizedBox(height: 8),
                        Text(
                          '$_appPin',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                        // Display other user details similarly
                      ],
                    ),
                    const Divider(
                      height: 45,
                      thickness: 1,
                      indent: 5,
                      endIndent: 0,
                      color: Colors.grey,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Join Date:',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        SizedBox(height: 8),
                        Text(
                          '$_createdAt',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                        // Display other user details similarly
                      ],
                    ),
                    const Divider(
                      height: 45,
                      thickness: 1,
                      indent: 5,
                      endIndent: 0,
                      color: Colors.grey,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Selected language:',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        SizedBox(height: 8),
                        Text(
                          '$_language',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                        // Display other user details similarly
                      ],
                    ),
                  ],
                )),
          ),
        ],
      ),
    );
  }
}

class UserAddresses extends StatefulWidget {
  const UserAddresses({Key? key}) : super(key: key);

  @override
  State<UserAddresses> createState() => _UserAddressesState();
}

class _UserAddressesState extends State<UserAddresses> {
  late int _userId;
  List<Map<String, dynamic>> _addresses = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchUserAddress();
  }

  Future<void> _fetchUserAddress() async {
    setState(() {
      _isLoading = true;
    });

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _userId = prefs.getInt('userid') ?? 0;
    });

    // API endpoint URL
    String apiUrl = 'https://thetarotguru.com/tarotapi/addresses.php';

    var response = await http.post(Uri.parse(apiUrl), body: {
      'type': 'fetchAddress',
      'user_id': _userId.toString(),
    });

    if (response.statusCode == 200) {
      Map<String, dynamic> responseData = jsonDecode(response.body);
      if (responseData['status'] == 'success') {
        print('Address : ${response.body}');
        setState(() {
          _addresses =
              List<Map<String, dynamic>>.from(responseData['addresses']);
          _isLoading = false;
        });
      } else {
        // No address found
        setState(() {
          _isLoading = false;
        });
        print('No address found');
      }
    } else {
      // Error in API request
      setState(() {
        _isLoading = false;
      });
      print('Failed to fetch user addresses');
    }
  }

  Future<void> _removeaddress(String address_id) async {
      try {
        String uri = "https://thetarotguru.com/tarotapi/addresses.php";
        var requestBody = {
          "type": "removeAddress",
          "address_id": address_id,
        };
        print('req body is : $requestBody');

        var response = await http.post(Uri.parse(uri), body: requestBody);

        if (response.statusCode == 200) {
          Navigator.of(context).pop(); // Close the screen
        } else {
          print(response.body);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Failed to remove address. Please try again later.'),
            ),
          );
        }
      } catch (e) {

        print('Error removing address: $e');
        // Show error message to the user
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error removing address. Please try again later.'),
          ),
        );
      }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF1C1C2D),
                  Color(0xFF1C1C2D),
                ],
              ),
            ),
          ),
          Positioned.fill(
            child: Image.asset(
              'assets/images/Screen_Backgrounds/product.png', // Replace with your image path
              fit: BoxFit.cover,
              opacity: const AlwaysStoppedAnimation(.3),
            ),
          ),
          Positioned(
            top: 5,
            left: 0,
            right: 0,
            child: AppBar(
              leading: Builder(
                builder: (context) => IconButton(
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
                    icon: Icon(
                      Icons.segment_rounded,
                      color: Colors.white,
                      size: 35,
                    )),
              ),
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: Text(
                'Addresses',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Center(
            child: _isLoading
                ? CircularProgressIndicator()
                : _addresses.isNotEmpty
                    ? ListView.builder(
                        itemCount: _addresses.length,
                        itemBuilder: (context, index) {
                          // Extract the address details from the response
                          Map<String, dynamic> address = _addresses[index];

                          // Create a container for each address
                          return Container(
                            margin: EdgeInsets.only(
                                bottom: 10,
                                left: 20,
                                right: 20,
                                top: AppBar().preferredSize.height + 50),
                            padding: EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  blurRadius: 5,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Address ${index + 1}:',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold)),
                                Text('${address['address_line1']}, ${address['address_line2']}'),
                                Text('City: ${address['city']}'),
                                Text('State: ${address['state']}'),
                                Text('Country: ${address['country']}'),
                                Text('Postal Code: ${address['postal_code']}'),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    IconButton(onPressed: (){
                                      _removeaddress(address['address_id']);
                                    }, icon: Icon(Icons.delete))
                                  ],
                                )
                              ],
                            ),
                          );
                        },
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('No addresses found',
                              style:
                                  TextStyle(fontSize: 22, color: Colors.white)),
                          SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AddAddressScreen()),
                              );
                            },
                            child: Text('Add Address'),
                          ),
                        ],
                      ),
          ),
        ],
      ),
    );
  }
}

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  late int _userId;
  List<Map<String, dynamic>> _orders = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchUserOrders();
  }

  Future<void> _fetchUserOrders() async {
    setState(() {
      _isLoading = true;
    });

    // Fetch user ID from SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _userId = prefs.getInt('userid') ?? 0;

    // API endpoint URL
    String apiUrl = 'https://thetarotguru.com/tarotapi/fetchorders.php';

    var response = await http.post(Uri.parse(apiUrl), body: {
      'type': 'fetchOrders',
      'user_id': _userId.toString(),
    });

    if (response.statusCode == 200) {
      Map<String, dynamic> responseData = jsonDecode(response.body);
      if (responseData['status'] == 'success') {
        // User orders found
        setState(() {
          _orders = List<Map<String, dynamic>>.from(responseData['orders']);
          _isLoading = false;
        });
      } else {
        // No orders found
        setState(() {
          _isLoading = false;
        });
        print('No orders found');
      }
    } else {
      // Error in API request
      setState(() {
        _isLoading = false;
      });
      print('Failed to fetch user orders');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF1C1C2D),
                  Color(0xFF1C1C2D),
                ],
              ),
            ),
          ),
          Positioned.fill(
            child: Image.asset(
              'assets/images/Screen_Backgrounds/product.png', // Replace with your image path
              fit: BoxFit.cover,
              opacity: const AlwaysStoppedAnimation(.3),
            ),
          ),
          Positioned(
            top: 5,
            left: 0,
            right: 0,
            child: AppBar(
              leading: Builder(
                builder: (context) => IconButton(
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                  icon: Icon(
                    Icons.segment_rounded,
                    color: Colors.white,
                    size: 35,
                  ),
                ),
              ),
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: Text(
                'Orders',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Center(
            child: _isLoading
                ? CircularProgressIndicator()
                : _orders.isNotEmpty
                ? ListView.builder(
              itemCount: _orders.length,
              itemBuilder: (context, index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Order ${index + 1}:'),
                    // Display order details here
                    SizedBox(height: 20),
                  ],
                );
              },
            )
                : Text(
              'No orders found',
              style: TextStyle(fontSize: 22, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}


