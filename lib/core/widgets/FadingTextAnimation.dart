// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:yumly/core/utils/Fonts.dart';
// import 'package:yumly/core/widgets/CustomText.dart';
//
// import '../utils/Colors.dart';
//
// class FadingTextAnimation extends StatefulWidget {
//   final List<String> texts;
//   final TextStyle? textStyle;
//   final Duration holdDuration; // Time text stays in center
//   final Duration transitionDuration; // Time for slide in/out
//
//   const FadingTextAnimation({
//     Key? key,
//     required this.texts,
//     this.textStyle,
//     this.holdDuration = const Duration(seconds: 2),
//     this.transitionDuration = const Duration(milliseconds: 800),
//   }) : super(key: key);
//
//   @override
//   State<FadingTextAnimation> createState() => _FadingTextAnimationState();
// }
//
// class _FadingTextAnimationState extends State<FadingTextAnimation>
//     with SingleTickerProviderStateMixin {
//   late final AnimationController _controller;
//   late final Animation<Offset> _offset;
//   late final Animation<double> _opacity;
//   int _currentIndex = 0;
//   Timer? _cycleTimer;
//
//   @override
//   void initState() {
//     super.initState();
//
//     // Total cycle = slideIn + hold + slideOut.
//     final totalDuration = widget.transitionDuration * 2 + widget.holdDuration;
//
//     _controller = AnimationController(vsync: this, duration: totalDuration);
//
//     // Split timeline into: slideIn(0–.3), hold(.3–.7), slideOut(.7–1)
//     _offset = TweenSequence<Offset>([
//       // Bounce from bottom with overshoot
//       TweenSequenceItem(
//         tween: Tween(
//           begin: const Offset(0, 1.2),
//           end: const Offset(0, -0.1),
//         ).chain(CurveTween(curve: Curves.linear)),
//         weight: 30,
//       ),
//       // Settle to center
//       TweenSequenceItem(
//         tween: Tween(
//           begin: const Offset(0, -0.1),
//           end: Offset.zero,
//         ).chain(CurveTween(curve: Curves.linear)),
//         weight: 10,
//       ),
//       // Hold at center
//       TweenSequenceItem(tween: ConstantTween(Offset.zero), weight: 30),
//       // Slide out upward
//       TweenSequenceItem(
//         tween: Tween(
//           begin: Offset.zero,
//           end: const Offset(0, -1.0),
//         ).chain(CurveTween(curve: Curves.linear)),
//         weight: 30,
//       ),
//     ]).animate(_controller);
//
//     _opacity = TweenSequence<double>([
//       TweenSequenceItem(tween: Tween(begin: 0.0, end: 1.0), weight: 30),
//       TweenSequenceItem(tween: ConstantTween(1.0), weight: 50),
//       TweenSequenceItem(tween: Tween(begin: 1.0, end: 0.0), weight: 20),
//     ]).animate(_controller);
//
//     _startCycle(totalDuration);
//   }
//
//   void _startCycle(Duration total) {
//     _animate();
//     _cycleTimer = Timer.periodic(total, (_) => _animate());
//   }
//
//   Future<void> _animate() async {
//     await _controller.forward(from: 0.0);
//     setState(() {
//       _currentIndex = (_currentIndex + 1) % widget.texts.length;
//     });
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     _cycleTimer?.cancel();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return AnimatedBuilder(
//       animation: _controller,
//       builder: (_, __) => FadeTransition(
//         opacity: _opacity,
//         child: SlideTransition(
//           position: _offset,
//           child: CustomText(
//             widget.texts[_currentIndex],
//             textAlign: TextAlign.center,
//             fontSize: 18.sp,
//             color: AppColors.mediumGrey,
//             // fontWeight: Fonts.medium,
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yumly/core/widgets/CustomText.dart';
import '../utils/Colors.dart';

class FadingTextAnimation extends StatefulWidget {
  final List<String> texts;
  final TextStyle? textStyle;
  final Duration holdDuration;
  final Duration transitionDuration;

  const FadingTextAnimation({
    Key? key,
    required this.texts,
    this.textStyle,
    this.holdDuration = const Duration(seconds: 2),
    this.transitionDuration = const Duration(milliseconds: 120),
  }) : super(key: key);

  @override
  State<FadingTextAnimation> createState() => _FadingTextAnimationState();
}

class _FadingTextAnimationState extends State<FadingTextAnimation>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<Offset> _offset;
  late final Animation<double> _opacity;
  int _currentIndex = 0;
  Timer? _cycleTimer;

  @override
  void initState() {
    super.initState();

    final totalDuration = widget.transitionDuration * 2 + widget.holdDuration;

    _controller = AnimationController(vsync: this, duration: totalDuration);

    _offset = TweenSequence<Offset>([
      TweenSequenceItem(
        tween: Tween(begin: const Offset(0, 0.6), end: Offset.zero)
            .chain(CurveTween(curve: Curves.linear)),
        weight: 30,
      ),
      TweenSequenceItem(tween: ConstantTween(Offset.zero), weight: 40),
      TweenSequenceItem(
        tween: Tween(begin: Offset.zero, end: const Offset(0, -0.6))
            .chain(CurveTween(curve: Curves.linear)),
        weight: 30,
      ),
    ]).animate(_controller);

    _opacity = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0.0, end: 1.0), weight: 25),
      TweenSequenceItem(tween: ConstantTween(1.0), weight: 50),
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 0.0), weight: 25),
    ]).animate(_controller);

    if (widget.texts.length > 1) {
      _startCycle(totalDuration);
    } else {
      // For one item, just show it without animation
      _controller.value = 1.0;
    }
  }

  void _startCycle(Duration total) {
    _animate(); // start first animation immediately
    _cycleTimer = Timer.periodic(total, (_) {
      // Update index first, then animate
      setState(() {
        _currentIndex = (_currentIndex + 1) % widget.texts.length;
      });
      _controller.forward(from: 0.0);
    });
  }

  Future<void> _animate() async {
    _controller.forward(from: 0.0);
  }

  @override
  void dispose() {
    _controller.dispose();
    _cycleTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, __) => FadeTransition(
        opacity: _opacity,
        child: SlideTransition(
          position: _offset,
          child: CustomText(
            widget.texts[_currentIndex],
            textAlign: TextAlign.center,
            fontSize: 18.sp,
            color: AppColors.mediumGrey,
          ),
        ),
      ),
    );
  }
}
