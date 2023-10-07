import 'package:flutter/material.dart';

class CartItemsWidget extends StatelessWidget {
  final ShoppingCart cart;

  CartItemsWidget({required this.cart});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text('Cart Items:'),
        for (var item in cart.items)
          ListTile(
            title: Text(item['name']),
            subtitle: Text(item['price']),
          ),
      ],
    );
  }
}

class ShoppingCart {
  List<Map<String, dynamic>> _items = [];

  List<Map<String, dynamic>> get items => _items;

  void addToCart(Map<String, dynamic> product) {
    _items.add(product);
  }

  void removeFromCart(int index) {
    _items.removeAt(index);
  }
}
