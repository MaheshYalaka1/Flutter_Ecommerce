import 'package:flutter/material.dart';
import 'bottomnavigation.dart';
import 'homepage.dart';
import 'add_to_cart.dart';
import 'payment_page.dart';
import 'package:provider/provider.dart';

class SubcategoryDetailPage extends StatefulWidget {
  final String image;
  final String subcatname;
  final String price;
  final String description;

  SubcategoryDetailPage({
    required this.image,
    required this.subcatname,
    required this.price,
    required this.description,
  });

  @override
  _SubcategoryDetailPageState createState() => _SubcategoryDetailPageState();
}

class _SubcategoryDetailPageState extends State<SubcategoryDetailPage> {
  int _currentIndex = 0;
  final GlobalKey<MyBottomNavigationBarState> bottomNavigationKey =
      GlobalKey<MyBottomNavigationBarState>();

  final CartModel cart = CartModel();

  @override
  Widget build(BuildContext context) {
    final cart =
        Provider.of<CartModel>(context, listen: false); // Add this line

    return Scaffold(
      appBar: AppBar(
        title: Text('Subcategory Detail'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.network(
              widget.image,
              width: double.infinity,
            ),
            SizedBox(height: 20),
            Text('Name: ${widget.subcatname}'),
            Text('Price: ${widget.price}'),
            SizedBox(height: 20),
            Text('Description:'),
            Text(widget.description),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PaymentPage(
                          bottomNavigationKey: bottomNavigationKey,
                        ),
                      ),
                    );
                    // Handle Payment button press
                  },
                  child: Text('Payment'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Handle Add to Cart button press
                    cart.addToCart(
                      widget.subcatname,
                      double.parse(widget.price),
                      widget.image,
                    );
                    // Provide feedback to the user
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Added to Cart'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  },
                  child: Text('Add to Cart'),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: MyBottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
          if (index == 0) {
            // Navigate to MyHomePage when "Home" is tapped
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => MyHomePage()),
            );
          } else if (index == 1) {
            // Navigate to the CartPage when "Cart" is tapped
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CartPage(
                  bottomNavigationKey: bottomNavigationKey,
                  cart: cart,
                ),
              ),
            );
          } else if (index == 2) {
            // Navigate to the PaymentPage when "Payment" is tapped
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PaymentPage(
                  bottomNavigationKey: bottomNavigationKey,
                ),
              ),
            );
          }
        },
        key: bottomNavigationKey,
      ),
    );
  }
}
