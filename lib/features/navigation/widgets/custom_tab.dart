import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../controllers/custom_tab_controller.dart';

class MainTabBar extends ConsumerWidget {
  final List<IconData> icons;
  final List<String> screenName;
  final ValueChanged<int> onTabSelected;

  const MainTabBar({
    super.key,
    required this.icons,
    required this.screenName,
    required this.onTabSelected,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final visible = ref.watch(tabBarVisibilityProvider);
    final currentIndex = ref.watch(currentTabIndexProvider);

    return AnimatedSlide(
      duration: const Duration(milliseconds: 300),
      offset: visible ? Offset.zero : const Offset(0, 1),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 6)],
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: icons.asMap().entries.map((entry) {
            final index = entry.key;
            final icon = entry.value;
            final isActive = index == currentIndex;
            return Container(
              // color: AppColors.yellow,
              padding: const EdgeInsets.only(bottom: 18.0,top: 4),
              child: GestureDetector(
                onTap: () {
                  ref.read(currentTabIndexProvider.notifier).state = index;
                  onTabSelected(index);
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(icon, color: isActive ? Colors.blue : Colors.grey),
                    Text(
                      screenName[index],
                      style: TextStyle(
                        fontSize: 12,
                        color: isActive ? Colors.blue : Colors.grey,
                        fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
                      ),
                    ),
                  ],
                ),

              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
