import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:yumly/core/widgets/CustomImage.dart';

import '../../../core/route/screenNames.dart';
import '../../../core/utils/Constants.dart';

class DashboardCategories extends StatelessWidget {
  const DashboardCategories({super.key});

  @override
  Widget build(BuildContext context) {
    final displayList = categories.length > 4
        ? categories.sublist(0, 4)
        : categories;

    return SizedBox(
      height: 90,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: displayList.length + 1, // +1 for the "+" icon
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          if (index < displayList.length) {
            final item = displayList[index];
            return Column(
              children: [
                SizedBox(
                  height: 50,
                  child: CustomImage(
                    source: item['image'],
                    height: 70.0,
                    width: 70.0,
                  ),
                ),
                const SizedBox(height: 6),
                Text(item['title'] as String),
              ],
            );
          } else {
            return GestureDetector(
              onTap: () => context.push(ScreenNames.CATEGORIES),
              child: Column(
                children: [
                  SizedBox(
                    height: 50,
                    child: CircleAvatar(
                      radius: 28,
                      backgroundColor: Colors.orange[100],
                      child: Icon(Icons.add, color: Colors.orange, size: 28),
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text("More"),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
