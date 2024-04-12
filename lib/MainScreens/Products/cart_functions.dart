import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class CartService {
  static const String cartKey = 'cart';

  Future<void> addToCart(int productId, String productName, double productPrice, int quantity, int orderValue) async {
    try {
      // Create or retrieve SharedPreferences instance
      SharedPreferences prefs = await SharedPreferences.getInstance();

      // Retrieve existing cart data or initialize an empty list
      List<Map<String, dynamic>> cart = json.decode(prefs.getString(cartKey) ?? '[]').cast<Map<String, dynamic>>();

      // Check if the product is already in the cart
      bool productExists = cart.any((item) => item['productId'] == productId);

      if (productExists) {
        // If the product exists, update its quantity and order value
        cart.forEach((item) {
          if (item['productId'] == productId) {
            item['quantity'] += quantity;
            item['orderValue'] += orderValue;
          }
        });
      } else {
        // If the product doesn't exist, add it to the cart
        cart.add({
          'productId': productId,
          'productName': productName,
          'productPrice': productPrice,
          'quantity': quantity,
          'orderValue': orderValue,
        });
      }

      // Save the updated cart data to SharedPreferences
      await prefs.setString(cartKey, json.encode(cart));

      print('Product added to cart successfully!');
    } catch (e) {
      print('Error adding product to cart: $e');
    }
  }
  Future<void> clearCart() async {
    try {
      // Create or retrieve SharedPreferences instance
      SharedPreferences prefs = await SharedPreferences.getInstance();

      // Clear the cart data from SharedPreferences
      await prefs.remove(cartKey);

      print('Cart cleared successfully!');
    } catch (e) {
      print('Error clearing cart: $e');
    }
  }
  Future<List<Map<String, dynamic>>> getCart() async {
    try {
      // Create or retrieve SharedPreferences instance
      SharedPreferences prefs = await SharedPreferences.getInstance();

      // Retrieve existing cart data or return an empty list
      List<Map<String, dynamic>> cart = json.decode(prefs.getString(cartKey) ?? '[]').cast<Map<String, dynamic>>();

      return cart;
    } catch (e) {
      print('Error retrieving cart: $e');
      return [];
    }
  }
}
