
import 'package:flutter/material.dart';
import 'package:yumly/core/utils/Colors.dart';

// class CustomDivider extends StatelessWidget {
//   final Color color;
//   final double height;
//   final EdgeInsetsGeometry? padding;
//   final bool isVertical;
//
//   const CustomDivider({
//     super.key,
//     this.color = AppColors.divider,
//     this.height = 1.0,
//     this.padding,
//     this.isVertical = false,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Transform.rotate(
//       angle: isVertical ? math.pi / 2 : math.pi,
//       child: Padding(
//         padding: padding ?? EdgeInsets.zero,
//         child: Divider(color: color, thickness: height),
//       ),
//     );
//   }
// }

class CustomDivider extends StatelessWidget {
  final Color color;
  final double thickness;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final bool isVertical;

  const CustomDivider({
    super.key,
    this.color = AppColors.divider,
    this.thickness = 1.0,
    this.height,
    this.padding,
    this.isVertical = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: isVertical
          ? Container(
              height: height,
              color: AppColors.divider,
              width: thickness,
            )
          : Divider(color: color, thickness: thickness),
    );
  }
}
