import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/utils/Images.dart';
import '../../../../core/route/screenNames.dart';
import '../providers/splash_provider.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen>
    with TickerProviderStateMixin {
  final List<String> _letters = [
    Images.y,
    Images.u,
    Images.m,
    Images.l,
    Images.y,
  ];

  late final List<AnimationController> _controllers;
  late final List<Animation<Offset>> _animations;

  @override
  void initState() {
    super.initState();

    _controllers = List.generate(_letters.length, (index) {
      return AnimationController(
        duration: const Duration(milliseconds: 500),
        vsync: this,
      );
    });

    _animations = _controllers.map((controller) {
      return Tween<Offset>(
        begin: const Offset(0, -2),
        end: Offset.zero,
      ).animate(CurvedAnimation(parent: controller, curve: Curves.easeOutBack));
    }).toList();

    _startAnimations();
  }

  Future<void> _startAnimations() async {
    for (int i = 0; i < _letters.length; i++) {
      await Future.delayed(const Duration(milliseconds: 250));
      ref.read(splashProvider.notifier).showLetter(i);
      _controllers[i].forward();
    }

    await Future.delayed(const Duration(seconds: 1));
    ref.read(splashProvider.notifier).completeSplash();
    if (mounted) {
      context.go(ScreenNames.LOGIN);
    }
  }

  @override
  void dispose() {
    for (final controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final splashState = ref.watch(splashProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFF2624B),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(_letters.length, (index) {
            return splashState.visibleLetters[index]
                ? SlideTransition(
                    position: _animations[index],
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0),
                      child: Image.asset(
                        _letters[index],
                        height: 60,
                        width: 60,
                      ),
                    ),
                  )
                : const SizedBox(width: 60); // spacing
          }),
        ),
      ),
    );
  }
}
