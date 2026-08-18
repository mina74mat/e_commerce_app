import 'package:e_commerce_app/config/di/di.dart';
import 'package:e_commerce_app/core/utils/app_assets.dart';
import 'package:e_commerce_app/core/utils/app_colors.dart';
import 'package:e_commerce_app/core/utils/app_styles.dart';
import 'package:e_commerce_app/domain/entities/response/category.dart';
import 'package:e_commerce_app/features/ui/pages/home_screen/tabs/home_tab/cubit/home_tab_states.dart';
import 'package:e_commerce_app/features/ui/pages/home_screen/tabs/home_tab/cubit/home_tab_view_model.dart';
import 'package:e_commerce_app/features/ui/widgets/category_brand_item.dart';
import 'package:e_commerce_app/features/ui/widgets/main_error_widget.dart';
import 'package:e_commerce_app/features/ui/widgets/main_loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeTab extends StatefulWidget {
   HomeTab({Key? key}) : super(key: key);

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  HomeTabViewModel viewModel = getIt<HomeTabViewModel>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.getCategories();
    viewModel.getBrands();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 16.h,
          ),
          _buildAnnouncement(
            images: viewModel.imagesList,
          ),
          SizedBox(
            height: 24.h,
          ),
          _lineBreak(name: "Categories"),
          BlocBuilder<HomeTabViewModel,HomeTabStates>(
            bloc: viewModel,
              builder: (context, state) {
                if(state is CategoryErrorState){
                  return MainErrorWidget(errorMessage: state.message,
                  onTryAgain: (){
                    viewModel.getCategories();
                  },);
                }else if(state is HomeTabSuccessState){
                  return _buildCategoryBrandSec(state.categoriesList??[], isBrand: false);
                }else {
                  //todo: loading
                  return const MainLoadingWidget();
                }
              },
          ),
              // child: _buildCategoryBrandSec(const CategoryBrandItem())),
          _lineBreak(name: "Brands"),
          BlocBuilder<HomeTabViewModel,HomeTabStates>(
            bloc: viewModel,
            builder: (context, state) {
              if(state is BrandErrorState){
                return MainErrorWidget(errorMessage: state.message,
                  onTryAgain: (){
                    viewModel.getCategories();
                  },);
              }else if(state is HomeTabSuccessState){
                return _buildCategoryBrandSec(state.brandsList??[], isBrand: true);
              }else {
                //todo: loading
                return const MainLoadingWidget();
              }
            },
          )
          // _buildCategoryBrandSec(const CategoryBrandItem()),
        ],
      ),
    );
  }

  SizedBox _buildCategoryBrandSec(List<Category> list, {bool isBrand = false}) {
    return SizedBox(
      height: 250.h,
      width: double.infinity,
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, mainAxisSpacing: 16.h, crossAxisSpacing: 16.w),
        itemCount: list.length,
        scrollDirection: Axis.horizontal,
        physics: const ScrollPhysics(),
        itemBuilder: (context, index) {
          return CategoryBrandItem(item: list[index], isBrand: isBrand,);
        },
      ),
    );
  }

  ImageSlideshow _buildAnnouncement({
    required List<String> images,
  }) {
    return ImageSlideshow(
        indicatorColor: AppColors.primaryColor,
        initialPage: 0,
        indicatorBottomPadding: 15.h,
        indicatorPadding: 8.w,
        indicatorRadius: 5,
        indicatorBackgroundColor: AppColors.whiteColor,
        isLoop: true,
        autoPlayInterval: 3000,
        height: 190.h,
        children: images.map((url) {
          return Image.asset(
            url,
            fit: BoxFit.fill,
          );
        }).toList());
  }

  Widget _lineBreak({required String name}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(name, style: AppStyles.medium18Header),
        TextButton(
          onPressed: () {
            //todo: navigate to all
          },
          child: Text("View All", style: AppStyles.regular12Text),
        )
      ],
    );
  }
}
