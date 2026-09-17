import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartItem {
  final int id;
  final String foodName;
  final String restautantName;
  final String image;
  final double price;
  int quantity;

  /// Optional long description override (else resolved from edit catalog).
  final String detailDescription;

  /// User cooking request (e.g. “less spicy”) — max length enforced in UI.
  final String cookingNote;

  CartItem({
    required this.id,
    required this.foodName,
    required this.restautantName,
    required this.image,
    required this.price,
    this.quantity = 1,
    this.detailDescription = '',
    this.cookingNote = '',
  });

  double get total => price * quantity;

  CartItem copyWith({
    int? id,
    String? foodName,
    String? restautantName,
    String? image,
    double? price,
    int? quantity,
    String? detailDescription,
    String? cookingNote,
  }) => CartItem(
    id: id ?? this.id,
    foodName: foodName ?? this.foodName,
    restautantName: restautantName ?? this.restautantName,
    image: image ?? this.image,
    price: price ?? this.price,
    quantity: quantity ?? this.quantity,
    detailDescription: detailDescription ?? this.detailDescription,
    cookingNote: cookingNote ?? this.cookingNote,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'foodName': foodName,
    'restautantName': restautantName,
    'image': image,
    'price': price,
    'quantity': quantity,
    'detailDescription': detailDescription,
    'cookingNote': cookingNote,
  };

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      id: (json['id'] as num).toInt(),
      foodName: json['foodName'] as String,
      restautantName: json['restautantName'] as String,
      image: json['image'] as String? ?? '',
      price: (json['price'] as num).toDouble(),
      quantity: (json['quantity'] as num?)?.toInt() ?? 1,
      detailDescription: json['detailDescription'] as String? ?? '',
      cookingNote: json['cookingNote'] as String? ?? '',
    );
  }
}

const _prefsCartKey = 'yumly_cart_items_v1';

class CartNotifier extends StateNotifier<List<CartItem>> {
  CartNotifier() : super([]) {
    _restore();
  }

  Future<void> _restore() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final raw = prefs.getString(_prefsCartKey);
      if (raw == null || raw.isEmpty) return;
      final list = jsonDecode(raw) as List<dynamic>;
      final items = list
          .map((e) => CartItem.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList();
      if (items.isNotEmpty) {
        state = items;
      }
    } catch (_) {
      // Corrupt or old format — start empty
    }
  }

  Future<void> _persist() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      if (state.isEmpty) {
        await prefs.remove(_prefsCartKey);
      } else {
        final encoded = jsonEncode(
          state.map((e) => e.toJson()).toList(growable: false),
        );
        await prefs.setString(_prefsCartKey, encoded);
      }
    } catch (_) {
      // Ignore persistence failures
    }
  }

  void _setAndSave(List<CartItem> next) {
    state = next;
    _persist();
  }

  void addToCart(CartItem item) {
    final index = state.indexWhere((i) => i.id == item.id);
    if (index >= 0) {
      final updated = [...state];
      updated[index] = updated[index].copyWith(
        quantity: updated[index].quantity + 1,
      );
      _setAndSave(updated);
    } else {
      _setAndSave([...state, item]);
    }
  }

  void removeFromCart(int id) {
    final index = state.indexWhere((i) => i.id == id);
    if (index >= 0) {
      final updated = [...state];
      if (updated[index].quantity > 1) {
        updated[index] = updated[index].copyWith(
          quantity: updated[index].quantity - 1,
        );
      } else {
        updated.removeAt(index);
      }
      _setAndSave(updated);
    }
  }

  void clearCart() {
    state = [];
    _persist();
  }

  /// Removes a dish line entirely.
  void removeLineCompletely(int id) {
    _setAndSave([...state]..removeWhere((i) => i.id == id));
  }

  /// Replace a line (e.g. after edit sheet: qty + cooking note).
  void updateCartLine(CartItem updated) {
    final i = state.indexWhere((e) => e.id == updated.id);
    if (i < 0) return;
    final next = [...state];
    next[i] = updated;
    _setAndSave(next);
  }

  int totalQuantity() => state.fold(0, (sum, item) => sum + item.quantity);
  double totalPrice() => state.fold(0.0, (sum, item) => sum + item.total);
}

final cartProvider = StateNotifierProvider<CartNotifier, List<CartItem>>(
  (ref) => CartNotifier(),
);
