import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:yumly/core/route/screenNames.dart';
import 'package:yumly/features/cart/screens/add_address_screen.dart';
import 'package:yumly/features/cart/screens/addresses_screen.dart';
import 'package:yumly/features/cart/screens/cart_screen.dart';
import 'package:yumly/features/cart/screens/coupons_screen.dart';
import 'package:yumly/features/tabs/screens/dashboard_screen.dart';
import 'package:yumly/features/tabs/screens/dineout_screen.dart';
import 'package:yumly/features/tabs/screens/favourites_screen.dart';
import 'package:yumly/features/tabs/screens/reorder_screen.dart';
import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/auth/presentation/screens/signup_screen.dart';
import '../../features/auth/presentation/screens/splash_screen.dart';
import '../../features/navigation/screens/custom_tab_screen.dart';

import '../../features/products/screens/categories_screen.dart';
import '../../features/products/screens/restaurant_detail_screen.dart';

final goRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: ScreenNames.SPLASH,
    routes: [
      GoRoute(
        path: ScreenNames.SPLASH,
        name: ScreenNames.SPLASH,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: ScreenNames.LOGIN,
        name: ScreenNames.LOGIN,
        builder: (context, state) => LoginScreen(),
      ),
      GoRoute(
        path: ScreenNames.SIGN_UP,
        name: ScreenNames.SIGN_UP,
        builder: (context, state) => const SignUpScreen(),
      ),
      GoRoute(
        path: ScreenNames.DASHBOARD,
        name: ScreenNames.DASHBOARD,
        builder: (context, state) => DashboardScreen(),
      ),
      GoRoute(
        path: ScreenNames.CATEGORIES,
        name: ScreenNames.CATEGORIES,
        builder: (context, state) => CategoriesScreen(),
      ),
      GoRoute(
        path: ScreenNames.BOTTOM_TABS,
        builder: (context, state) => const MainTabScreen(),
        routes: [
          GoRoute(
            path: ScreenNames.DASHBOARD,
            builder: (_, __) => DashboardScreen(),
          ),
          GoRoute(
            path: ScreenNames.FAVOURITES,
            name: ScreenNames.FAVOURITES,
            builder: (_, __) => FavoritesScreen(),
          ),
          GoRoute(
            path: ScreenNames.DINEOUT,
            name: ScreenNames.DINEOUT,
            builder: (_, __) => DineOutScreen(),
          ),
          GoRoute(
            path: ScreenNames.REORDER,
            name: ScreenNames.REORDER,
            builder: (_, __) => ReorderScreen(),
          ),
        ],
      ),

      GoRoute(
        path: ScreenNames.CATEGORIES,
        builder: (_, __) => const CategoriesScreen(),
      ),
      GoRoute(
        path: ScreenNames.RESTAURANT_DETAIL,
        name: ScreenNames.RESTAURANT_DETAIL,
        builder: (context, state) {
          final raw = state.extra;
          final Map<String, dynamic> data = switch (raw) {
            final Map<String, dynamic> m => m,
            final Map m => Map<String, dynamic>.from(m),
            _ => <String, dynamic>{},
          };
          if (data.isEmpty) {
            return Scaffold(
              appBar: AppBar(title: const Text('Restaurant')),
              body: const Center(
                child: Text('Restaurant information is missing.'),
              ),
            );
          }
          return RestaurantDetailScreen(restaurant: data);
        },
      ),
      GoRoute(
        path: ScreenNames.CART,
        name: ScreenNames.CART,
        builder: (context, state) {
          return CartScreen();
        },
      ),
      GoRoute(
        path: ScreenNames.COUPONS,
        name: ScreenNames.COUPONS,
        builder: (context, state) => const CouponsScreen(),
      ),
      GoRoute(
        path: ScreenNames.ADDRESSES,
        name: ScreenNames.ADDRESSES,
        builder: (context, state) => const AddressesScreen(),
      ),
      GoRoute(
        path: ScreenNames.ADD_ADDRESS,
        name: ScreenNames.ADD_ADDRESS,
        builder: (context, state) => const AddAddressScreen(),
      ),
    ],
  );
});
