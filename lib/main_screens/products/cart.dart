  import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
  import 'package:the_tarot_guru/main_screens/Products/cart_functions.dart';
  import 'package:the_tarot_guru/main_screens/Products/products.dart';

  import '../controller/order_controller/order_process_screen.dart';

  class CartPage extends StatefulWidget {
    @override
    _CartPageState createState() => _CartPageState();
  }

  class _CartPageState extends State<CartPage> {
    CartService _cartService = CartService();
    List<Map<String, dynamic>> _cartItems = [];
    double _totalCartValue = 0.0;

    @override
    void initState() {
      super.initState();
      _fetchCartItems();
    }

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

    void _incrementQuantity(int index) async {
      setState(() {
        _cartItems[index]['quantity']++;
        _updateTotalCartValue();
      });
      // Update quantity in SharedPreferences
      await _updateCartItemQuantity(_cartItems[index]);
    }

    void _decrementQuantity(int index) async {
      setState(() {
        if (_cartItems[index]['quantity'] > 1) {
          _cartItems[index]['quantity']--;
          _updateTotalCartValue();
        }
      });
      // Update quantity in SharedPreferences
      await _updateCartItemQuantity(_cartItems[index]);
    }

    Future<void> _updateCartItemQuantity(Map<String, dynamic> cartItem) async {
      try {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        List<Map<String, dynamic>> cart = json.decode(prefs.getString(CartService.cartKey) ?? '[]').cast<Map<String, dynamic>>();
        int index = cart.indexWhere((item) => item['productId'] == cartItem['productId']);
        if (index != -1) {
          cart[index]['quantity'] = cartItem['quantity'];
          await prefs.setString(CartService.cartKey, json.encode(cart));
        }
      } catch (e) {
        print('Error updating cart item quantity: $e');
      }
    }

    void _removeItem(int index) async {
      _cartService.removeFromCart(index);
    }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        backgroundColor: Color(0xFF100E0E),
        appBar: AppBar(
          backgroundColor: Color(0xFF100E0E),
          title: Text('Your Cart',style: TextStyle(color: Colors.white),),
          leading: IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Products()
                    ));
              },
              icon: Icon(
                  Icons.arrow_back,
                color: Colors.white,
              )
          ),
        ),
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: _buildCartList(),
              ),
              Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 32),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Total:',
                              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold,color: Colors.white),
                            ),
                            Text(
                              '\₹$_totalCartValue',
                              style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold,color: Colors.white),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    child: ElevatedButton(
                      onPressed: (){
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => OrderProcess()
                            ));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF4B69FF), // Set button color to black
                        minimumSize: Size(double.infinity, 50), // Set full width
                      ),
                      child: Text(
                        'Checkout',
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
        ),
      );
    }

    Widget _buildCartList() {
      if (_cartItems.isEmpty) {
        return Center(
          child: Text('Your cart is empty.'),
        );
      } else {
        return Expanded(
          child: ListView.builder(
            itemCount: _cartItems.length,
            itemBuilder: (context, index) {
              final cartItem = _cartItems[index];
              return Column(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 100,
                          height: 100,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15.0),
                            child: Image.network(
                              cartItem['ProductFirstImage'],
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(width: 12.0),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                cartItem['productName'],
                                style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 18),
                              ),
                              SizedBox(height: 4.0),
                              Row(
                                children: [
                                  CircleAvatar(
                                    radius: 15,
                                    backgroundColor: Colors.white30, //<-- SEE HERE
                                    child: IconButton(
                                      icon: Icon(
                                        size: 15,
                                        Icons.remove,
                                        color: Colors.white,
                                      ),
                                      onPressed: () {_decrementQuantity(index);},
                                    ),
                                  ),
                                  SizedBox(width: 15,),
                                  Text('${cartItem['quantity']}',style: TextStyle(
                                    color: Colors.white
                                  ),),
                                  SizedBox(width: 15,),
                                  CircleAvatar(
                                    radius: 15,
                                    backgroundColor: Color(0xFF4B69FF), //<-- SEE HERE
                                    child: IconButton(
                                      icon: Icon(
                                        size: 15,
                                        Icons.add,
                                        color: Colors.white,
                                      ),
                                      onPressed: () {_incrementQuantity(index);},
                                    )
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      size: 25,
                                      Icons.delete_forever,
                                      color: Colors.white,
                                    ),
                                    onPressed: () async {
                                      _removeItem(cartItem['productId']);
                                      await _cartItems.remove(_cartItems[index]['productId']);
                                      _fetchCartItems();
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SizedBox(
                              height: 5,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5.0),
                                color: Color(0xFF4B69FF)
                              ),
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                '\₹${cartItem['productPrice']}',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  const Divider(
                    height: 20,
                    thickness: 1,
                    indent: 20,
                    endIndent: 0,
                    color: Colors.white30,
                  ),
                ],
              );
            },
          ),
        );
      }
    }


  }
