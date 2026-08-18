import 'package:auto_size_text/auto_size_text.dart';
import 'package:e_commerce_app/core/utils/app_colors.dart';
import 'package:e_commerce_app/core/utils/flutter_toast.dart';
import 'package:e_commerce_app/features/ui/pages/cart_screen/cubit/cart_states.dart';
import 'package:e_commerce_app/features/ui/pages/cart_screen/cubit/cart_view_model.dart';
import 'package:e_commerce_app/features/ui/widgets/cart_item.dart';
import 'package:e_commerce_app/features/ui/widgets/custom_badge.dart';
import 'package:e_commerce_app/features/ui/widgets/main_error_widget.dart';
import 'package:e_commerce_app/features/ui/widgets/main_loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CartScreen extends StatefulWidget {
  static const String routeName = "CartItems";

  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    CartViewModel.get(context).getItemsCart();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _customAppBar(context),
        body: BlocListener<CartViewModel,CartStates>(
          listener: (context, state) {
            if(state is GetCartSuccessState){
              ToastMessage.toastMsg(state.message??'Success',
                  AppColors.greenColor,
                  AppColors.whiteColor
              );
            }
          },
          child: BlocBuilder<CartViewModel,CartStates>(
            builder: (context, state) {
              if(state is GetCartErrorState){
                return MainErrorWidget(errorMessage: state.message);
              }else if(state is GetCartSuccessState){
                return Column(
                  children: [
                    Expanded(
                        child: ListView.builder(
                          itemCount: state.getCart.products?.length??0,
                          itemBuilder: (context, index) {
                            return  CartItem(getCart: state.getCart.products![index],);
                          },
                        )),
                    _buildCheckOut(context, state.getCart.totalCartPrice?.toDouble()??0.0),
                  ],
                );
              }else{
                return const MainLoadingWidget();
              }
            },
          ),
        ));
  }

  Widget _buildCheckOut(BuildContext context, double price) {
    return Padding(
      padding: EdgeInsets.only(bottom: 50.h, left: 16.w, right: 16.w),
      child: Row(
        children: [
          Column(
            children: [
              AutoSizeText(
                "Total Price",
                maxLines: 1,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: AppColors.primaryColor,
                      fontSize: 18.sp,
                    ),
              ),
              AutoSizeText(
                "$price",
                maxLines: 1,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.sp,
                    ),
              ),
            ],
          ),
          SizedBox(
            width: 30.w,
          ),
          Expanded(
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor),
                  onPressed: () {
                    //todo: navigate to payment section
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      AutoSizeText(
                        "Check Out",
                        maxLines: 1,
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  color: AppColors.whiteColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.sp,
                                ),
                      ),
                      Icon(
                        Icons.arrow_forward,
                        color: AppColors.whiteColor,
                        size: 28.sp,
                      ),
                    ],
                  )))
        ],
      ),
    );
  }
}

PreferredSizeWidget _customAppBar(BuildContext context) {
  return AppBar(
    surfaceTintColor: Colors.transparent,
    toolbarHeight: 50.h,
    centerTitle: true,
    elevation: 0,
    title: const Text("Cart"),
    backgroundColor: Colors.transparent,
    foregroundColor: AppColors.primaryColor,
    titleTextStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
        fontSize: 24.sp,
        fontWeight: FontWeight.w500,
        color: AppColors.primaryColor),
    actions: [
      IconButton(
        padding: EdgeInsets.zero,
        onPressed: () {},
        icon: Icon(
          Icons.search_outlined,
          size: 35.sp,
          color: AppColors.primaryColor,
        ),
      ),
      Padding(
        padding: EdgeInsets.only(right: 16.w),
        child: const CustomAppBarBadge(count: 5),
      ),
    ],
  );
}
