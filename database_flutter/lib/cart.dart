class CartItem {
  final String name;
  final double price;
  int quantity;
  final String image; // Add an 'image' field for storing the image URL

  CartItem({
    required this.name,
    required this.price,
    required this.quantity,
    required this.image, // Include 'image' in the constructor
  });
}

class Cart {
  final List<CartItem> items = [];
  final List<CartItem> selectedItems = []; // Add a list for selected items

  void addToCart(String name, double price, String image) {
    // Check if the item is already in the cart
    for (var item in items) {
      if (item.name == name) {
        item.quantity++;
        return;
      }
    }

    // If not, add it to the cart
    final cartItem = CartItem(
      name: name,
      price: price,
      quantity: 1,
      image: image, // Include the image URL
    );
    items.add(cartItem);
    selectedItems.add(cartItem); // Add the item to selected items
  }

  double getTotalPrice() {
    double total = 0;
    for (var item in items) {
      total += item.price * item.quantity;
    }
    return total;
  }
}
