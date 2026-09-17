import 'package:flutter/material.dart';

import '../state/dineout_state.dart';

class DineoutHeader extends StatelessWidget {
  final DineoutHeaderState state;

  const DineoutHeader({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeInOut,
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 8,
        left: 16,
        right: 16,
        bottom: 8,
      ),
      color: Colors.white.withValues(alpha: state.opacity),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (state.showAddress)
            Row(
              children: [
                const Icon(Icons.work, color: Colors.orange),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    "Tatvasoft house, rajpath club road...",
                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const CircleAvatar(
                  radius: 16,
                  child: Icon(Icons.person, size: 18),
                ),
              ],
            ),
          const SizedBox(height: 8),
          TextField(
            decoration: InputDecoration(
              hintText: "Search for Localities",
              prefixIcon: const Icon(Icons.search),
              filled: true,
              fillColor: Colors.grey.shade100,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
