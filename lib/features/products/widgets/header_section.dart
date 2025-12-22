import 'package:flutter/material.dart';

class HeaderSection extends StatelessWidget {
  final String address;
  final IconData? leftIcon;
  final VoidCallback? onLeftIconTap;

  const HeaderSection({
    super.key,
    required this.address,
    this.leftIcon,
    this.onLeftIconTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: onLeftIconTap,
            child: Icon(leftIcon ?? Icons.work, color: Colors.orange, size: 28),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Work",
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                Text(
                  address,
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: Colors.red.shade100,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text(
              "RENEW one",
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
            ),
          ),
          const SizedBox(width: 8),
          const Icon(Icons.person, size: 28),
        ],
      ),
    );
  }
}
