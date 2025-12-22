import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:readmore/readmore.dart';
import 'package:yumly/core/utils/Fonts.dart';
import 'package:yumly/core/widgets/CustomImage.dart';
import 'package:yumly/core/widgets/CustomText.dart';

import '../../../core/utils/Colors.dart';
import '../../../core/utils/Images.dart';
//
// class MenuCard extends StatelessWidget {
//   final String image;
//   final String? name;
//   final String? description;
//   final String vendorName;
//   final String? location;
//   final String rating;
//   final String deliveryTime;
//   final String? badgeText;
//   final String? price;
//   final String? categories;
//   final String? oldPrice;
//   final String? newPrice;
//   final int? quantity;
//
//   const MenuCard({
//     super.key,
//     required this.image,
//     this.name,
//     this.description,
//     this.vendorName = '',
//     this.location,
//     required this.rating,
//     required this.deliveryTime,
//     this.badgeText,
//     this.price = '',
//     this.categories,
//     this.oldPrice,
//     this.newPrice,
//     this.quantity,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
//       decoration: BoxDecoration(
//         color: AppColors.white,
//         borderRadius: BorderRadius.all(Radius.circular(12.w)),
//         boxShadow: [
//           BoxShadow(
//             color: AppColors.lightGrey,
//             offset: Offset(0, 2),
//             blurRadius: 10,
//             spreadRadius: 2,
//           ),
//         ],
//       ),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Expanded(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.start,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 CustomImage(source: Images.veg, height: 24.h, width: 24.w),
//                 SizedBox(height: 4.h),
//                 CustomText(name!, fontSize: 16.sp, fontWeight: Fonts.bold),
//                 SizedBox(height: 4.h),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     if (oldPrice != '')
//                       CustomText(
//                         "₹$oldPrice",
//                         color: oldPrice == ''
//                             ? AppColors.black
//                             : AppColors.mediumGrey,
//                         decoration: oldPrice != ''
//                             ? TextDecoration.lineThrough
//                             : TextDecoration.none,
//                       ),
//                     if (oldPrice != '') SizedBox(height: 4.h),
//
//                     Container(
//                       padding: oldPrice == ''
//                           ? null
//                           : EdgeInsets.symmetric(
//                               horizontal: 6.w,
//                               vertical: 2.h,
//                             ),
//                       decoration: oldPrice == ''
//                           ? null
//                           : BoxDecoration(
//                               color: Colors.orange,
//                               borderRadius: BorderRadius.circular(4.w),
//                             ),
//                       child: CustomText(
//                         "₹$newPrice",
//                         fontSize: 16.sp,
//                         fontWeight: Fonts.bold,
//                         color: AppColors.blackSecondary,
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 4.h),
//                 ReadMoreText(
//                   description!,
//                   trimMode: TrimMode.Line,
//                   trimLines: 3,
//                   colorClickableText: Colors.pink,
//                   trimCollapsedText: 'Show more',
//                   trimExpandedText: 'Show less',
//                   moreStyle: TextStyle(fontSize: 12, fontWeight: Fonts.bold),
//                 ),
//               ],
//             ),
//           ),
//           SizedBox(width: 8.w),
//
//           Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Stack(
//                 alignment: Alignment.bottomCenter,
//                 children: [
//                   Column(
//                     children: [
//                       Container(
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(16.w),
//                           border: Border.all(color: AppColors.lightGrey),
//                         ),
//                         child: CustomImage(
//                           source: image,
//                           borderRadius: BorderRadius.circular(16.w),
//                           isNetwork: true,
//                           height: 130.h,
//                           width: 130.w,
//                           fit: BoxFit.cover,
//                           // errorBuilder: (context, error, stackTrace) {
//                           //   return Icon(Icons.broken_image, size: 100.w);
//                           // },
//                         ),
//                       ),
//                       SizedBox(height: 15.h),
//                     ],
//                   ),
//                   Container(
//                     alignment: Alignment.center,
//                     padding: EdgeInsets.symmetric(
//                       horizontal: 8.w,
//                       vertical: 6.h,
//                     ),
//                     decoration: BoxDecoration(
//                       color: AppColors.lightGreen,
//                       border: Border.all(color: AppColors.green),
//                       borderRadius: BorderRadius.circular(8.w),
//                     ),
//                     child: Row(
//                       mainAxisAlignment: quantity == 0
//                           ? MainAxisAlignment.center
//                           : MainAxisAlignment.spaceBetween,
//                       children: [
//                         ?quantity == 0
//                             ? null
//                             : CustomImage(
//                                 source: Images.minus,
//                                 height: 22.h,
//                                 width: 22.w,
//                                 color: AppColors.green,
//                               ),
//
//                         Padding(
//                           padding: EdgeInsets.symmetric(horizontal: 15.w),
//                           child: CustomText(
//                             quantity == 0 ? "Add" : quantity.toString(),
//
//                             fontSize: 18.sp,
//                             fontWeight: Fonts.bold,
//                             color: AppColors.green,
//                           ),
//                         ),
//                         ?quantity == 0
//                             ? null
//                             : CustomImage(
//                                 source: Images.add,
//                                 height: 22.h,
//                                 width: 22.w,
//                                 color: AppColors.green,
//                               ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(height: 2.h),
//               CustomText(
//                 "Customisable",
//                 fontWeight: Fonts.bold,
//                 color: AppColors.textSecondary,
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
class MenuCard extends StatelessWidget {
  final String image;
  final String? name;
  final String? description;
  final String vendorName;
  final String? location;
  final String rating;
  final String deliveryTime;
  final String? badgeText;
  final String? price;
  final String? categories;
  final String? oldPrice;
  final String? newPrice;
  final int quantity;

  /// 👉 Callbacks to update cart
  final VoidCallback onAdd;       // For tapping ADD or +
  final VoidCallback onRemove;    // For tapping –

  const MenuCard({
    super.key,
    required this.image,
    this.name,
    this.description,
    this.vendorName = '',
    this.location,
    required this.rating,
    required this.deliveryTime,
    this.badgeText,
    this.price,
    this.categories,
    this.oldPrice,
    this.newPrice,
    this.quantity = 0,
    required this.onAdd,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12.w),
        boxShadow: [
          BoxShadow(
            color: AppColors.lightGrey,
            offset: const Offset(0, 2),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// ----- LEFT SIDE -----
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomImage(source: Images.veg, height: 24.h, width: 24.w),
                SizedBox(height: 4.h),
                CustomText(name ?? '', fontSize: 16.sp, fontWeight: Fonts.bold),
                SizedBox(height: 4.h),
                if (oldPrice != null && oldPrice!.isNotEmpty) ...[
                  CustomText(
                    "₹$oldPrice",
                    color: AppColors.mediumGrey,
                    decoration: TextDecoration.lineThrough,
                  ),
                  SizedBox(height: 4.h),
                ],
                if (newPrice != null && newPrice!.isNotEmpty)
                  Container(
                    padding:
                    EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                    decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.circular(4.w),
                    ),
                    child: CustomText(
                      "₹$newPrice",
                      fontSize: 16.sp,
                      fontWeight: Fonts.bold,
                      color: AppColors.blackSecondary,
                    ),
                  ),
                SizedBox(height: 4.h),
                if (description != null && description!.isNotEmpty)
                  ReadMoreText(
                    description!,
                    trimMode: TrimMode.Line,
                    trimLines: 3,
                    colorClickableText: Colors.pink,
                    trimCollapsedText: 'Show more',
                    trimExpandedText: 'Show less',
                    moreStyle:
                    TextStyle(fontSize: 12.sp, fontWeight: Fonts.bold),
                  ),
              ],
            ),
          ),
          SizedBox(width: 8.w),

          /// ----- RIGHT SIDE -----
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.w),
                          border: Border.all(color: AppColors.lightGrey),
                        ),
                        child: CustomImage(
                          source: image,
                          borderRadius: BorderRadius.circular(16.w),
                          isNetwork: true,
                          height: 130.h,
                          width: 130.w,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(height: 15.h),
                    ],
                  ),
                  Container(
                    alignment: Alignment.center,
                    padding:
                    EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
                    decoration: BoxDecoration(
                      color: AppColors.lightGreen,
                      border: Border.all(color: AppColors.green),
                      borderRadius: BorderRadius.circular(8.w),
                    ),
                    child: Row(
                      mainAxisAlignment: quantity == 0
                          ? MainAxisAlignment.center
                          : MainAxisAlignment.spaceBetween,
                      children: [
                        // ---- MINUS BUTTON ----
                        if (quantity > 0)
                          GestureDetector(
                            onTap: onRemove,
                            child: CustomImage(
                              source: Images.minus,
                              height: 22.h,
                              width: 22.w,
                              color: AppColors.green,
                            ),
                          ),

                        // ---- ADD TEXT OR QUANTITY ----
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15.w),
                          child: GestureDetector(
                            onTap: onAdd, // tapping ADD when quantity == 0
                            child: CustomText(
                              quantity == 0 ? "Add" : quantity.toString(),
                              fontSize: 18.sp,
                              fontWeight: Fonts.bold,
                              color: AppColors.green,
                            ),
                          ),
                        ),

                        // ---- PLUS BUTTON ----
                        if (quantity > 0)
                          GestureDetector(
                            onTap: onAdd,
                            child: CustomImage(
                              source: Images.add,
                              height: 22.h,
                              width: 22.w,
                              color: AppColors.green,
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 2.h),
              CustomText(
                "Customisable",
                fontWeight: Fonts.bold,
                color: AppColors.textSecondary,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
