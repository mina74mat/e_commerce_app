import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider_plus/carousel_slider_plus.dart';
import 'package:e_commerce_app/core/utils/app_assets.dart';
import 'package:e_commerce_app/core/utils/app_colors.dart';
import 'package:e_commerce_app/core/utils/app_styles.dart';
import 'package:e_commerce_app/domain/entities/response/product.dart';
import 'package:e_commerce_app/features/ui/widgets/product_tab_item.dart';
import 'package:e_commerce_app/features/ui/widgets/product_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:readmore/readmore.dart';

class ProductDetailsScreen extends StatefulWidget {
  ProductDetailsScreen({super.key});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  int productCounter = 1;
  int selectedColor = 0;
  int selectedSize = 0;
  double totalPrice = 0;
  bool isInitialized = false;

  List<int> sizes = [35, 38, 39, 40];
  List<Color> color = [
    Colors.red,
    Colors.blueAccent,
    Colors.green,
    Colors.yellow,
  ];

  List<String> productImages = [
    "https://www.nike.sa/dw/image/v2/BDVB_PRD/on/demandware.static/-/Sites-akeneo-master-catalog/default/dw42ccc9ea/nk/a9b/7/6/4/b/1/a9b764b1_834c_413e_aec2_f460112b2de6.jpg?sw=2000&sh=2000&sm=fit",
    "https://www.nike.sa/dw/image/v2/BDVB_PRD/on/demandware.static/-/Sites-akeneo-master-catalog/default/dw42ccc9ea/nk/a9b/7/6/4/b/1/a9b764b1_834c_413e_aec2_f460112b2de6.jpg?sw=2000&sh=2000&sm=fit",
    "https://www.nike.sa/dw/image/v2/BDVB_PRD/on/demandware.static/-/Sites-akeneo-master-catalog/default/dw42ccc9ea/nk/a9b/7/6/4/b/1/a9b764b1_834c_413e_aec2_f460112b2de6.jpg?sw=2000&sh=2000&sm=fit",
  ];

  @override
  Widget build(BuildContext context) {
    var product = ModalRoute.of(context)!.settings.arguments as Product ;
    if (!isInitialized) {
      totalPrice = product.price?.toDouble() ?? 0;
      isInitialized = true;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Product Details",
          style: AppStyles.semi20Primary,
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.search,
                color: AppColors.primaryColor,
                size: 30,
              )),
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.shopping_cart_outlined,
                color: AppColors.primaryColor,
              )),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 50.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProductSlider(
                initialIndex: 0,
                items: product.images ?? [product.imageCover ?? ""],
              ),
              SizedBox(
                height: 16.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      product.title??'',
                      style: AppStyles.medium18Header,
                    ),
                  ),
                  Text(
                    "EGP ${product.price}",
                    style: AppStyles.medium18Header,
                  ),
                ],
              ),
              SizedBox(
                height: 16.h,
              ),
              Row(
                children: [
                  Container(
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: AppColors.primaryColor.withOpacity(.3),
                          width: 1),
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                    child: Text(
                      '${product.sold} Sold',
                      overflow: TextOverflow.ellipsis,
                      style: AppStyles.medium14PrimaryDark,
                    ),
                  ),
                  SizedBox(
                    width: 16.w,
                  ),
                  Image.asset(
                    AppAssets.starIcon,
                    width: 20.w,
                  ),
                  SizedBox(
                    width: 4.w,
                  ),
                  Expanded(
                    child: Text(
                      "${product.ratingsAverage} (${product.ratingsQuantity})",
                      overflow: TextOverflow.ellipsis,
                      style: AppStyles.regular14Text,
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.circular(24.r),
                    ),
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 7.h),
                    child: Row(
                      children: [
                        InkWell(
                            onTap: () {
                              if (productCounter > 1) {
                                productCounter--;
                                totalPrice = (product.price ?? 0) * productCounter.toDouble();
                                setState(() {});
                              }
                            },
                            child: Icon(
                              Icons.remove_circle_outline,
                              size: 20.w,
                              color: AppColors.whiteColor,
                            )),
                        SizedBox(
                          width: 18.w,
                        ),
                        AutoSizeText(
                          '$productCounter',
                          style: AppStyles.medium18White,
                        ),
                        SizedBox(
                          width: 18.w,
                        ),
                        InkWell(
                            onTap: () {
                              productCounter++;
                              totalPrice = (product.price ?? 0) * productCounter.toDouble();
                              setState(() {});
                            },
                            child: Icon(
                              Icons.add_circle_outline,
                              color: AppColors.whiteColor,
                              size: 20.w,
                            )),
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 8.h,
              ),
              Text(
                'Description',
                style: AppStyles.medium18Header,
              ),
              SizedBox(
                height: 8.h,
              ),
              ReadMoreText(
                product.description??'',
                style: AppStyles.medium14LightPrimary,
                trimExpandedText: ' Read Less',
                trimCollapsedText: ' Read More',
                trimLines: 2,
                trimMode: TrimMode.Line,
                colorClickableText: AppColors.primaryColor,
              ),
              SizedBox(
                height: 16.h,
              ),
              Text('Size', style: AppStyles.medium18Header),
              _buildSizeSection(),
              Text('Color', style: AppStyles.medium18Header),
              _buildColorSection(),
              _buildPriceSection(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildColorSection() {
    return Container(
      margin: EdgeInsets.only(top: 8.h),
      height: 45.h,
      child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedSize = index;
                });
              },
              child: CircleAvatar(
                radius: 20.r,
                backgroundColor: color[index],
                child: Align(
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.check,
                      color: index == selectedSize
                          ? AppColors.whiteColor
                          : Colors.transparent,
                    )),
              ),
            );
          },
          separatorBuilder: (context, index) => SizedBox(
                width: 17.w,
              ),
          itemCount: color.length),
    );
  }

  Widget _buildSizeSection() {
    return Container(
      margin: EdgeInsets.only(top: 8.h, bottom: 24.h),
      height: 45.h,
      child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedColor = index;
                });
              },
              child: CircleAvatar(
                radius: 22.r,
                backgroundColor: index == selectedColor
                    ? AppColors.primaryColor
                    : Colors.transparent,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 9.w, vertical: 9.h),
                  child: Text(
                    '${sizes[index]}',
                    style: AppStyles.regular14Text.copyWith(
                        color: index == selectedColor
                            ? AppColors.whiteColor
                            : AppColors.primaryColor),
                  ),
                ),
              ),
            );
          },
          separatorBuilder: (context, index) => SizedBox(
                width: 17.w,
              ),
          itemCount: sizes.length),
    );
  }

  Widget _buildPriceSection() {
    return Container(
      margin: EdgeInsets.only(top: 48.h),
      child: Row(
        children: [
          Column(
            children: [
              Text(
                'Total price',
                style: AppStyles.medium18Header
                    .copyWith(color: AppColors.primaryDark.withOpacity(0.6)),
              ),
              SizedBox(
                height: 12.h,
              ),
              Text("EGP $totalPrice", style: AppStyles.medium18Header)
            ],
          ),
          SizedBox(
            width: 33.w,
          ),
          Expanded(
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(17.r)),
                  backgroundColor: AppColors.primaryColor,
                  padding:
                      EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
                ),
                onPressed: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.add_shopping_cart,
                      color: AppColors.whiteColor,
                    ),
                    SizedBox(
                      width: 15.w,
                    ),
                    AutoSizeText("Add To Cart", style: AppStyles.medium20White),
                  ],
                )),
          )
        ],
      ),
    );
  }
}
