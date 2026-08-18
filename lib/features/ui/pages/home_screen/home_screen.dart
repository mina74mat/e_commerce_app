import 'package:e_commerce_app/config/di/di.dart';
import 'package:e_commerce_app/core/utils/app_colors.dart';
import 'package:e_commerce_app/core/utils/app_assets.dart';
import 'package:e_commerce_app/core/utils/app_routes.dart';
import 'package:e_commerce_app/core/utils/app_styles.dart';
import 'package:e_commerce_app/features/ui/pages/cart_screen/cart_screen.dart';
import 'package:e_commerce_app/features/ui/pages/cart_screen/cubit/cart_view_model.dart';
import 'package:e_commerce_app/features/ui/pages/home_screen/cubit/home_screen_states.dart';
import 'package:e_commerce_app/features/ui/pages/home_screen/cubit/home_screen_view_model.dart';
import 'package:e_commerce_app/features/ui/pages/home_screen/tabs/favorite_tab/favorite_tab.dart';
import 'package:e_commerce_app/features/ui/pages/home_screen/tabs/home_tab/home_tab.dart';
import 'package:e_commerce_app/features/ui/pages/home_screen/tabs/products_tab/products_tab.dart';
import 'package:e_commerce_app/features/ui/pages/home_screen/tabs/user_tab/user_tab.dart';
import 'package:e_commerce_app/features/ui/widgets/custom_badge.dart';
import 'package:e_commerce_app/features/ui/pages/home_screen/tabs/products_tab/cubit/product_tab_view_model.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeScreenViewModel viewModel = getIt<HomeScreenViewModel>();

  @override
  void initState() {
    super.initState();
    CartViewModel.get(context).getItemsCart();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: viewModel),
        BlocProvider(create: (context) => getIt<ProductTabViewModel>()..getProducts()),
      ],
      child: BlocBuilder<HomeScreenViewModel, HomeScreenStates>(
        builder: (context, state) {
          var homeViewModel = context.read<HomeScreenViewModel>();
          return Scaffold(
            appBar: _buildAppBar(homeViewModel.selectedIndex),
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: homeViewModel.bodyList[homeViewModel.selectedIndex],
            ),
            bottomNavigationBar: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16.r),
                topRight: Radius.circular(16.r),
              ),
              child: Theme(
                data: Theme.of(context).copyWith(canvasColor: AppColors.primaryColor),
                child: BottomNavigationBar(
                  type: BottomNavigationBarType.fixed,
                  elevation: 0,
                  currentIndex: homeViewModel.selectedIndex,
                  onTap: (index) {
                    context.read<HomeScreenViewModel>().bottomNavOnTap(index);
                    if (index == 1) {
                      context.read<ProductTabViewModel>().getProducts();
                    }
                  },
                  iconSize: 24.sp,
                  items: [
                    _bottomNavBarItemBuilder(
                      isSelected: homeViewModel.selectedIndex == 0,
                      selectedIcon: AppAssets.selectedHomeIcon,
                      unselectedIcon: AppAssets.unSelectedHomeIcon,
                    ),
                    _bottomNavBarItemBuilder(
                      isSelected: homeViewModel.selectedIndex == 1,
                      selectedIcon: AppAssets.selectedCategoryIcon,
                      unselectedIcon: AppAssets.unSelectedCategoryIcon,
                    ),
                    _bottomNavBarItemBuilder(
                      isSelected: homeViewModel.selectedIndex == 2,
                      selectedIcon: AppAssets.selectedFavouriteIcon,
                      unselectedIcon: AppAssets.unSelectedFavouriteIcon,
                    ),
                    _bottomNavBarItemBuilder(
                      isSelected: homeViewModel.selectedIndex == 3,
                      selectedIcon: AppAssets.selectedAccountIcon,
                      unselectedIcon: AppAssets.unSelectedAccountIcon,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  BottomNavigationBarItem _bottomNavBarItemBuilder(
      {required bool isSelected,
      required String selectedIcon,
      required String unselectedIcon}) {
    return BottomNavigationBarItem(
      icon: CircleAvatar(
        foregroundColor:
            isSelected ? AppColors.primaryColor : AppColors.whiteColor,
        backgroundColor: isSelected ? AppColors.whiteColor : Colors.transparent,
        radius: 25.r,
        child: Image.asset(
          isSelected ? selectedIcon : unselectedIcon,
        ),
      ),
      label: "",
    );
  }

  OutlineInputBorder _buildCustomBorder() {
    return OutlineInputBorder(
        borderSide: const BorderSide(
          color: AppColors.primaryColor,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(50.r));
  }

  PreferredSizeWidget _buildAppBar(int index) {
    return AppBar(
      surfaceTintColor: AppColors.transparentColor,
      elevation: 0,
      toolbarHeight: index != 3 ? 120.h : kToolbarHeight,
      leadingWidth: double.infinity,
      leading: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 10.h),
              child: Image.asset(
                AppAssets.routeLogo,
                width: 66.w,
                height: 22.h,
              ),
            ),
            Visibility(
              visible: index != 3,
              child: Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                          style: AppStyles.regular14Text,
                          cursorColor: AppColors.primaryColor,
                          onTap: () {
                            //todo: implement search logic
                          },
                          decoration: InputDecoration(
                              border: _buildCustomBorder(),
                              enabledBorder: _buildCustomBorder(),
                              focusedBorder: _buildCustomBorder(),
                              contentPadding: EdgeInsets.all(16.h),
                              hintStyle: AppStyles.light14SearchHint,
                              hintText: "what do you search for?",
                              prefixIcon: Icon(
                                Icons.search,
                                size: 30.sp,
                                color: AppColors.primaryColor.withOpacity(0.75),
                              ))),
                    ),
                    const CustomAppBarBadge(count: 5)
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
