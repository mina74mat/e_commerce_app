import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_app/core/utils/app_colors.dart';
import 'package:e_commerce_app/domain/entities/response/category.dart';
import 'package:e_commerce_app/features/ui/pages/home_screen/cubit/home_screen_view_model.dart';
import 'package:e_commerce_app/features/ui/pages/home_screen/tabs/products_tab/cubit/product_tab_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoryBrandItem extends StatelessWidget {
  final Category item ;
  final bool isBrand;
  const CategoryBrandItem({super.key,required this.item, this.isBrand = false});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // 1. Change tab to Products (index 1)
        context.read<HomeScreenViewModel>().bottomNavOnTap(1);
        // 2. Filter products by category or brand id
        if (isBrand) {
          context.read<ProductTabViewModel>().getProducts(brandId: item.id);
        } else {
          context.read<ProductTabViewModel>().getProducts(categoryId: item.id);
        }
      },
      child: Column(
        children: [
          Expanded(
              flex: 8,
            child: CachedNetworkImage(
              width: double.infinity,
              height: 10.h,
              fit: BoxFit.cover,
              imageUrl: item.image??"",
              imageBuilder: (context, imageProvider) {
                return CircleAvatar(
                  backgroundImage: imageProvider,
                  radius: 50.r,
                );
              },
              placeholder: (context, url) => const Center(
                child: CircularProgressIndicator(
                  color: AppColors.primaryDark,
                ),
              ),
              errorWidget: (context, url, error) => const Icon(
                Icons.error,
                color: AppColors.redColor,
              ),
            )),
        SizedBox(
          height: 8.h,
        ),
        Expanded(
            flex: 4,
            child: Text(
              item.name??'',
              textWidthBasis: TextWidthBasis.longestLine,
              softWrap: true,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: AppColors.primaryDark,
                  fontWeight: FontWeight.normal,
                  fontSize: 14.sp),
            )),
        ],
      ),
    );
  }
}
