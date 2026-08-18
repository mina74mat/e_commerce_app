import 'package:e_commerce_app/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

class MainLoadingWidget extends StatelessWidget {
  const MainLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        color: AppColors.primaryColor,
      ),
    );
  }
}
