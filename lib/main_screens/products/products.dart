import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:the_tarot_guru/home.dart';
import 'package:the_tarot_guru/main_screens/Products/productdetail.dart';
import 'package:the_tarot_guru/main_screens/reuseable_blocks.dart';
import 'package:the_tarot_guru/main_screens/controller/functions.dart';
import 'package:the_tarot_guru/main_screens/other_screens/settings.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'dart:convert';

import 'cart.dart';

class Products extends StatefulWidget {
  @override
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  List<dynamic> productList = [];

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    String uri = "https://thetarotguru.com/tarotapi/productsapi.php";
    var requestBody = {
      'request_type': 'FetchProducts',
    };

    print("Request Body: $requestBody"); // Print request body
    var res = await http.post(Uri.parse(uri), body: requestBody);
    print("Response Status Code: ${res.statusCode}");
    print("Response Body: ${res.body}");

    if (res.statusCode == 200) {
      setState(() {
        productList = json.decode(res.body);
      });
    } else {
      // Handle error response
      print("Error: Unable to fetch products");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF15145D),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AppSelect()),
            );
          },
        ),
        title: Text(
          '${AppLocalizations.of(context)!.bookslabel}',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_bag, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CartPage()),
              );
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          Container(
            color: Color(0xFF15145D),
          ),
          ListView.builder(
            itemCount: productList.length,
            itemBuilder: (context, index) {
              var product = productList[index];
              return _buildButton(context, product);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildButton(BuildContext context, dynamic product) {
    String firstImageUrl = product['images'][0]['image_url'] ?? '';
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          color: Color(0xFF29297F),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(5.0),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductInfoScreen(
                    productid: int.parse(product['id']),
                  ),
                ),
              );
            },
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.all(10),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network('${firstImageUrl}',fit: BoxFit.cover,width: 80),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.fromLTRB(0, 5, 5, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product['title'] ?? '',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 22.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          product['description'] ?? '',
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(color: Colors.white),
                        ),
                        SizedBox(height: 15),
                        Text(
                          "${AppLocalizations.of(context)!.pricelabel} : \₹${product['price'] ?? ''}",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                        SizedBox(height: 15),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
