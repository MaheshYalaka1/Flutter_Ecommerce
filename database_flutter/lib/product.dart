import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'subcategory_detail_page.dart';
import 'add to cart.dart';
import 'bottomnavigation.dart';
import 'payment_page.dart';
import 'homepage.dart';

class CategoryDetailPage extends StatefulWidget {
  final String categoryId;

  CategoryDetailPage({required this.categoryId});

  @override
  _CategoryDetailPageState createState() => _CategoryDetailPageState();
}

class _CategoryDetailPageState extends State<CategoryDetailPage> {
  int _currentIndex = 0;
  final GlobalKey<MyBottomNavigationBarState> bottomNavigationKey =
      GlobalKey<MyBottomNavigationBarState>();
  final CartModel cart = CartModel();
  Map<String, dynamic> finalResult = {}; // Store the result from the API
  bool isLoading = true; // Track whether data is being fetched
  @override
  void initState() {
    super.initState();
    fetchFinalResult();
  }

  Future<void> fetchFinalResult() async {
    final url = Uri.parse(
        "http://iphone.us2guntur.com/SubcatResponseNewV15?catid=${widget.categoryId}");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final result = jsonData[
          "finalresult"]; // Use the appropriate key from the API response

      setState(() {
        finalResult = result;
        isLoading = false; // Set isLoading to false when data is available
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Category Detail'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Category ID: ${widget.categoryId}'),
            SizedBox(height: 20),
            Text('Final Result:'),
            isLoading
                ? CircularProgressIndicator() // Show loading indicator when data is being fetched
                : finalResult.isNotEmpty
                    ? Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            children: <Widget>[
                              Text('Subcategories:'),
                              GridView.count(
                                crossAxisCount: 2,
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                children: List.generate(
                                  finalResult["related_subcatslist"].length,
                                  (index) {
                                    final subcategory =
                                        finalResult["related_subcatslist"]
                                            [index];
                                    return GestureDetector(
                                      onTap: () {
                                        // Navigate to the subcategory detail page
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                SubcategoryDetailPage(
                                              image: subcategory["image_path"],
                                              subcatname:
                                                  subcategory["subcatname"],
                                              price: subcategory["price"],
                                              description: subcategory["desc"],
                                            ),
                                          ),
                                        );
                                      },
                                      child: Card(
                                        child: Column(
                                          children: <Widget>[
                                            Image.network(
                                              subcategory["image_path"],
                                              width: 100,
                                              height: 100,
                                            ),
                                            Text(subcategory["subcatname"]),
                                            Text(
                                                'Price: \$${subcategory["price"]}'),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    : Text(
                        'No data available'), // Show a message if no data is available
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
                  builder: (context) =>
                      PaymentPage(bottomNavigationKey: bottomNavigationKey)),
            );
          }
        },
        key: bottomNavigationKey, // Pass the key
      ),
    );
  }
}
