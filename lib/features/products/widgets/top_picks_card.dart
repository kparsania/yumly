// import 'package:flutter/material.dart';
//
// class TopPicksCard extends StatelessWidget {
//   const TopPicksCard({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 180,
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12),
//         boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4)],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Stack(
//             children: [
//               ClipRRect(
//                 borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
//                 child: Image.network(
//                   'https://popmenucloud.com/cdn-cgi/image/width%3D600%2Cheight%3D600%2Cfit%3Dscale-down%2Cformat%3Dauto%2Cquality%3D60/vxreqwtp/3f0194ae-8a0b-4b29-814e-0b0c7e5ef5c6.jpg',
//                   height: 110,
//                   width: double.infinity,
//                   fit: BoxFit.cover,
//                 ),
//               ),
//               Positioned(
//                 top: 8,
//                 left: 8,
//                 child: Container(
//                   padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
//                   decoration: BoxDecoration(
//                     color: Colors.brown,
//                     borderRadius: BorderRadius.circular(6),
//                   ),
//                   child: const Text('Free Delivery', style: TextStyle(color: Colors.white, fontSize: 12)),
//                 ),
//               ),
//             ],
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: const [
//                 Text("Zafran Indian Kitchen", style: TextStyle(fontWeight: FontWeight.bold)),
//                 Text("The View Mall", style: TextStyle(color: Colors.grey)),
//                 SizedBox(height: 6),
//                 Row(
//                   children: [
//                     Icon(Icons.star, size: 14, color: Colors.orange),
//                     Text("4.9"),
//                     SizedBox(width: 8),
//                     Text("20 - 30 min"),
//                   ],
//                 )
//               ],
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yumly/core/widgets/CustomImage.dart';
import 'package:yumly/core/widgets/CustomText.dart';

import '../../../core/utils/Colors.dart';
import '../../../core/utils/Images.dart';

class TopPicksCard extends StatelessWidget {
  final String imageUrl;
  final String foodName;
  final String price;

  const TopPicksCard({
    super.key,
    required this.imageUrl,
    this.foodName = '',
    this.price = '',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220.w,
      margin: EdgeInsets.only(bottom: 2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(12)),
                child: CustomImage(
                  isNetwork: true,
                  source: imageUrl,
                  height: 170.h,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                bottom: 0,
                child: CustomImage(
                  source: Images.gradient,
                  borderRadius: BorderRadius.circular(12),
                  height: 180.h,
                  width: 220.w,
                ),
              ),
              Positioned(
                right: 0,
                top: 0,
                child: CustomImage(
                  source: Images.topRightShadow,
                  borderRadius: BorderRadius.circular(10),
                  height: 50.h,
                  width: 50.w,
                  isSvg: true,
                  // borderRadius: BorderRadius.circular(10),
                ),
              ),
              Positioned(
                right: 6.w,
                top: 6.h,
                child: CustomImage(
                  source: Images.heart,
                  isSvg: true,
                  height: 24.h,
                  width: 24.w,
                  color: AppColors.white,
                  // borderRadius: BorderRadius.circular(10),
                ),
              ),
              Positioned(
                bottom: 2,
                left: 8,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomImage(source: Images.veg, height: 20.h, width: 20.w),
                    CustomText(
                      foodName,
                      maxLines: 2,
                      color: AppColors.white,
                      fontSize: 18.sp,
                    ),
                    CustomText(
                      "₹$price",
                      color: AppColors.white,
                      fontSize: 16.sp,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
