import 'package:flutter/material.dart';
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
  final CartModel cart = CartModel();

  @override
  Widget build(BuildContext context) {
    final cart =
        Provider.of<CartModel>(context, listen: false); // Add this line

    return Scaffold(
      appBar: AppBar(
        title: Text('product Detail'),
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
                        builder: (context) => PaymentPage(),
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
    );
  }
}
