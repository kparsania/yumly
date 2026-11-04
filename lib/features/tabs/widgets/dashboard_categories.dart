import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:yumly/core/widgets/CustomImage.dart';

import '../../../core/route/screenNames.dart';
import '../../../core/utils/Constants.dart';
import '../data/restaurant_catalog.dart';

class DashboardCategories extends StatelessWidget {
  const DashboardCategories({super.key});

  static double get height => 112.h;

  @override
  Widget build(BuildContext context) {
    final displayList = categories.length > 4
        ? categories.sublist(0, 4)
        : categories;
    final itemCount = displayList.length + 1;

    return LayoutBuilder(
      builder: (context, constraints) {
        final slotWidth = constraints.maxWidth / itemCount;
        final foodSize = (slotWidth * 0.96).clamp(52.r, 80.r);
        final moreSize = foodSize * 0.68;

        return SizedBox(
          height: constraints.maxHeight.isFinite
              ? constraints.maxHeight
              : height,
          child: Row(
            children: [
              for (var index = 0; index < displayList.length; index++)
                Expanded(
                  child: _CategoryTile(
                    onTap: () => context.pushNamed(
                      ScreenNames.RESTAURANT_LIST,
                      extra: {
                        'title': displayList[index]['title'],
                        'items': restaurantsForCategory(
                          displayList[index]['title'] as String,
                        ),
                      },
                    ),
                    icon: CustomImage(
                      source: displayList[index]['image'],
                      height: foodSize,
                      width: foodSize,
                      fit: BoxFit.contain,
                    ),
                    iconSize: foodSize,
                    label: displayList[index]['title'] as String,
                  ),
                ),
              Expanded(
                child: GestureDetector(
                  onTap: () => context.push(ScreenNames.CATEGORIES),
                  behavior: HitTestBehavior.opaque,
                  child: _CategoryTile(
                    icon: CircleAvatar(
                      radius: moreSize / 2,
                      backgroundColor: Colors.orange[100],
                      child: Icon(
                        Icons.add,
                        color: Colors.orange,
                        size: moreSize * 0.5,
                      ),
                    ),
                    iconSize: foodSize,
                    label: 'More',
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _CategoryTile extends StatelessWidget {
  const _CategoryTile({
    required this.icon,
    required this.iconSize,
    required this.label,
    this.onTap,
  });

  final Widget icon;
  final double iconSize;
  final String label;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: iconSize,
          width: iconSize,
          child: Center(child: icon),
        ),
        SizedBox(height: 6.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 2.w),
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              label,
              maxLines: 1,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 13.sp),
            ),
          ),
        ),
      ],
      ),
    );
  }
}
