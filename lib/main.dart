import 'package:e_commerce_app/config/di/di.dart';
import 'package:e_commerce_app/config/my_bloc_observer.dart';
import 'package:e_commerce_app/core/cache/shared_prefs_utils.dart';
import 'package:e_commerce_app/core/utils/app_theme.dart';
import 'package:e_commerce_app/core/utils/app_routes.dart';
import 'package:e_commerce_app/features/ui/auth/login/login_screen.dart';
import 'package:e_commerce_app/features/ui/auth/register/register_screen.dart';
import 'package:e_commerce_app/features/ui/pages/cart_screen/cart_screen.dart';
import 'package:e_commerce_app/features/ui/pages/cart_screen/cubit/cart_view_model.dart';
import 'package:e_commerce_app/features/ui/pages/home_screen/home_screen.dart';
import 'package:e_commerce_app/features/ui/pages/product_details_screen/product_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  configureDependencies();
  await SharedPrefsUtils.init();
  String routeName ;
  var token = SharedPrefsUtils.getData(key: 'token');
  if(token == null || (token is String && token.isEmpty)){
    //todo: no user , no token => login
    routeName = AppRoutes.loginRoute ;
  }else{
    //todo: user => token => home screen
    routeName = AppRoutes.homeRoute ;
  }
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(create: (context) => getIt<CartViewModel>(),)
    ],
      child: MyApp(routeName: routeName,)));
}

class MyApp extends StatelessWidget {
  String routeName ;
  MyApp({required this.routeName});
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(430, 932),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: routeName,
          routes: {
            AppRoutes.loginRoute: (context) => LoginScreen(),
            AppRoutes.registerRoute: (context) => RegisterScreen(),
            AppRoutes.homeRoute: (context) => const HomeScreen(),
            AppRoutes.cartRoute: (context) => const CartScreen(),
            AppRoutes.productRoute: (context) => ProductDetailsScreen(),
          },
          theme: AppTheme.lightTheme,
        );
      },
    );
  }
}
