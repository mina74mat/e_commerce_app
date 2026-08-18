import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_app/core/utils/app_assets.dart';
import 'package:e_commerce_app/core/utils/app_colors.dart';
import 'package:e_commerce_app/core/utils/app_routes.dart';
import 'package:e_commerce_app/core/utils/app_styles.dart';
import 'package:e_commerce_app/features/ui/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:colornames/colornames.dart';

class FavoriteItem extends StatefulWidget {
  final Map<String, dynamic> product;
  String heartIcon = AppAssets.selectedFavouriteIcon;
  bool isClicked = false;

  FavoriteItem({super.key, required this.product});

  @override
  State<FavoriteItem> createState() => _FavoriteItemState();
}

class _FavoriteItemState extends State<FavoriteItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10.h),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, AppRoutes.productRoute);
        },
        child: Container(
          height: 135.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(
              color: AppColors.primaryColor.withOpacity(.3),
            ),
          ),
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(
                    color: AppColors.primaryColor.withOpacity(.6),
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16.r),
                  child: CachedNetworkImage(
                    width: 120.w,
                    height: 135.h,
                    fit: BoxFit.cover,
                    imageUrl: widget.product["imageUrl"],
                    placeholder: (context, url) => const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primaryColor,
                      ),
                    ),
                    errorWidget: (context, url, error) => const Icon(
                      Icons.error,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(right: 8.w, bottom: 8.h, left: 8.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AutoSizeText(
                            widget.product["title"],
                            style: AppStyles.medium18Header,
                          ),
                          InkWell(
                            // radius: 25,
                            customBorder: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            onTap: () {
                              setState(() {
                                widget.isClicked = !widget.isClicked;
                                widget.heartIcon = !widget.isClicked
                                    ? AppAssets.selectedFavouriteIcon
                                    : AppAssets.selectedAddToFavouriteIcon;
                              });
                            },
                            child: Material(
                              // borderRadius: BorderRadius.circular(2),
                              color: AppColors.whiteColor,
                              elevation: 5,
                              shape: const StadiumBorder(),
                              shadowColor: AppColors.blackColor,
                              child: Padding(
                                  padding: const EdgeInsets.all(6),
                                  child: ImageIcon(
                                    AssetImage(widget.heartIcon),
                                    color: AppColors.primaryColor,
                                  )),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            margin: EdgeInsets.only(right: 10.w),
                            width: 14.w,
                            height: 14.h,
                            decoration: BoxDecoration(
                              color: widget.product["color"],
                              shape: BoxShape.circle,
                            ),
                          ),
                          AutoSizeText(
                            (widget.product["color"] as Color).colorName,
                            style: AppStyles.regular14Text,
                          )
                        ],
                      ),
                      Row(
                        children: [
                          AutoSizeText(
                            "EGP ${widget.product["finalPrice"]}",
                            style: AppStyles.medium18Header,
                          ),
                          SizedBox(
                            width: 8.w,
                          ),
                          AutoSizeText(
                            "EGP${widget.product["salePrice"]}",
                            style: AppStyles.regular11SalePrice.copyWith(
                                decoration: TextDecoration.lineThrough),
                          ),
                          const Spacer(),
                          SizedBox(
                            width: 100.w,
                            height: 36.h,
                            child: CustomElevatedButton(
                                text: "Add To Cart",
                                onPressed: () {},
                                backgroundColor: AppColors.primaryColor,
                                textStyle: AppStyles.medium14Category
                                    .copyWith(color: AppColors.whiteColor)),
                          )
                        ],
                      ),
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
}
