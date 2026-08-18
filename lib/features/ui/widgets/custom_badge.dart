import 'package:e_commerce_app/core/utils/app_assets.dart';
import 'package:e_commerce_app/core/utils/app_colors.dart';
import 'package:e_commerce_app/core/utils/app_routes.dart';
import 'package:e_commerce_app/features/ui/pages/cart_screen/cubit/cart_states.dart';
import 'package:e_commerce_app/features/ui/pages/cart_screen/cubit/cart_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomAppBarBadge extends StatelessWidget {
  final int count;

  const CustomAppBarBadge({required this.count, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currentRoute = ModalRoute.of(context)?.settings.name;
    return InkWell(
      onTap: currentRoute != AppRoutes.cartRoute
          ? () {
              Navigator.of(context).pushNamed(AppRoutes.cartRoute);
            }
          : null,
      child: BlocBuilder<CartViewModel,CartStates>(
        builder: (context, state) {
          final viewModel = CartViewModel.get(context);
          return Badge(
            alignment: AlignmentDirectional.topStart,
            backgroundColor: AppColors.greenColor,
            label: Text(viewModel.numOfCartItems.toString()),
            child: ImageIcon(
              const AssetImage(AppAssets.shoppingCart),
              size: 35.sp,
              color: AppColors.primaryColor,
            ),
          );
        },
      ),
    );
  }
}
