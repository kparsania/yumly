import 'package:flutter/material.dart';
import 'package:yumly/core/utils/Colors.dart';
import 'package:yumly/core/utils/Images.dart';
import 'package:yumly/core/widgets/CustomImage.dart';

class DashboardOfferBanner extends StatelessWidget {
  const DashboardOfferBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.yellow,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CustomImage(
                  source: Images.mcdonaldLogo,
                  height: 50,
                  width: 50,
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "Wohoo! are you hungry ?",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                    Text(
                      "Grab your discount now!",
                      style: TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Stack(
            clipBehavior: Clip.none,
            children: [
              CustomImage(source: Images.burgerBig, height: 160, width: 160),

              Positioned(
                top: -8,
                left: -8,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    CustomImage(source: Images.nonagon, height: 60, width: 60),
                    const Text(
                      "50%",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),

            ],
          ),
        ],
      ),
      // child: Row(
      //   children: [
      //     // McDonald's logo or image
      //     const CustomImage(source: Images.mcdonaldLogo),
      //     const SizedBox(width: 12),
      //     Expanded(
      //       child: Column(
      //         crossAxisAlignment: CrossAxisAlignment.start,
      //         children: const [
      //           Text("Wohoo! are you hungry ?", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      //           Text("Grab your discount now!", style: TextStyle(fontSize: 14)),
      //         ],
      //       ),
      //     ),
      //     Container(
      //       padding: const EdgeInsets.all(8),
      //       decoration: const BoxDecoration(
      //         color: Colors.white,
      //         shape: BoxShape.circle,
      //       ),
      //       child: const Text("50%", style: TextStyle(fontWeight: FontWeight.bold)),
      //     )
      //   ],
      // ),
    );
  }
}
