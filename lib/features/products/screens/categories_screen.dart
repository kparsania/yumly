import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:yumly/core/route/screenNames.dart';
import 'package:yumly/core/utils/Images.dart';
import 'package:yumly/features/tabs/data/restaurant_catalog.dart';

import '../../../../core/widgets/CustomHeader.dart';
import '../providers/categories_provider.dart';
import '../widgets/categories_item.dart';

class CategoriesScreen extends ConsumerWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(categoriesProvider);
    final notifier = ref.read(categoriesProvider.notifier);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              CustomHeader(
                title: 'Restaurant',
                backgroundColor: Colors.white,
                iconColor: Colors.black,
                rightIcon1: Images.search,
                onRightIcon1Tap: () => context.pushNamed(
                  ScreenNames.RESTAURANT_LIST,
                  extra: {
                    'title': 'Search',
                    'items': dashboardRestaurants(),
                  },
                ),
              ),
              state.isLoading
                  ? CircularProgressIndicator()
                  : GridView.builder(
                      padding: const EdgeInsets.all(16),
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.8,
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 16,
                          ),
                      itemCount: state.categoriesList.length,
                      itemBuilder: (context, index) {
                        final item = state.categoriesList[index];
                        return GestureDetector(
                          onTap: () => context.pushNamed(
                            ScreenNames.RESTAURANT_LIST,
                            extra: {
                              'title': item['title'],
                              'items': restaurantsForCategory(
                                '${item['title']}',
                              ),
                            },
                          ),
                          child: CategoriesItem(
                            imagePath: item['image'],
                            title: item['title'],
                            subtitle: item['subtitle'],
                          ),
                        );
                      },
                    ),
            ],
          ),
        ),
      ),
    );
  }
}

class DashboardCategoryList {
  const DashboardCategoryList();
}
