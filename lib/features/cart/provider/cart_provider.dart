import 'package:flutter_riverpod/flutter_riverpod.dart';

class CartItem {
  final int id;
  final String foodName;
  final String restautantName;
  final String image;
  final double price;
  int quantity;

  CartItem({
    required this.id,
    required this.foodName,
    required this.restautantName,
    required this.image,
    required this.price,
    this.quantity = 1,
  });

  double get total => price * quantity;

  CartItem copyWith({int? quantity}) =>
      CartItem(id: id, foodName: foodName, restautantName:restautantName, image: image, price: price, quantity: quantity ?? this.quantity);
}

class CartNotifier extends StateNotifier<List<CartItem>> {
  CartNotifier() : super([]);

  void addToCart(CartItem item) {
    final index = state.indexWhere((i) => i.id == item.id);
    if (index >= 0) {
      final updated = [...state];
      updated[index] = updated[index].copyWith(quantity: updated[index].quantity + 1);
      state = updated;
    } else {
      state = [...state, item];
    }
  }

  void removeFromCart(int id) {
    final index = state.indexWhere((i) => i.id == id);
    if (index >= 0) {
      final updated = [...state];
      if (updated[index].quantity > 1) {
        updated[index] = updated[index].copyWith(quantity: updated[index].quantity - 1);
      } else {
        updated.removeAt(index);
      }
      state = updated;
    }
  }

  int totalQuantity() => state.fold(0, (sum, item) => sum + item.quantity);
  double totalPrice() => state.fold(0.0, (sum, item) => sum + item.total);
}

final cartProvider = StateNotifierProvider<CartNotifier, List<CartItem>>((ref) => CartNotifier());
