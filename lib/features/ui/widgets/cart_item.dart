import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_app/core/utils/app_colors.dart';
import 'package:e_commerce_app/core/utils/app_routes.dart';
import 'package:e_commerce_app/domain/entities/response/get_cart.dart';
import 'package:e_commerce_app/domain/entities/response/get_products.dart';
import 'package:e_commerce_app/features/ui/pages/cart_screen/cubit/cart_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CartItem extends StatefulWidget {
  GetProducts getCart ;
   CartItem({super.key,required this.getCart});

  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Navigate to product details screen with the product object
        if (widget.getCart.product != null) {
          Navigator.pushNamed(
            context,
            AppRoutes.productRoute,
            arguments: widget.getCart.product,
          );
        }
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
        child: Container(
          height: 142.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18.r),
            border: Border.all(color: AppColors.primary30Opacity, width: 1),
          ),
          child: Row(
            children: [
              _buildImageContainer(imageCover:widget.getCart.product?.imageCover??'' ),
              Expanded(
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 8.w, vertical: 12.h),
                  child: Column(
                    children: [
                      _buildItemHeader(title: widget.getCart.product?.title??'',
                      productId: widget.getCart.product?.id??''),
                      SizedBox(height: 5.h),
                      _buildItemDetails(),
                      SizedBox(height: 5.h),
                      _buildItemPrice(price: (widget.getCart.price ?? 0) * (widget.getCart.count ?? 1).toDouble(),
                      count: widget.getCart.count!,
                      onPressedIncrement: (){
                        int count = widget.getCart.count! ;
                        count++ ;
                        setState(() {

                        });
                        CartViewModel.get(context).updateCart(widget.getCart.product?.id??'',
                         count);
                      },
                      onPressedDecrement: (){
                        int count = widget.getCart.count! ;
                        if(count > 1) {
                          count--;
                          CartViewModel.get(context).updateCart(widget.getCart.product?.id??'',
                              count);
                        } else {
                          CartViewModel.get(context).deleteCart(widget.getCart.product?.id??'');
                        }
                        setState(() {});
                      }),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImageContainer({required String imageCover}) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.primary30Opacity, width: 1),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16.r),
        child: CachedNetworkImage(
          width: 130.w,
          height: 145.h,
          fit: BoxFit.cover,
          imageUrl:imageCover,
          placeholder: (context, url) => const Center(
            child: CircularProgressIndicator(
              color: AppColors.yellowColor,
            ),
          ),
          errorWidget: (context, url, error) => const Icon(
            Icons.error,
            color: AppColors.redColor,
          ),
        ),
      ),
    );
  }

  Widget _buildItemHeader({required String title,required String productId}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: AutoSizeText(
            title,
            maxLines: 1,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 18.sp,
                ),
          ),
        ),
        InkWell(
          onTap: () {
            // TODO: delete item from cart
            CartViewModel.get(context).deleteCart(productId);
          },
          child: Icon(
            CupertinoIcons.delete,
            color: AppColors.primaryColor,
            size: 25.sp,
          ),
        ),
      ],
    );
  }

  Widget _buildItemDetails() {
    return Row(
      children: [
        CircleAvatar(
          backgroundColor: AppColors.blackColor,
          radius: 10.r,
        ),
        SizedBox(width: 10.w),
        AutoSizeText(
          "black | size 40",
          maxLines: 1,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: AppColors.primaryDarkLight,
                fontWeight: FontWeight.w500,
                fontSize: 14.sp,
              ),
        ),
      ],
    );
  }

  Widget _buildItemPrice({required double price,
    required int count,required VoidCallback onPressedIncrement,
    required VoidCallback onPressedDecrement}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AutoSizeText(
          "Egp $price",
          maxLines: 1,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: AppColors.primaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 18.sp,
              ),
        ),
        _buildQuantityControl(
          count: count,
          onPressedDecrement:onPressedDecrement ,
          onPressedIncrement: onPressedIncrement
        ),
      ],
    );
  }

  Widget _buildQuantityControl({required int count,required VoidCallback onPressedIncrement,
  required VoidCallback onPressedDecrement}) {
    return Container(
      height: 50.h,
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            onPressed: onPressedDecrement,
            icon: Icon(
              Icons.remove_circle_outline_rounded,
              color: AppColors.whiteColor,
              size: 25.sp,
            ),
          ),
          AutoSizeText(
            "$count",
            maxLines: 1,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: AppColors.whiteColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 14.sp,
                ),
          ),
          IconButton(
            onPressed: onPressedIncrement,
            icon: Icon(
              Icons.add_circle_outline_rounded,
              color: AppColors.whiteColor,
              size: 25.sp,
            ),
          ),
        ],
      ),
    );
  }
}
