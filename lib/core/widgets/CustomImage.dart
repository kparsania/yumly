// // // import 'package:flutter/material.dart';
// // // import 'package:yumly/core/utils/Images.dart';
// // //
// // // class CustomImage extends StatelessWidget {
// // //   final source;
// // //   final bool isNetwork;
// // //   final double width;
// // //   final double height;
// // //   final BoxFit fit;
// // //   final BorderRadius? borderRadius;
// // //   final EdgeInsetsGeometry? margin;
// // //
// // //   const CustomImage({
// // //     super.key,
// // //     required this.source,
// // //     this.isNetwork = false,
// // //     this.width = 30,
// // //     this.height = 30,
// // //     this.fit = BoxFit.cover,
// // //     this.borderRadius,
// // //     this.margin,
// // //   });
// // //
// // //   @override
// // //   Widget build(BuildContext context) {
// // //     final placeholder = Images.noImage;
// // //
// // //     Widget buildImage(String source, {bool fromNetwork = false}) {
// // //       if (fromNetwork) {
// // //         return Image.network(
// // //           source,
// // //           width: width,
// // //           height: height,
// // //           fit: fit,
// // //           errorBuilder: (_, __, ___) =>
// // //               Image.asset(placeholder, width: width, height: height, fit: fit),
// // //         );
// // //       } else {
// // //         return Image.asset(source, width: width, height: height, fit: fit);
// // //       }
// // //     }
// // //
// // //     return Container(
// // //       margin: margin ?? EdgeInsets.zero,
// // //       child: ClipRRect(
// // //         borderRadius: borderRadius ?? BorderRadius.zero,
// // //         child: (source == null || source!.isEmpty)
// // //             ? buildImage(placeholder)
// // //             : buildImage(source!, fromNetwork: isNetwork),
// // //       ),
// // //     );
// // //   }
// // // }
// //
// // import 'package:flutter/material.dart';
// // import 'package:flutter_svg/flutter_svg.dart';
// // import 'package:yumly/core/utils/Images.dart';
// //
// // class CustomImage extends StatelessWidget {
// //   final source;
// //   final bool isNetwork;
// //   final bool isSvg;
// //   final double width;
// //   final double height;
// //   final BoxFit fit;
// //   final BorderRadius? borderRadius;
// //   final EdgeInsetsGeometry? margin;
// //   final dynamic color;
// //
// //   const CustomImage({
// //     super.key,
// //     required this.source,
// //     this.isNetwork = false,
// //     this.isSvg = false,
// //     this.width = 24,
// //     this.height = 24,
// //     this.fit = BoxFit.cover,
// //     this.borderRadius,
// //     this.margin,
// //     this.color,
// //   });
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     final placeholder = Images.noImage;
// //
// //     Widget buildImage(String src, {bool fromNetwork = false}) {
// //       // Handle SVG images
// //       if (isSvg || src.toLowerCase().endsWith('.svg')) {
// //         if (fromNetwork) {
// //           return SvgPicture.network(
// //             src,
// //             width: width,
// //             height: height,
// //             fit: fit,
// //             colorFilter: color,
// //             placeholderBuilder: (_) => Image.asset(
// //               placeholder,
// //               width: width,
// //               height: height,
// //               fit: fit,
// //             ),
// //           );
// //         } else {
// //           return SvgPicture.asset(
// //             src,
// //             width: width,
// //             height: height,
// //             fit: fit,
// //             colorFilter: color,
// //           );
// //         }
// //       }
// //
// //       // Handle normal PNG/JPG images
// //       if (fromNetwork) {
// //         return Image.network(
// //           src,
// //           width: width,
// //           height: height,
// //           fit: fit,
// //           color: color,
// //           errorBuilder: (_, __, ___) =>
// //               Image.asset(placeholder, width: width, height: height, fit: fit),
// //         );
// //       } else {
// //         return Image.asset(
// //           src,
// //           width: width,
// //           height: height,
// //           fit: fit,
// //           color: color,
// //         );
// //       }
// //     }
// //
// //     return Container(
// //       margin: margin ?? EdgeInsets.zero,
// //       child: ClipRRect(
// //         borderRadius: borderRadius ?? BorderRadius.zero,
// //         child: (source == null || source!.isEmpty)
// //             ? buildImage(placeholder)
// //             : buildImage(source!, fromNetwork: isNetwork),
// //       ),
// //     );
// //   }
// // }
//
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:yumly/core/utils/Images.dart';
//
// class CustomImage extends StatelessWidget {
//   final String? source;
//   final bool isNetwork;
//   final bool isSvg;
//   final double width;
//   final double height;
//   final BoxFit fit;
//   final BorderRadius? borderRadius;
//   final EdgeInsetsGeometry? margin;
//   final Color? color;
//   final VoidCallback? onTap;
//   final dynamic? errorBuilder;
//
//   const CustomImage({
//     super.key,
//     required this.source,
//     this.isNetwork = false,
//     this.isSvg = false,
//     this.width = 24,
//     this.height = 24,
//     this.fit = BoxFit.cover,
//     this.borderRadius,
//     this.margin,
//     this.color,
//     this.onTap,
//     this.errorBuilder,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     final placeholder = Images.noImage;
//
//     Widget buildImage(String src, {bool fromNetwork = false}) {
//       // --- Handle SVG images ---
//       if (isSvg || src.toLowerCase().endsWith('.svg')) {
//         final colorFilter = color != null
//             ? ColorFilter.mode(color!, BlendMode.srcIn)
//             : null;
//
//         if (fromNetwork) {
//           return SvgPicture.network(
//             src,
//             width: width,
//             height: height,
//             fit: fit,
//             colorFilter: colorFilter,
//             placeholderBuilder: (_) => Image.asset(
//               placeholder,
//               width: width,
//               height: height,
//               fit: fit,
//                 errorBuilder:errorBuilder
//             ),
//           );
//         } else {
//           return SvgPicture.asset(
//             src,
//             width: width,
//             height: height,
//             fit: fit,
//             colorFilter: colorFilter,
//           );
//         }
//       }
//
//       // --- Handle PNG/JPG ---
//       if (fromNetwork) {
//         return Image.network(
//           src,
//           width: width,
//           height: height,
//           fit: fit,
//           color: color,
//           errorBuilder: (_, __, ___) =>
//               Image.asset(placeholder, width: width, height: height, fit: fit),
//         );
//       } else {
//         return Image.asset(
//           src,
//           width: width,
//           height: height,
//           fit: fit,
//           color: color,
//         );
//       }
//     }
//
//     final Widget image = ClipRRect(
//       borderRadius: borderRadius ?? BorderRadius.zero,
//       child: (source == null || source!.isEmpty)
//           ? buildImage(placeholder)
//           : buildImage(source!, fromNetwork: isNetwork),
//     );
//
//     return Container(
//       margin: margin ?? EdgeInsets.zero,
//       child: onTap != null
//           ? GestureDetector(onTap: onTap, child: image)
//           : image,
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shimmer/shimmer.dart';
import 'package:yumly/core/utils/Images.dart';

class CustomImage extends StatelessWidget {
  final String? source;
  final bool isNetwork;
  final bool isSvg;
  final double width;
  final double height;
  final BoxFit fit;
  final BorderRadius? borderRadius;
  final EdgeInsetsGeometry? margin;
  final Color? color;
  final VoidCallback? onTap;
  final ImageErrorWidgetBuilder? errorBuilder;

  const CustomImage({
    super.key,
    required this.source,
    this.isNetwork = false,
    this.isSvg = false,
    this.width = 24,
    this.height = 24,
    this.fit = BoxFit.cover,
    this.borderRadius,
    this.margin,
    this.color,
    this.onTap,
    this.errorBuilder,
  });

  @override
  Widget build(BuildContext context) {
    final placeholder = Images.noImage;

    Widget shimmerPlaceholder() {
      return Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: Container(width: width, height: height, color: Colors.white),
      );
    }

    Widget buildImage(String src, {bool fromNetwork = false}) {
      if (isSvg || src.toLowerCase().endsWith('.svg')) {
        final colorFilter = color != null
            ? ColorFilter.mode(color!, BlendMode.srcIn)
            : null;

        return fromNetwork
            ? SvgPicture.network(
                src,
                width: width,
                height: height,
                fit: fit,
                colorFilter: colorFilter,
                placeholderBuilder: (_) => shimmerPlaceholder(),
              )
            : SvgPicture.asset(
                src,
                width: width,
                height: height,
                fit: fit,
                colorFilter: colorFilter,
              );
      }

      if (fromNetwork) {
        return Image.network(
          src,
          width: width,
          height: height,
          fit: fit,
          color: color,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            // Shimmer while loading
            return Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Container(
                width: width,
                height: height,
                color: Colors.white,
              ),
            );
          },
          errorBuilder: (context, error, stackTrace) {
            return Center(
              child: Image.asset(placeholder, width: width, height: height),
            );
          },
        );
      } else {
        return Image.asset(
          src,
          width: width,
          height: height,
          fit: fit,
          color: color,
        );
      }
    }

    final Widget image = ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.zero,
      child: (source == null || source!.isEmpty)
          ? buildImage(placeholder)
          : buildImage(source!, fromNetwork: isNetwork),
    );

    return Container(
      margin: margin ?? EdgeInsets.zero,
      child: onTap != null
          ? GestureDetector(onTap: onTap, child: image)
          : image,
    );
  }
}
