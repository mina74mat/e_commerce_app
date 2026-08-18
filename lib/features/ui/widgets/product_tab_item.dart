import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_app/core/utils/app_colors.dart';
import 'package:e_commerce_app/core/utils/app_styles.dart';
import 'package:e_commerce_app/core/utils/flutter_toast.dart';
import 'package:e_commerce_app/domain/entities/response/product.dart';
import 'package:e_commerce_app/features/ui/pages/cart_screen/cubit/cart_states.dart';
import 'package:e_commerce_app/features/ui/pages/cart_screen/cubit/cart_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductTabItem extends StatelessWidget {
  final Product product ;
  const ProductTabItem({super.key,required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: AppColors.primary30Opacity, width: 2)),
      child: Column(
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15.r),
                child: CachedNetworkImage(
                  width: 191.w,
                  height: 120.h,
                  fit: BoxFit.cover,
                  imageUrl:product.imageCover??'',
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(
                      color: AppColors.primaryDark,
                    ),
                  ),
                  errorWidget: (context, url, error) => const Icon(
                    Icons.error,
                    color: AppColors.redColor,
                  ),
                ),
              ),
              Positioned(
                  top: 8.h,
                  right: 8.w,
                  child: CircleAvatar(
                    backgroundColor: AppColors.whiteColor,
                    radius: 20.r,
                    child: Center(
                      child: IconButton(
                          onPressed: () {
                            // todo add to favorite
                          },
                          color: AppColors.primaryColor,
                          padding: EdgeInsets.zero,
                          iconSize: 30.r, // Adjust icon size as needed
                          icon: const Icon(
                            Icons.favorite_border_rounded,
                            color: AppColors.primaryColor,
                          )),
                    ),
                  ))
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AutoSizeText(
                  product.title??'',
                  maxLines: 1,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 12.sp,
                      ),
                ),
                SizedBox(
                  height: 1.h,
                ),
                Row(children: [
                  AutoSizeText(
                    "EGP ${product.price}",
                    maxLines: 1,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 12.sp,
                        ),
                  ),
                  SizedBox(
                    width: 8.w,
                  ),
                  AutoSizeText(
                    "EGP ${product.price!*2}",
                    maxLines: 1,
                    style: AppStyles.regular11SalePrice.copyWith(
                        color: AppColors.discountTextColor,
                        decoration: TextDecoration.lineThrough),
                  ),
                ]),
                SizedBox(
                  height: 1.h,
                ),
                Row(
                  children: [
                    AutoSizeText(
                      "Review (${product.ratingsAverage})",
                      maxLines: 1,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.w500,
                            fontSize: 12.sp,
                          ),
                    ),
                    Icon(
                      Icons.star,
                      color: AppColors.yellowColor,
                      size: 25.sp,
                    ),
                    const Spacer(
                      flex: 1,
                    ),
                    InkWell(
                      onTap: () {
                        //   todo add to cart
                        CartViewModel.get(context).addToCart(product.id??'');
                      },
                      splashColor: Colors.transparent,
                      child: Icon(
                        Icons.add_circle,
                        size: 32.sp,
                        color: AppColors.primaryColor,
                      ),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
