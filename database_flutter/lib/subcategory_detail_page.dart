import 'package:flutter/material.dart';

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
  int _currentIndex = 0; // Index for the selected bottom navigation item

  // Define the names of the bottom navigation items
  final List<String> _bottomNavBarItems = [
    'Home',
    'Add to Cart',
    'Payment',
  ];

  @override
  Widget build(BuildContext context) {
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
                    // Handle Payment button press
                  },
                  child: Text('Payment'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Handle Add to Cart button press
                  },
                  child: Text('Add to Cart'),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        items: _bottomNavBarItems.map((item) {
          return BottomNavigationBarItem(
            icon: Icon(Icons.home), // You can use different icons here
            label: item,
          );
        }).toList(),
        onTap: (index) {
          // Handle bottom navigation item taps here
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
