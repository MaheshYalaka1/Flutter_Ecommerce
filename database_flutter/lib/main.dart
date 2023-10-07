import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'product.dart';
import 'subcategory_detail_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(), // Pass the cart instance here
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Map<String, dynamic>> allTimeGreatGiftsList = [];
  List<Map<String, dynamic>> allCategoriesList = [];
  List<Map<String, dynamic>> homePageProducts1 = [];
  List<Map<String, dynamic>> homePageProducts = [];
  List<Map<String, dynamic>> seasonsspeciallist = [];

  @override
  void initState() {
    super.initState();
    fetchJsonData();
  }

  Future<void> fetchJsonData() async {
    final url = Uri.parse("http://iphone.us2guntur.com/AlltypeCategoriesList");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      setState(() {
        allTimeGreatGiftsList = List.from(jsonData["Alltimegreatgiftslist"]);
        allCategoriesList = List.from(jsonData["Allcategories list"]);
        homePageProducts1 = List.from(jsonData["HomePageProducts1"]);
        homePageProducts = List.from(jsonData["HomePageProducts"]);
        seasonsspeciallist = List.from(jsonData["seasonsspeciallist"]);
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  void navigateToSubcategoryDetail() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SubcategoryDetailPage(
          image: 'your_image_url_here',
          subcatname: 'Product Name',
          price: 'Product Price',
          description: 'Product Description',
          // Pass the ShoppingCart instance
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Images and Names from JSON URL'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            // All Time Great Gifts List
            AppBar(
              title: Text('All Time Great Gifts List'),
            ),
            SizedBox(height: 10),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: allTimeGreatGiftsList.length,
              itemBuilder: (context, index) {
                final item = allTimeGreatGiftsList[index];
                return GestureDetector(
                  onTap: () {
                    // Navigate to the new page and pass the category ID
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            CategoryDetailPage(categoryId: item['category_id']),
                      ),
                    );
                  },
                  child: ListTile(
                    leading: Image.network(item['imagepath']),
                    title: Text(item['categoryname']),
                    subtitle: Text(item['category_id']),
                  ),
                );
              },
            ),

            // Home Page Products 1
            AppBar(
              title: Text('Home Page Products 1'),
            ),
            SizedBox(height: 10),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: homePageProducts1.length,
              itemBuilder: (context, index) {
                final item = homePageProducts1[index];
                return GestureDetector(
                  onTap: () {
                    // Navigate to the new page and pass the category ID
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            CategoryDetailPage(categoryId: item['category_id']),
                      ),
                    );
                  },
                  child: ListTile(
                    leading: Image.network(item['imagepath']),
                    title: Text(item['categoryname']),
                    subtitle: Text(item['category_id']),
                  ),
                );
              },
            ),

            // Home Page Products
            AppBar(
              title: Text('Home Page Products'),
            ),
            SizedBox(height: 10),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: homePageProducts.length,
              itemBuilder: (context, index) {
                final item = allTimeGreatGiftsList[index];
                return GestureDetector(
                  onTap: () {
                    // Navigate to the new page and pass the category ID
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            CategoryDetailPage(categoryId: item['category_id']),
                      ),
                    );
                  },
                  child: ListTile(
                    leading: Image.network(item['imagepath']),
                    title: Text(item['categoryname']),
                    subtitle: Text(item['category_id']),
                  ),
                );
              },
            ),

            // All Categories List
            AppBar(
              title: Text('All Categories List'),
            ),
            SizedBox(height: 10),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: allCategoriesList.length,
              itemBuilder: (context, index) {
                final item = allCategoriesList[index];
                return GestureDetector(
                  onTap: () {
                    // Navigate to the new page and pass the category ID
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            CategoryDetailPage(categoryId: item['category_id']),
                      ),
                    );
                  },
                  child: ListTile(
                    leading: Image.network(item['imagepath']),
                    title: Text(item['categoryname']),
                    subtitle: Text(item['category_id']),
                  ),
                );
              },
            ),

            // Seasons Special List
            AppBar(
              title: Text('Seasons Special List'),
            ),
            SizedBox(height: 10),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: seasonsspeciallist.length,
              itemBuilder: (context, index) {
                final item = seasonsspeciallist[index];
                return GestureDetector(
                  onTap: () {
                    // Navigate to the new page and pass the category ID
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            CategoryDetailPage(categoryId: item['category_id']),
                      ),
                    );
                  },
                  child: ListTile(
                    leading: Image.network(item['imagepath']),
                    title: Text(item['categoryname']),
                    subtitle: Text(item['category_id']),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
