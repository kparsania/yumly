import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yumly/core/utils/Colors.dart';
import 'package:yumly/core/utils/Fonts.dart';
import 'package:yumly/core/utils/Images.dart';
import 'package:yumly/core/widgets/CustomDivider.dart';
import 'package:yumly/core/widgets/CustomImage.dart';
import 'package:yumly/core/widgets/CustomText.dart';
import 'FadingTextAnimation.dart';

class CustomSearchBar extends StatefulWidget implements PreferredSizeWidget {
  final List<String> placeholderTexts;
  final String? leftIcon;
  final bool showLeftIcon;
  final double? leftIconSize;
  final bool showRightVerticalDivider;
  final String? rightIcon1;
  final String? rightIcon2;
  final VoidCallback? onTap;
  final VoidCallback? onLeftIconTap;
  final Color? rightIcon1Color;
  final Color? rightIcon2Color;
  final Color? leftIconColor;
  final Decoration? decoration;
  final EdgeInsetsGeometry? margin;
  final bool? isSearchEnabled;
  final FocusNode? focusNode;

  const CustomSearchBar({
    super.key,
    required this.placeholderTexts,
    this.leftIcon,
    this.leftIconColor,
    this.showLeftIcon = true,
    this.leftIconSize,
    this.showRightVerticalDivider = true,
    this.rightIcon1,
    this.rightIcon1Color,
    this.rightIcon2Color,
    this.rightIcon2,
    this.onTap,
    this.onLeftIconTap,
    this.decoration,
    this.margin = EdgeInsets.zero,
    this.isSearchEnabled = true,
    this.focusNode,
  });

  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _CustomSearchBarState extends State<CustomSearchBar>
    with SingleTickerProviderStateMixin {
  late String currentPlaceholder;
  Timer? _timer;

  final TextEditingController _controller = TextEditingController();
  TextInputType textInputType = TextInputType.text;
  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.onTap?.call();
      },
      child: Container(
        alignment: Alignment.center,
        margin: widget.margin,
        height: 50.h,
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
        decoration:
            widget.decoration ??
            BoxDecoration(
              color: Colors.white,
              border: Border.all(color: AppColors.lightGrey),
              borderRadius: BorderRadius.all(Radius.circular(12.r)),
              boxShadow: const [
                BoxShadow(
                  color: Color.fromRGBO(238, 239, 238, 1),
                  offset: Offset(0, 8),
                  blurRadius: 10,
                  spreadRadius: 2,
                ),
              ],
            ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (widget.showLeftIcon) ...[
              GestureDetector(
                onTap: widget.onLeftIconTap,
                child: CustomImage(
                  source: widget.leftIcon ?? Images.search,
                  isSvg: true,
                  color: widget.leftIconColor,
                  height: widget.leftIconSize ?? 22.h,
                  width: widget.leftIconSize ?? 22.w,
                ),
              ),
              const SizedBox(width: 8),
            ],

            /// Placeholder text expands fully
            Expanded(
              child: Stack(
                alignment: Alignment.centerLeft,
                children: [
                  /// Animated placeholder shown only if text field is empty
                  if (_controller.text.isEmpty &&
                      widget.placeholderTexts.length > 1)
                    IgnorePointer(
                      ignoring: true,
                      child: FadingTextAnimation(
                        texts: widget.placeholderTexts,
                        textStyle: TextStyle(
                          fontSize: 18.sp,
                          color: AppColors.mediumGrey,
                        ),
                        holdDuration: const Duration(milliseconds: 1500),
                        transitionDuration: const Duration(milliseconds: 10),
                      ),
                    ),

                  /// Actual TextField
                  TextField(
                    controller: _controller,
                    focusNode: widget.focusNode ?? _focusNode,
                    enabled: widget.isSearchEnabled,
                    onChanged: (_) => setState(() {}),
                    onTap: widget.onTap,
                    style: TextStyle(
                      color: AppColors.textPrimary,
                      fontFamily: Fonts.fontFamilyLexend,
                      fontSize: 18.sp,
                    ),
                    decoration: InputDecoration(
                      hint: widget.placeholderTexts.length > 1
                          ? CustomText("")
                          : CustomText(
                              widget.placeholderTexts[0],
                              color: AppColors.mediumGrey,
                              fontFamily: Fonts.fontFamilyLexend,
                              fontSize: 18.sp,
                            ),
                      border: InputBorder.none,
                      isDense: true,
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                ],
              ),
              // AnimatedSwitcher(
              //   duration: const Duration(milliseconds: 400),
              //   // transitionBuilder: (child, anim) => SlideTransition(
              //   //   position: Tween<Offset>(
              //   //     begin: const Offset(0.0, 0.5),
              //   //     end: Offset.zero,
              //   //   ).animate(CurvedAnimation(parent: anim, curve: Curves.easeOut)),
              //   //   child: FadeTransition(opacity: anim, child: child),
              //   // ),
              //   child: CustomText(
              //     currentPlaceholder,
              //     key: ValueKey(currentPlaceholder),
              //     overflow: TextOverflow.ellipsis, // Prevent overflow
              //     color: AppColors.mediumGrey,
              //     fontSize: 16.sp,
              //   ),
              // ),

              // TextField(
              //   controller: TextEditingController(),
              //   focusNode: _focusNode,
              //   decoration: InputDecoration(
              //
              //     // hintText: _placeholders[_currentIndex],
              //     // prefixIcon: Icon(Icons.search),
              //     // border: OutlineInputBorder(
              //     //   borderRadius: BorderRadius.circular(8.0),
              //     // ),
              //   ),
              // ),
            ),

            if (widget.rightIcon2 != null || widget.rightIcon1 != null) ...[
              const SizedBox(width: 10),
              if (widget.rightIcon2 != null) ...[
                CustomImage(
                  source: widget.rightIcon2,
                  isSvg: true,
                  color: widget.rightIcon2Color,
                  height: 24,
                  width: 24.w,
                ),
              ],
              if (widget.rightIcon1 != null) const SizedBox(width: 10),
              if (widget.rightIcon1 != null) ...[
                if (widget.showRightVerticalDivider) ...[
                  CustomDivider(isVertical: true, height: 20, thickness: 1),
                  const SizedBox(width: 10),
                ],

                CustomImage(
                  source: widget.rightIcon1,
                  isSvg: true,
                  color: widget.rightIcon1Color,
                  height: 24.h,
                  width: 24.w,
                ),
              ],
            ],
          ],
        ),
      ),
    );
  }
}
