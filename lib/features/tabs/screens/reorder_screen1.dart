import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yumly/core/utils/Colors.dart';
import 'package:yumly/core/widgets/CustomImage.dart';

import '../../../core/utils/Fonts.dart';
import '../../../core/utils/Images.dart';
import '../../../core/widgets/CustomSearchBar.dart';
import '../../../core/widgets/CustomText.dart';
import '../provider/reorder_provider.dart';

class ReorderScreen extends ConsumerWidget {
  const ReorderScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(reorderProvider);
    final notifier = ref.read(reorderProvider.notifier);

    return Scaffold(
      body: CustomScrollView(
        scrollDirection: Axis.vertical,
        slivers: [
          SliverAppBar(
            toolbarHeight: 50.h,
            backgroundColor: AppColors.primary,
            foregroundColor: AppColors.primary,
            title: CustomText(
              "Reorder",
              fontSize: 24.sp,
              fontWeight: Fonts.medium,
              color: AppColors.white,
            ),
            centerTitle: true,
          ),
          SliverAppBar(
            // pinned: true,
            expandedHeight: 70.h,
            toolbarHeight: 70.h,
            flexibleSpace: FlexibleSpaceBar(
              background: Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(
                      left: 16.w,
                      right: 16.w,
                      top: 10.h,
                      bottom: 30.h,
                    ),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppColors.primary,
                          AppColors.primary,
                          AppColors.primary,
                          AppColors.white,
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                    child: CustomSearchBar(
                      placeholderTexts: ["Search by restaurant or dish"],
                      showLeftIcon: false,
                      rightIcon2: Images.search,
                      rightIcon2Color: AppColors.mediumGrey,
                      rightIcon1Color: AppColors.primary,
                      rightIcon1: Images.microphone,
                      decoration: BoxDecoration(
                        color: AppColors.lightGrey,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(12),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 40.h,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: const [
                  FilterChip(label: Text('Favourites'), onSelected: null),
                  SizedBox(width: 8),
                  FilterChip(label: Text('Price 149 - 300'), onSelected: null),
                  SizedBox(width: 8),
                  FilterChip(label: Text('Price > 300'), onSelected: null),
                ],
              ),
            ),
          ),
          SliverFillRemaining()
        ],
      ),
      // appBar: AppBar(
      //   elevation: 0,
      //   title: CustomText("Reorder", fontSize: 24.sp, fontWeight: Fonts.medium),
      //   centerTitle: true,
      // ),
      // backgroundColor: AppColors.backgroundGrey,
      // body: Column(
      //   children: [
      //     Padding(
      //       padding: const EdgeInsets.all(16.0),
      //       child: CustomSearchBar(
      //         key: const ValueKey("headerSearch"),
      //         placeholderTexts: ["Search by restaurant or dish"],
      //         rightIcon1: Images.search,
      //         showLeftIcon: false,
      //         showRightVerticalDivider: false,
      //         rightIcon1Color: AppColors.primary,
      //         decoration: BoxDecoration(
      //           color: AppColors.white,
      //           borderRadius: const BorderRadius.all(Radius.circular(12)),
      //         ),
      //         onTap: () {
      //           // context.pop();
      //         },
      //       ),
      //     ),
      //     // Filter chips
      //     SizedBox(
      //       height: 40,
      //       child: ListView(
      //         scrollDirection: Axis.horizontal,
      //         padding: const EdgeInsets.symmetric(horizontal: 16),
      //         children: const [
      //           FilterChip(label: Text('Favourites'), onSelected: null),
      //           SizedBox(width: 8),
      //           FilterChip(label: Text('Price 149 - 300'), onSelected: null),
      //           SizedBox(width: 8),
      //           FilterChip(label: Text('Price > 300'), onSelected: null),
      //         ],
      //       ),
      //     ),
      //     const SizedBox(height: 8),
      //     // Restaurant list
      //     Expanded(
      //       child: ListView.builder(
      //         itemCount: state.reorderRestaurants!.length,
      //         padding: const EdgeInsets.symmetric(horizontal: 16),
      //         itemBuilder: (context, index) {
      //           final r = state.reorderRestaurants![index];
      //           return Card(
      //             shape: RoundedRectangleBorder(
      //               borderRadius: BorderRadius.circular(16),
      //             ),
      //             margin: const EdgeInsets.only(bottom: 16),
      //             child: Padding(
      //               padding: const EdgeInsets.all(12),
      //               child: Column(
      //                 crossAxisAlignment: CrossAxisAlignment.start,
      //                 children: [
      //                   // Header with image, name, time and favorite button
      //                   Row(
      //                     crossAxisAlignment: CrossAxisAlignment.start,
      //                     children: [
      //                       ClipRRect(
      //                         borderRadius: BorderRadius.circular(8),
      //                         child: CustomImage(
      //                           source: r['image'],
      //                           isNetwork: true,
      //                           width: 60,
      //                           height: 60,
      //                           fit: BoxFit.cover,
      //                         ),
      //                       ),
      //                       const SizedBox(width: 10),
      //                       Expanded(
      //                         child: Column(
      //                           crossAxisAlignment: CrossAxisAlignment.start,
      //                           children: [
      //                             Text(
      //                               r['restaurantName'],
      //                               style: const TextStyle(
      //                                 fontWeight: FontWeight.bold,
      //                               ),
      //                             ),
      //                             Text(
      //                               r['time'],
      //                               style: const TextStyle(color: Colors.grey),
      //                             ),
      //                             Text(
      //                               r['benefits'],
      //                               style: const TextStyle(
      //                                 fontSize: 12,
      //                                 color: Colors.grey,
      //                               ),
      //                             ),
      //                           ],
      //                         ),
      //                       ),
      //                       IconButton(
      //                         icon: Icon(
      //                           r['isFavourite']
      //                               ? Icons.favorite
      //                               : Icons.favorite_border,
      //                           color: r['isFavourite']
      //                               ? Colors.red
      //                               : Colors.grey,
      //                         ),
      //                         onPressed: () => {
      //                           // notifier.toggleFavorite(index)
      //                         },
      //                       ),
      //                     ],
      //                   ),
      //                   const Divider(),
      //                   // Dishes list
      //                   ...r['items'].map(
      //                     (dish) => Padding(
      //                       padding: const EdgeInsets.symmetric(vertical: 4),
      //                       child: Row(
      //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //                         children: [
      //                           Expanded(
      //                             child: Column(
      //                               crossAxisAlignment:
      //                                   CrossAxisAlignment.start,
      //                               children: [
      //                                 Text(dish['name']),
      //                                 Row(
      //                                   children: [
      //                                     Text(
      //                                       '₹${dish['price'].toStringAsFixed(0)}',
      //                                       style: const TextStyle(
      //                                         fontWeight: FontWeight.bold,
      //                                       ),
      //                                     ),
      //                                     if (dish['originalPrice'] !=
      //                                         null) ...[
      //                                       const SizedBox(width: 5),
      //                                       Text(
      //                                         '₹${dish['originalPrice']}',
      //                                         style: const TextStyle(
      //                                           decoration:
      //                                               TextDecoration.lineThrough,
      //                                           color: Colors.grey,
      //                                         ),
      //                                       ),
      //                                     ],
      //                                   ],
      //                                 ),
      //                               ],
      //                             ),
      //                           ),
      //                           ElevatedButton(
      //                             style: ElevatedButton.styleFrom(
      //                               shape: const CircleBorder(),
      //                               backgroundColor: Colors.grey[200],
      //                               padding: const EdgeInsets.all(8),
      //                             ),
      //                             onPressed: () {},
      //                             child: const Icon(
      //                               Icons.add,
      //                               color: Colors.black,
      //                             ),
      //                           ),
      //                         ],
      //                       ),
      //                     ),
      //                   ),
      //                 ],
      //               ),
      //             ),
      //           );
      //         },
      //       ),
      //     ),
      //   ],
      // ),
    );
  }
}
