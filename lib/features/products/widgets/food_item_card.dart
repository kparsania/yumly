// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:yumly/core/utils/Images.dart';
// import 'package:yumly/core/widgets/CustomText.dart';
//
// class FoodItemCard extends StatelessWidget {
//   final VoidCallback? onAdd;
//   final VoidCallback? onRemove;
//   final String? image;
//   final String? rating;
//   final String? name;
//   final String? location;
//   final String? price;
//   final String? time;
//   final int? quantity;
//
//   const FoodItemCard({
//     super.key,
//     this.onAdd,
//     this.onRemove,
//     this.image,
//     this.rating = "",
//     this.name = "",
//     this.location = "",
//     this.price = "",
//     this.time = "",
//     this.quantity = 0,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         Card(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(12),
//           ),
//           elevation: 3,
//           // margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
//           child: Container(
//             // padding: const EdgeInsets.all(10),
//             child: Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // Image
//                 ClipRRect(
//                   borderRadius: BorderRadius.circular(10),
//                   child: Image.network(
//                     image!,
//                     // item.imageUrl,
//                     // height: ,
//                     width: 80,
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//                 const SizedBox(width: 12),
//
//                 // Details
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     CustomText(
//                       name!,
//                       fontSize: 16.sp,
//                       fontWeight: FontWeight.bold,
//                     ),
//                     SizedBox(height: 4.h),
//                     CustomText(
//                       location!,
//                       fontSize: 12.sp,
//                       color: Colors.grey[600],
//                     ),
//                     SizedBox(height: 6.h),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         CustomText("\$ $price", fontWeight: FontWeight.bold),
//                         Row(
//                           children: [
//                             Icon(
//                               Icons.timer,
//                               size: 14,
//                               color: Colors.grey[600],
//                             ),
//                             const SizedBox(width: 3),
//                             Text(
//                               "$time Min",
//                               style: TextStyle(
//                                 fontSize: 12,
//                                 color: Colors.grey[600],
//                               ),
//                             ),
//                           ],
//                         ),
//                         Row(
//                           children: [
//                             Icon(
//                               Icons.star,
//                               size: 14,
//                               color: Colors.orangeAccent,
//                             ),
//                             const SizedBox(width: 3),
//                             Text(rating!, style: const TextStyle(fontSize: 12)),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//
//                 // Quantity Controls
//               ],
//             ),
//           ),
//         ),
//         Container(
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(20),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black12,
//                 blurRadius: 4,
//                 offset: Offset(0, 2),
//               ),
//             ],
//           ),
//           child: Row(
//             children: [
//               IconButton(
//                 icon: const Icon(Icons.remove, color: Colors.green, size: 18),
//                 onPressed: onRemove,
//               ),
//               Text(
//                 quantity.toString(),
//                 style: const TextStyle(fontWeight: FontWeight.bold),
//               ),
//               IconButton(
//                 icon: const Icon(Icons.add, color: Colors.green, size: 18),
//                 onPressed: onAdd,
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }
