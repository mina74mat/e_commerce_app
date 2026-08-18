import 'package:e_commerce_app/core/utils/app_styles.dart';
import 'package:flutter/material.dart';

class MainErrorWidget extends StatelessWidget {
  final String errorMessage ;
  final VoidCallback? onTryAgain ;
  const MainErrorWidget({super.key,required this.errorMessage,
  this.onTryAgain});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(errorMessage,
        style: AppStyles.medium14PrimaryDark,),
        onTryAgain != null ?
        ElevatedButton(onPressed: onTryAgain,
            child: Text('Try Again',
              style: AppStyles.medium14PrimaryDark,)):
            Container()
      ],
    );
  }
}
