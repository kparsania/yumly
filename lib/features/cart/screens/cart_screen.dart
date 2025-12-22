import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/utils/Colors.dart';
import '../../../core/widgets/CustomText.dart';
import '../provider/cart_provider.dart';

class CartScreen extends ConsumerWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cart = ref.watch(cartProvider);
    final notifier = ref.read(cartProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Cart'),
        backgroundColor: AppColors.primary,
      ),
      body: cart.isEmpty
          ? const Center(child: Text('Your cart is empty'))
          : ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: cart.length,
        separatorBuilder: (_, __) => const Divider(),
        itemBuilder: (context, index) {
          final item = cart[index];
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: Text(item.foodName)),
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.remove),
                    onPressed: () => notifier.removeFromCart(item.id),
                  ),
                  Text('${item.quantity}'),
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () => notifier.addToCart(item),
                  ),
                ],
              ),
              Text('₹${item.total.toStringAsFixed(2)}'),
            ],
          );
        },
      ),
      bottomNavigationBar: cart.isEmpty
          ? null
          : Container(
        padding: const EdgeInsets.all(16),
        color: AppColors.lightGrey,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomText('Total: ₹${ref.read(cartProvider.notifier).totalPrice().toStringAsFixed(2)}'),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary),
              child: const Text('Checkout'),
            ),
          ],
        ),
      ),
    );
  }
}
