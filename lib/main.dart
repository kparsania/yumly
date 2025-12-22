import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yumly/core/route/go_router_provider.dart';

import 'core/utils/Colors.dart';
import 'core/utils/Globals.dart';

Future<void> main() async {
  await ScreenUtil.ensureScreenSize();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    size = MediaQuery.of(context).size;

    final goRouter = ref.watch(goRouterProvider);
    return ScreenUtilInit(
      designSize: Size(size.width, size.height),
      minTextAdapt: true,
      child: MaterialApp.router(
        routerConfig: goRouter,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          textSelectionTheme: const TextSelectionThemeData(
            selectionColor: AppColors.pinkLight,
            selectionHandleColor: AppColors.primary,
          ),
          colorScheme: const ColorScheme(
            brightness: Brightness.light,
            primary: AppColors.primary,
            onPrimary: AppColors.white,
            secondary: AppColors.secondary,
            onSecondary: AppColors.white,
            error: AppColors.black,
            onError: AppColors.black,
            surface: AppColors.white,
            onSurface: AppColors.secondary,
          ),
        ),
      ),
    );
  }
}
