import 'package:flutter/material.dart';
import 'package:yumly/core/utils/Colors.dart';
import 'package:yumly/core/utils/Fonts.dart';
import 'package:yumly/core/utils/Images.dart';
import 'package:yumly/core/widgets/CustomImage.dart';
import 'package:yumly/core/widgets/CustomText.dart';

class CategoriesItem extends StatelessWidget {
  final String? title;
  final String imagePath;
  final String? subtitle;

  const CategoriesItem({
    super.key,
    this.title,
    required this.imagePath,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Positioned(
          top: 60,
          child: CustomImage(source: Images.pinkCard, height: 150, width: 160),
        ),

        Positioned(
          child: CustomImage(source: imagePath, height: 150, width: 150),
        ),

        Positioned(
          bottom: 20,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  title!,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              CustomText(
                subtitle!,
                fontWeight: Fonts.light,
                color: AppColors.textSecondary,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
