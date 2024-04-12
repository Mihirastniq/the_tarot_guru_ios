import 'package:flutter/material.dart';
import 'package:the_tarot_guru/MainScreens/Products/cart_functions.dart';
import 'package:the_tarot_guru/MainScreens/Products/products.dart';

import '../controller/Order/order_process_screen.dart';

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

  void _incrementQuantity(int index) {
    setState(() {
      _cartItems[index]['quantity']++;
      _updateTotalCartValue();
    });
  }

  void _decrementQuantity(int index) {
    setState(() {
      if (_cartItems[index]['quantity'] > 1) {
        _cartItems[index]['quantity']--;
        _updateTotalCartValue();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Your Cart'),
        leading: IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Products()
                  ));
            },
            icon: Icon(
                Icons.arrow_back
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
                  child: Column(
                    children: [
                      Row(
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
                              builder: (context) => OrderProcessScreen()
                          ));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black, // Set button color to black
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
      return Expanded( // Wrap ListView.builder with Expanded
        child: ListView.builder(
          itemCount: _cartItems.length,
          itemBuilder: (context, index) {
            final cartItem = _cartItems[index];
            return ListTile(
              title: Text(cartItem['productName']),
              subtitle: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.remove),
                    onPressed: () => _decrementQuantity(index),
                  ),
                  Text('${cartItem['quantity']}'),
                  IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () => _incrementQuantity(index),
                  ),
                ],
              ),
              trailing: Text('\₹${cartItem['productPrice']}'),
            );
          },
        ),
      );
    }
  }

}
