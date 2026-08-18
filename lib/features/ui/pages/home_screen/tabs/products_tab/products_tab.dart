import 'package:e_commerce_app/config/di/di.dart';
import 'package:e_commerce_app/core/utils/app_assets.dart';
import 'package:e_commerce_app/core/utils/app_routes.dart';
import 'package:e_commerce_app/features/ui/pages/cart_screen/cubit/cart_states.dart';
import 'package:e_commerce_app/features/ui/pages/cart_screen/cubit/cart_view_model.dart';
import 'package:e_commerce_app/features/ui/pages/home_screen/tabs/products_tab/cubit/product_tab_states.dart';
import 'package:e_commerce_app/features/ui/pages/home_screen/tabs/products_tab/cubit/product_tab_view_model.dart';
import 'package:e_commerce_app/features/ui/widgets/main_error_widget.dart';
import 'package:e_commerce_app/features/ui/widgets/main_loading_widget.dart';
import 'package:e_commerce_app/features/ui/widgets/product_tab_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/utils/flutter_toast.dart';

class ProductsTab extends StatefulWidget {
  @override
  State<ProductsTab> createState() => _ProductsTabState();
}

class _ProductsTabState extends State<ProductsTab> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // Removed direct viewModel call as it's now managed by providers
  }
  // @override
  @override
  Widget build(BuildContext context) {
    var viewModel = context.read<ProductTabViewModel>();
    return BlocListener<CartViewModel,CartStates>(
      listener: (context, state) {
        if(state is AddCartSuccessState){
          ToastMessage.toastMsg(
              'Added Item Successfully',
              AppColors.greenColor,
              AppColors.whiteColor);
        }else if(state is AddCartErrorState){
          ToastMessage.toastMsg(
              state.message,
              AppColors.redColor,
              AppColors.whiteColor);
        }
      },
      child: BlocBuilder<ProductTabViewModel,ProductTabStates>(
        bloc: viewModel,
        builder: (context, state) {
          if(state is ProductErrorState){
            return MainErrorWidget(errorMessage: state.message);
          }else if(state is ProductSuccessState){
            return SafeArea(
                child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 2 / 2.8.h,
                      crossAxisSpacing: 16.w,
                      mainAxisSpacing: 16.h),
                  itemCount: state.productsList!.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        //todo: navigate to product details screen
                        Navigator.pushNamed(context, AppRoutes.productRoute,
                        arguments: state.productsList![index]);
                      },
                      child:  ProductTabItem(product: state.productsList![index],),
                    );
                  },
                ))
              ],
            ));
          }else{
            return const MainLoadingWidget();
          }
        },

      ),
    );
  }
}
