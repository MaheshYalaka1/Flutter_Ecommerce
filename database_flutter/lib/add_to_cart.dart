import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'payment_page.dart';

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Cart Page'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
              child: ListView.builder(
            itemCount: cart.items.length,
            itemBuilder: (context, index) {
              final item = cart.items[index];
              return Card(
                // Wrap ListTile with Card
                elevation:
                    3, // You can adjust the elevation for the shadow effect
                margin: EdgeInsets.all(10), // Add some margin for spacing
                child: ListTile(
                  leading: Image.network(
                    item.image,
                    width: 60,
                    height: 60,
                  ),
                  title: Text(item.name),
                  subtitle: Text(
                    'Price: \$${item.price.toStringAsFixed(2)} | Quantity: ${item.quantity}',
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.remove),
                        onPressed: () {
                          // Remove one item from the cart
                          cart.removeOneFromCart(item);
                        },
                      ),
                      Text(item.quantity.toString()), // Display quantity
                      IconButton(
                        icon: Icon(Icons.add),
                        onPressed: () {
                          // Add one item to the cart
                          cart.addToCart(
                            item.name,
                            item.price,
                            item.image,
                          );
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          )),
          SizedBox(height: 20),
          Text(
            'Total Price: \$${cart.getTotalPrice().toStringAsFixed(2)}',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // Navigate to the payment page when the button is pressed
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PaymentPage(),
                ),
              );
            },
            child: Text('Continue to Payment'),
          ),
        ],
      ),
    );
  }
}

class CartModel extends ChangeNotifier {
  final List<CartItem> items = [];

  void addToCart(String name, double price, String image) {
    for (var item in items) {
      if (item.name == name) {
        item.quantity++;
        notifyListeners();
        return;
      }
    }
    items.add(CartItem(
      name: name,
      price: price,
      quantity: 1,
      image: image,
    ));
    notifyListeners();
  }

  void removeOneFromCart(CartItem item) {
    if (item.quantity > 1) {
      item.quantity--;
    } else {
      items.remove(item);
    }
    notifyListeners();
  }

  double getTotalPrice() {
    double total = 0;
    for (var item in items) {
      total += item.price * item.quantity;
    }
    return total;
  }

  void removeFromCart(CartItem item) {
    items.remove(item);
    notifyListeners();
  }
}

class CartItem {
  final String name;
  final double price;
  int quantity;
  final String image;

  CartItem({
    required this.name,
    required this.price,
    required this.quantity,
    required this.image,
  });
}
