import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:yumly/core/utils/Colors.dart';
import 'package:yumly/core/utils/Fonts.dart';
import 'package:yumly/core/widgets/CustomImage.dart';
import 'package:yumly/core/widgets/CustomText.dart';

class OfferCarousel extends StatefulWidget {
  final List<Map<String, dynamic>> offers;

  const OfferCarousel({super.key, required this.offers});

  @override
  State<OfferCarousel> createState() => _OfferCarouselState();
}

class _OfferCarouselState extends State<OfferCarousel> {
  final CarouselSliderController carouselController =
      CarouselSliderController();
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Expanded(
            child: CarouselSlider.builder(
              carouselController: carouselController,
              itemCount: widget.offers.length,
              options: CarouselOptions(
                height: 50,
                autoPlay: true,
                autoPlayInterval: const Duration(milliseconds: 2500),
                enlargeCenterPage: false,
                viewportFraction: 1,
                // full width
                onPageChanged: (index, reason) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
              ),
              itemBuilder: (context, index, realIndex) {
                final offer = widget.offers[index];
                return Row(
                  children: [
                    // Left image
                    CustomImage(source: offer['image'], height: 40, width: 40),
                    const SizedBox(width: 10),
                    // Offer details
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomText(
                          offer['title'] ?? '',
                          fontSize: 16.sp,
                          fontWeight: Fonts.bold,
                        ),
                        CustomText(
                          (offer['subtitle'] ?? '').toString().toUpperCase(),
                          fontSize: 12.sp,
                          color: AppColors.greyText,
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ),
          Column(
            children: [
              CustomText(
                '${_currentIndex + 1}/${widget.offers.length}',
                fontSize: 16.sp,
                fontWeight: Fonts.bold,
                color: AppColors.primary,
              ),
              SizedBox(height: 4),
              AnimatedSmoothIndicator(
                activeIndex: _currentIndex,
                count: widget.offers.length,
                effect: ExpandingDotsEffect(
                  activeDotColor: AppColors.primary,
                  dotColor: AppColors.divider,
                  dotHeight: 8,
                  dotWidth: 8,
                  expansionFactor: 2,
                  spacing: 6,
                ),
                onDotClicked: (index) {
                  carouselController.animateToPage(index);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
