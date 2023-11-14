import 'package:database_flutter/payment_page.dart';
import 'package:database_flutter/signOut.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'homepage.dart';
import 'subcategory_detail_page.dart';
import 'add_to_cart.dart';

class CategoryDetailPage extends StatefulWidget {
  final String categoryId;
  final String CategorysName;
  CategoryDetailPage({
    required this.categoryId,
    required this.CategorysName,
  });

  @override
  _CategoryDetailPageState createState() => _CategoryDetailPageState();
}

class _CategoryDetailPageState extends State<CategoryDetailPage> {
  final CartModel cart = CartModel();
  Map<String, dynamic> finalResult = {};
  bool isLoading = true;

  void _onTap(int index) {
    if (index == 0) {
      // Navigate to MyHomePage when "Home" is tapped
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MyHomePage()),
      );
    } else if (index == 1) {
      // Navigate to CartPage when "Cart" is tapped
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CartPage(),
        ),
      );
    } else if (index == 2) {
      // Navigate to PaymentPage when "Payment" is tapped
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PaymentPage(
              // Pass the key here
              ),
        ),
      );
    } else if (index == 3) {
      // Navigate to ProfilePage when "Profile" is tapped
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProfilePage(),
        ),
      );
    }
  }

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
      final result = jsonData["finalresult"];

      setState(() {
        finalResult = result;
        isLoading = false;
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.CategorysName}'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: isLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : finalResult.isNotEmpty
                    ? SingleChildScrollView(
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
                                      finalResult["related_subcatslist"][index];
                                  final price = subcategory["price"];

                                  if (price != null) {
                                    return GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                SubcategoryDetailPage(
                                              image: subcategory["image_path"],
                                              subcatname:
                                                  subcategory["subcatname"],
                                              price: price,
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
                                            Text('Price: \$${price}'),
                                          ],
                                        ),
                                      ),
                                    );
                                  }
                                  return Container();
                                },
                                // ignore: unnecessary_null_comparison
                              ).where((widget) => widget != null).toList(),
                            )
                          ],
                        ),
                      )
                    : Center(
                        child: Text('No data available'),
                      ),
          ),
        ],
      ),
    );
  }
}
