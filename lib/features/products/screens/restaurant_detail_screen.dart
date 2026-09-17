import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:yumly/core/route/screenNames.dart';
import 'package:yumly/core/utils/Colors.dart';
import 'package:yumly/core/utils/Fonts.dart';
import 'package:yumly/core/widgets/CustomDivider.dart';
import 'package:yumly/core/widgets/CustomImage.dart';
import 'package:yumly/core/widgets/CustomText.dart';
import 'package:yumly/features/products/widgets/top_picks_card.dart';

import '../../../../core/utils/Constants.dart';
import '../../../../core/utils/Images.dart';
import '../../../../core/widgets/CustomSearchBar.dart';
import '../../../../core/widgets/menu_card.dart';
import '../../cart/provider/cart_provider.dart';
import '../providers/restaurant_detail_provider.dart';
import '../widgets/offer_carousel.dart';

final GlobalKey _searchBarKey = GlobalKey();
final GlobalKey _filtersKey = GlobalKey();
bool _showSearchBarInHeader = false;
bool _showFiltersInHeader = false;

/// Menu JSON often omits `id`; [CartItem.id] must be non-null [int].
int _menuItemCartId(
  Map<dynamic, dynamic> item,
  int index,
  Map<String, dynamic> restaurantData,
) {
  final raw = item['id'];
  if (raw is int) return raw;
  if (raw is num) return raw.toInt();
  final rest = (restaurantData['restaurant'] ?? restaurantData['title'] ?? '')
      .toString();
  final name = (item['name'] ?? '').toString();
  return Object.hash(rest.hashCode, name.hashCode, index);
}

class RestaurantDetailScreen extends ConsumerStatefulWidget {
  final Map<String, dynamic> restaurant;

  const RestaurantDetailScreen({super.key, required this.restaurant});

  @override
  _RestaurantDetailScreen createState() => _RestaurantDetailScreen();
}

class _RestaurantDetailScreen extends ConsumerState<RestaurantDetailScreen> {
  final ScrollController _scrollController = ScrollController();
  double _appBarOpacity = 0.0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.light,
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _addDishToCart(
    Map<dynamic, dynamic> item,
    int index,
    Map<String, dynamic> data,
  ) async {
    final notifier = ref.read(cartProvider.notifier);
    final dishId = _menuItemCartId(item, index, data);
    final currentRestaurant = (data['restaurant'] ?? data['title'] ?? '')
        .toString()
        .trim();
    final cart = ref.read(cartProvider);

    void doAdd() {
      notifier.addToCart(
        CartItem(
          id: dishId,
          restautantName: currentRestaurant,
          foodName: item['name']?.toString() ?? '',
          image: item['image']?.toString() ?? '',
          price: double.tryParse(item['newPrice']?.toString() ?? '') ?? 0,
          detailDescription: item['description']?.toString() ?? '',
        ),
      );
    }

    if (cart.isNotEmpty &&
        cart.first.restautantName.trim() != currentRestaurant) {
      final replace = await showDialog<bool>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Replace cart?'),
          content: Text(
            'Your cart has dishes from ${cart.first.restautantName}. '
            'To add items from $currentRestaurant, your current selection will be discarded. '
            'Do you want to continue?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(false),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(true),
              child: const Text('Replace'),
            ),
          ],
        ),
      );
      if (replace != true) return;
      notifier.clearCart();
    }
    doAdd();
  }

  void _scrollListener() {
    double offset = _scrollController.offset;
    double newOpacity = (offset / 3).clamp(0.0, 1.0);

    if (newOpacity != _appBarOpacity) {
      setState(() {
        _appBarOpacity = newOpacity;
      });
    }

    // check if search bar has reached top
    if (_searchBarKey.currentContext != null) {
      final RenderBox box =
          _searchBarKey.currentContext!.findRenderObject() as RenderBox;
      final position = box.localToGlobal(Offset.zero);

      // when the search bar hits safeAreaTop
      double safeTop = MediaQuery.of(context).padding.top;
      if (position.dy <= safeTop + 10.h) {
        if (!_showSearchBarInHeader) {
          setState(() {
            _showSearchBarInHeader = true;

            SystemChrome.setSystemUIOverlayStyle(
              SystemUiOverlayStyle(
                statusBarColor: Colors.transparent,
                statusBarIconBrightness: Brightness.dark,
                statusBarBrightness: Brightness.dark,
              ),
            );
          });
        }
      } else {
        if (_showSearchBarInHeader) {
          setState(() {
            _showSearchBarInHeader = false;
            SystemChrome.setSystemUIOverlayStyle(
              SystemUiOverlayStyle(
                statusBarColor: Colors.transparent,
                statusBarIconBrightness: Brightness.light,
                statusBarBrightness: Brightness.light,
              ),
            );
          });
        }
      }
    }
    if (_filtersKey.currentContext != null) {
      final RenderBox box =
          _filtersKey.currentContext!.findRenderObject() as RenderBox;
      final position = box.localToGlobal(Offset.zero);

      // when the search bar hits safeAreaTop
      double safeTop = MediaQuery.of(context).padding.top;
      if (position.dy <= safeTop + kToolbarHeight) {
        if (!_showFiltersInHeader) {
          setState(() => _showFiltersInHeader = true);
        }
      } else {
        if (_showFiltersInHeader) {
          setState(() => _showFiltersInHeader = false);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(restaurantDetailProvider);
    final notifier = ref.read(restaurantDetailProvider.notifier);

    final restaurant = widget.restaurant;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifier.setRestaurant(restaurant);
    });

    final data = state.restaurant ?? {};
    final String rating = (data['rating'] ?? '').toString();
    final String deliveryTime = (data['deliveryTime'] ?? '').toString();
    final List<dynamic> menu = (data['menu'] is List)
        ? data['menu'] as List
        : const [];

    final cart = ref.watch(cartProvider);
    final totalItems = cart.fold<int>(0, (sum, item) => sum + item.quantity);

    return Scaffold(
      body: Container(
        color: AppColors.white,
        child: Stack(
          children: [
            SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [AppColors.primary, AppColors.secondary],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(16.w),
                        bottomRight: Radius.circular(16.w),
                      ),
                      // color: AppColors.darkGrey,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: MediaQuery.of(context).padding.top),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomImage(
                              source: Images.backArrow,
                              color: AppColors.white,
                              isSvg: true,
                              onTap: () {
                                context.pop();
                              },
                              height: 16.h,
                              width: 16.w,
                            ),
                            CustomImage(
                              source: Images.menu,
                              color: AppColors.white,
                              isSvg: true,
                              onTap: () => {},
                              height: 24.h,
                              width: 24.w,
                            ),
                          ],
                        ),
                        SizedBox(height: 36.h),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 10.w),
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.all(Radius.circular(16)),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 8.h),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      CustomImage(
                                        source: Images.vegLeaf,
                                        height: 18.h,
                                        width: 18.w,
                                      ),
                                      SizedBox(width: 4.w),
                                      CustomText(
                                        "Pure Veg",
                                        color: Color(0xff01a437),
                                        fontSize: 16.sp,
                                      ),
                                    ],
                                  ),
                                  CustomImage(
                                    source:
                                        (restaurant.containsKey('isFavourite'))
                                        ? (restaurant['isFavourite'] == true
                                              ? Images.heartFilled
                                              : Images.heart)
                                        : Images.heart,
                                    color: AppColors.primary,
                                  ),
                                ],
                              ),
                              SizedBox(height: 8.h),
                              CustomText(
                                restaurant['restaurant'] ??
                                    restaurant['title'] ??
                                    'Restaurant',
                                fontSize: 24.sp,
                                fontWeight: Fonts.bold,
                              ),
                              SizedBox(height: 8.h),
                              CustomText(
                                restaurant['address'] ?? '',
                                color: AppColors.textSecondary,
                                fontWeight: Fonts.semiBold,
                              ),
                              SizedBox(height: 8.h),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.timer_sharp,
                                        color: AppColors.textSecondary,
                                        size: 18.w,
                                      ),
                                      SizedBox(width: 4.w),
                                      CustomText(
                                        deliveryTime,
                                        fontSize: 12.sp,
                                        fontWeight: Fonts.semiBold,
                                        color: AppColors.textSecondary,
                                      ),
                                      CustomDivider(isVertical: true),
                                    ],
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 10.w,
                                      vertical: 8.w,
                                    ),
                                    decoration: BoxDecoration(
                                      color: AppColors.green,
                                      borderRadius: BorderRadius.circular(20.w),
                                    ),
                                    child: Row(
                                      children: [
                                        CustomText(
                                          rating,
                                          color: AppColors.white,
                                          fontSize: 18.w,
                                        ),
                                        SizedBox(width: 4.w),
                                        Icon(
                                          Icons.star,
                                          color: AppColors.white,
                                          size: 18.w,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              CustomDivider(
                                thickness: 1,
                                padding: EdgeInsets.symmetric(vertical: 4.h),
                              ),
                              OfferCarousel(offers: dummyOffers),
                              SizedBox(height: 10.h),
                            ],
                          ),
                        ),
                        SizedBox(height: 16.h),
                      ],
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: CustomSearchBar(
                      key: _searchBarKey,
                      placeholderTexts: [
                        "Search from ${restaurant['restaurant'] ?? restaurant['title'] ?? 'Restaurant'}",
                      ],
                      showLeftIcon: false,
                      rightIcon2: Images.search,
                      rightIcon2Color: AppColors.mediumGrey,
                      rightIcon1Color: AppColors.primary,
                      rightIcon1: Images.microphone,
                      decoration: BoxDecoration(
                        color: AppColors.lightGrey,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(12),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  SizedBox(
                    height: 36.h,
                    child: ListView.separated(
                      key: _filtersKey,
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      itemCount: state.filters?.length ?? 0,
                      separatorBuilder: (_, __) => SizedBox(width: 6.w),
                      itemBuilder: (context, index) {
                        final filter = state.filters![index];
                        return Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 6.w,
                            vertical: 4.h,
                          ),
                          decoration: BoxDecoration(
                            color: filter["selected"] as bool
                                ? AppColors.lightPrimary
                                : AppColors.white,
                            border: filter["selected"] as bool
                                ? Border.all(color: AppColors.primary)
                                : Border.all(color: AppColors.greyText),
                            borderRadius: BorderRadius.circular(12.w),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomImage(
                                source: filter["icon"].toString(),
                                height: 16.h,
                                width: 16.w,
                              ),
                              SizedBox(width: 4.w),
                              CustomText(
                                filter["label"] as String,
                                color: filter["selected"] as bool
                                    ? AppColors.primary
                                    : AppColors.textPrimary,
                              ),
                              SizedBox(width: 2.w),
                              filter["selected"] as bool
                                  ? CustomImage(
                                      source: Images.cross,
                                      isSvg: true,
                                      color: AppColors.primary,
                                    )
                                  : Container(),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 12.h),
                  CustomDivider(thickness: 1),
                  SizedBox(height: 12.h),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: CustomText(
                      'Top Picks',
                      fontSize: 24.sp,
                      fontWeight: Fonts.bold,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  SizedBox(
                    height: 172.h,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: menu.length,
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      separatorBuilder: (_, __) => SizedBox(width: 12.w),
                      itemBuilder: (context, index) {
                        var item = menu[index];
                        return GestureDetector(
                          //   onTap: () => {},
                          //   // context.pushNamed(
                          //   //   ScreenNames.RESTAURANT_DETAIL,
                          //   //   extra: item,
                          //   // ),
                          child: TopPicksCard(
                            imageUrl: item?['image'] ?? "",
                            price: item['newPrice'].toString(),
                            foodName: item?['name'] ?? '',
                          ),
                        );
                      },
                    ),
                  ),
                  CustomDivider(
                    thickness: 1,
                    padding: EdgeInsets.symmetric(vertical: 8.h),
                  ),

                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: CustomText(
                      'Popular items',
                      fontSize: 24.sp,
                      fontWeight: Fonts.bold,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  ListView.separated(
                    separatorBuilder: (_, __) => SizedBox(height: 12.h),
                    physics: NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    itemCount: menu.length,
                    itemBuilder: (context, index) {
                      var item = menu[index] as Map<dynamic, dynamic>;
                      final cart = ref.watch(cartProvider);
                      final notifier = ref.read(cartProvider.notifier);
                      final dishId = _menuItemCartId(item, index, data);
                      final inCart = cart.firstWhere(
                        (c) => c.id == dishId,
                        orElse: () => CartItem(
                          id: 0,
                          restautantName: '',
                          foodName: '',
                          image: '',
                          price: 0,
                          quantity: 0,
                          detailDescription: '',
                          cookingNote: '',
                        ),
                      );

                      return Container(
                        margin: EdgeInsets.only(
                          left: 16.w,
                          right: 16.w,
                          bottom: menu.length == index + 1 ? 50.w : 0,
                        ),
                        child: MenuCard(
                          //   image: item?['image'] ?? '',
                          //   name: item?['name'] ?? '',
                          //   description: item?['description'] ?? '',
                          //   rating: item?['rating']?.toString() ?? '',
                          //   deliveryTime: item?['deliveryTime']?.toString() ?? '',
                          //   price: item?['price']?.toString() ?? '',
                          //   oldPrice: item?['oldPrice'].toString(),
                          //   newPrice: item?['newPrice'].toString(),
                          //   quantity: item?['quantity'],
                          // ),
                          image: item['image'] ?? '',
                          name: item['name'] ?? '',
                          description: item['description'] ?? '',
                          rating: item['rating']?.toString() ?? '',
                          deliveryTime: item['deliveryTime']?.toString() ?? '',
                          price: item['price']?.toString() ?? '',
                          newPrice: item['newPrice']?.toString(),
                          // quantity: inCart.quantity > 0 ? inCart.quantity : 0,
                          quantity: inCart.quantity,
                          onAdd: () => _addDishToCart(item, index, data),
                          onRemove: () => notifier.removeFromCart(dishId),
                          // trailing: inCart.quantity == 0
                          //     ? GestureDetector(
                          //   onTap: () {
                          //     notifier.addToCart(
                          //       CartItem(
                          //         id: item['id'],
                          //         name: item['name'],
                          //         image: item['image'],
                          //         price: double.tryParse(item['newPrice'].toString()) ?? 0,
                          //       ),
                          //     );
                          //   },
                          //   child: Container(
                          //     padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                          //     decoration: BoxDecoration(
                          //       color: AppColors.primary,
                          //       borderRadius: BorderRadius.circular(8.w),
                          //     ),
                          //     child: CustomText('ADD', color: AppColors.white),
                          //   ),
                          // )
                          //     : Row(
                          //   children: [
                          //     IconButton(
                          //       icon: Icon(Icons.remove, color: AppColors.primary),
                          //       onPressed: () => notifier.removeFromCart(item['id']),
                          //     ),
                          //     CustomText('${inCart.quantity}', fontSize: 16.sp),
                          //     IconButton(
                          //       icon: Icon(Icons.add, color: AppColors.primary),
                          //       onPressed: () => notifier.addToCart(
                          //         CartItem(
                          //           id: item['id'],
                          //           name: item['name'],
                          //           image: item['image'],
                          //           price: double.tryParse(item['newPrice'].toString()) ?? 0,
                          //         ),
                          //       ),
                          //     ),
                          //   ],
                          // ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            IgnorePointer(
              ignoring: _appBarOpacity == 0,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                color: AppColors.white.withValues(alpha: _appBarOpacity),
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).padding.top,
                  left: 16.w,
                  right: 16.w,
                ),
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  transitionBuilder: (child, anim) => FadeTransition(
                    opacity: anim,
                    child: SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(0, -0.2),
                        end: Offset.zero,
                      ).animate(anim),
                      child: child,
                    ),
                  ),
                  child: _showSearchBarInHeader
                      ? Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CustomSearchBar(
                              key: ValueKey("headerSearch"),
                              placeholderTexts: [
                                "Search from ${restaurant['restaurant'] ?? restaurant['title'] ?? 'Restaurant'}",
                              ],
                              leftIcon: Images.backArrow,
                              leftIconSize: 16.w,
                              rightIcon1: Images.microphone,
                              rightIcon2: Images.search,
                              rightIcon2Color: AppColors.mediumGrey,
                              rightIcon1Color: AppColors.primary,
                              leftIconColor: AppColors.mediumGrey,
                              decoration: BoxDecoration(
                                color: AppColors.lightGrey,
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(12),
                                ),
                              ),
                              onTap: () {
                                context.pop();
                              },
                            ),
                            _showFiltersInHeader
                                ? Container(
                                    margin: EdgeInsets.symmetric(vertical: 8.h),
                                    height: 36.h,
                                    child: ListView.separated(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: state.filters!.length,
                                      separatorBuilder: (_, __) =>
                                          SizedBox(width: 6.w),
                                      itemBuilder: (context, index) {
                                        final filter = state.filters![index];
                                        return Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 6.w,
                                            vertical: 4.h,
                                          ),
                                          decoration: BoxDecoration(
                                            color: filter["selected"] as bool
                                                ? AppColors.lightPrimary
                                                : AppColors.white,
                                            border: filter["selected"] as bool
                                                ? Border.all(
                                                    color: AppColors.primary,
                                                  )
                                                : Border.all(
                                                    color: AppColors.greyText,
                                                  ),
                                            borderRadius: BorderRadius.circular(
                                              12.w,
                                            ),
                                          ),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              CustomImage(
                                                source: filter["icon"]
                                                    .toString(),
                                                height: 16.h,
                                                width: 16.w,
                                              ),
                                              SizedBox(width: 4.w),
                                              CustomText(
                                                filter["label"] as String,
                                                color:
                                                    filter["selected"] as bool
                                                    ? AppColors.primary
                                                    : AppColors.textPrimary,
                                              ),
                                              SizedBox(width: 2.w),
                                              filter["selected"] as bool
                                                  ? CustomImage(
                                                      source: Images.cross,
                                                      isSvg: true,
                                                      color: AppColors.primary,
                                                    )
                                                  : Container(),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  )
                                : Container(),
                          ],
                        )
                      : Container(
                          margin: EdgeInsets.only(bottom: 4.h),
                          child: Row(
                            key: const ValueKey("headerIcons"),
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              if (_appBarOpacity == 1.0) ...[
                                CustomImage(
                                  source: Images.backArrow,
                                  color: AppColors.secondary,
                                  isSvg: true,
                                  onTap: () => context.pop(),
                                  height: 16.h,
                                  width: 16.w,
                                ),
                                if (_appBarOpacity == 1.0)
                                  Flexible(
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 8.w,
                                      ),
                                      child: CustomText(
                                        "${restaurant['restaurant'] ?? restaurant['title']} • $deliveryTime",
                                        maxLines: 2,
                                        fontWeight: Fonts.medium,
                                        fontSize: 18.sp,
                                        color: AppColors.secondary.withValues(
                                          alpha: _appBarOpacity,
                                        ),
                                      ),
                                    ),
                                  ),
                                Container(
                                  padding: EdgeInsets.all(8.w),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColors.lightGrey,
                                    border: Border.all(
                                      color: AppColors.divider,
                                    ),
                                  ),
                                  child: CustomImage(
                                    source: Images.search,
                                    color: AppColors.secondary,
                                    isSvg: true,
                                    height: 22.h,
                                    width: 22.w,
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                ),
              ),
            ),
            totalItems == 0
                ? const SizedBox.shrink()
                : Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: IgnorePointer(
                      child: Container(
                        height: 80.h,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [
                              Colors.white,
                              Colors.white,
                              Colors.white38,
                            ],
                            stops: [0.0, 0.6, 0.9],
                          ),
                          boxShadow: const [
                            BoxShadow(
                              color: Color.fromRGBO(238, 239, 238, 1),
                              offset: Offset(-4, -8),
                              blurRadius: 10,
                              spreadRadius: 3,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

            Positioned(
              left: 16.w,
              right: 16.w,
              bottom: MediaQuery.of(context).viewPadding.bottom + 4.h,
              child: Consumer(
                builder: (context, ref, _) {
                  if (totalItems == 0) return const SizedBox.shrink();

                  return Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 12.h,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(12.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 6,
                          offset: const Offset(0, -2),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                          "$totalItems Item${totalItems > 1 ? 's' : ''} added",
                          color: AppColors.white,
                          fontSize: 16.sp,
                          fontWeight: Fonts.bold,
                        ),
                        GestureDetector(
                          onTap: () => context.push(ScreenNames.CART),
                          child: Row(
                            children: [
                              CustomText(
                                "View Cart",
                                color: AppColors.white,
                                fontWeight: Fonts.bold,
                                fontSize: 16.sp,
                              ),
                              CustomImage(
                                source: Images.nextArrow,
                                color: AppColors.white,
                                height: 22.h,
                                width: 22.w,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
