import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yumly/features/tabs/screens/favourites_screen.dart';
import 'package:yumly/features/tabs/screens/reorder_screen.dart';
import '../../../core/widgets/CustomBottomNavbar.dart';
import '../../tabs/screens/dashboard_screen.dart';
import '../../tabs/screens/dineout_screen.dart';
import '../controllers/custom_tab_controller.dart';

class MainTabScreen extends ConsumerStatefulWidget {
  const MainTabScreen({super.key});

  @override
  ConsumerState<MainTabScreen> createState() => _MainTabScreenState();
}

class _MainTabScreenState extends ConsumerState<MainTabScreen> {
  final scrollController = ScrollController();

  final List<Widget> _pages = [
    DashboardScreen(),
    DineOutScreen(),
    FavoritesScreen(),
    ReorderScreen()
  ];

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if (scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        ref.read(tabBarVisibilityProvider.notifier).state = false;
      } else if (scrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        ref.read(tabBarVisibilityProvider.notifier).state = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentIndex = ref.watch(currentTabIndexProvider);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          NotificationListener<UserScrollNotification>(
            onNotification: (notification) {
              if (notification.direction == ScrollDirection.reverse) {
                ref.read(tabBarVisibilityProvider.notifier).state = false;
              } else if (notification.direction == ScrollDirection.forward) {
                ref.read(tabBarVisibilityProvider.notifier).state = true;
              }
              return true;
            },
            child: _pages[currentIndex],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Consumer(
              builder: (context, ref, _) {
                final isVisible = ref.watch(tabBarVisibilityProvider);

                return AnimatedSlide(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  offset: isVisible ? Offset(0, 0) : Offset(0, 1), // slide down
                  child: AnimatedOpacity(
                    opacity: isVisible ? 1 : 0,
                    duration: const Duration(milliseconds: 300),
                    child: CustomBottomBar(
                      currentIndex: ref.watch(currentTabIndexProvider),
                      onTabSelected: (index) {
                        ref.read(currentTabIndexProvider.notifier).state = index;
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
