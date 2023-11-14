import 'package:database_flutter/add_to_cart.dart';
import 'package:database_flutter/homepage.dart';
import 'package:database_flutter/payment_page.dart';
import 'package:database_flutter/signOut.dart';
import 'package:flutter/material.dart';

class TabScreen extends StatefulWidget {
  @override
  State<TabScreen> createState() {
    return _TabScreenState();
  }
}

class _TabScreenState extends State<TabScreen> {
  int _currentIndex = 0;

  void _selectedpage(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget activePage = MyHomePage();

    if (_currentIndex == 1) {
      activePage = CartPage();
    } else if (_currentIndex == 2) {
      activePage = PaymentPage();
    } else if (_currentIndex == 3) {
      activePage = ProfilePage();
    }

    return Scaffold(
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.lightBlue,
        selectedItemColor:
            Colors.black, // Set the selected icon color to yellow
        unselectedItemColor:
            Colors.blue, // Set the unselected icon color to blue
        showSelectedLabels: true, // Show labels for selected items
        showUnselectedLabels: true, // Show labels for unselected items
        onTap: _selectedpage,
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.payment),
            label: 'Payment',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
