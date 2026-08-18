import 'package:e_commerce_app/config/di/di.dart';
import 'package:e_commerce_app/core/cache/shared_prefs_utils.dart';
import 'package:e_commerce_app/core/utils/app_assets.dart';
import 'package:e_commerce_app/core/utils/app_colors.dart';
import 'package:e_commerce_app/core/utils/app_routes.dart';
import 'package:e_commerce_app/core/utils/app_styles.dart';
import 'package:e_commerce_app/features/ui/auth/register/cubit/register_view_model.dart';
import 'package:e_commerce_app/features/ui/auth/states/auth_states.dart';
import 'package:e_commerce_app/features/ui/widgets/custom_elevated_button.dart';
import 'package:e_commerce_app/features/ui/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:e_commerce_app/core/utils/validators.dart';

import '../../../../core/utils/dialog_utils.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController fullNameController =
      TextEditingController(text: "ali dekheel");
  TextEditingController phoneController =
      TextEditingController(text: "01100860890");
  TextEditingController mailController =
      TextEditingController(text: "adasdf@fds.com");
  TextEditingController passwordController =
      TextEditingController(text: "15261548@A");
  TextEditingController rePasswordController =
      TextEditingController(text: "15261548@A");

  RegisterViewModel viewModel = getIt<RegisterViewModel>();


  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterViewModel,AuthStates>(
      bloc: viewModel,
      listener: (context,state){
        if(state is AuthLoadingState){
          DialogUtils.showLoading(context: context, message: 'Loading...');
        }else if(state is AuthErrorState){
          DialogUtils.hideLoading(context);
          DialogUtils.showMessage(context: context, message: state.message,
              title: 'Error',posActionName: 'Ok');
        }else if(state is AuthSuccessState){
          DialogUtils.hideLoading(context);
          // Save token immediately
          SharedPrefsUtils.saveData(key: 'token', value: state.authResponse.token ?? '');
          DialogUtils.showMessage(context: context, message: 'Register Successfully',
              title: 'Success',posActionName: 'Ok', posAction: (){
                Navigator.pushReplacementNamed(context, AppRoutes.homeRoute);
              });
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.primaryColor,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                    top: 91.h, bottom: 10.h, left: 97.w, right: 97.w),
                child: Image.asset(
                  AppAssets.appBarLeading,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 40.h),
                      child: Form(
                        key: viewModel.formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              "Full Name",
                              style: AppStyles.medium18White,
                            ),
                            CustomTextFormField(
                              isPassword: false,
                              keyboardType: TextInputType.name,
                              isObscureText: false,
                              hintText: "enter your full name",
                              hintStyle: AppStyles.light18HintText,
                              filledColor: AppColors.whiteColor,
                              controller: fullNameController,
                              validator: AppValidators.validateFullName,
                            ),
                            Text(
                              "Mobile Number",
                              style: AppStyles.medium18White,
                            ),
                            CustomTextFormField(
                                isPassword: false,
                                keyboardType: TextInputType.phone,
                                isObscureText: false,
                                hintText: "enter your mobile number",
                                hintStyle: AppStyles.light18HintText,
                                filledColor: AppColors.whiteColor,
                                controller: phoneController,
                                validator: AppValidators.validatePhoneNumber),
                            Text(
                              "E-mail address",
                              style: AppStyles.medium18White,
                            ),
                            CustomTextFormField(
                                isPassword: false,
                                keyboardType: TextInputType.emailAddress,
                                isObscureText: false,
                                hintText: "enter your email address",
                                hintStyle: AppStyles.light18HintText,
                                filledColor: AppColors.whiteColor,
                                controller: mailController,
                                validator: AppValidators.validateEmail),
                            Text(
                              "Password",
                              style: AppStyles.medium18White,
                            ),
                            CustomTextFormField(
                              isPassword: true,
                              keyboardType: TextInputType.visiblePassword,
                              isObscureText: true,
                              hintText: "enter your password",
                              hintStyle: AppStyles.light18HintText,
                              filledColor: AppColors.whiteColor,
                              controller: passwordController,
                              validator: AppValidators.validatePassword,
                            ),
                            Text(
                              "RePassword",
                              style: AppStyles.medium18White,
                            ),
                            CustomTextFormField(
                              isPassword: true,
                              keyboardType: TextInputType.visiblePassword,
                              isObscureText: true,
                              hintText: "enter your password again",
                              hintStyle: AppStyles.light18HintText,
                              filledColor: AppColors.whiteColor,
                              controller: rePasswordController,
                              validator: (value) {
                                return AppValidators.validateConfirmPassword(
                                    value, passwordController.text);
                              },
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 35.h),
                              child: CustomElevatedButton(
                                  backgroundColor: AppColors.whiteColor,
                                  textStyle: AppStyles.semi20Primary,
                                  text: "Sign up",
                                  onPressed: () {
                                    viewModel.register(email: mailController.text,
                                        password: passwordController.text,
                                        phone: phoneController.text,
                                        name: fullNameController.text,
                                        rePassword: rePasswordController.text);
                                  }),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 30.h, bottom: 30.h),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.pushReplacementNamed(
                                      context, AppRoutes.loginRoute);
                                },
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        textAlign: TextAlign.center,
                                        overflow: TextOverflow.ellipsis,
                                        'Already have an account? login',
                                        style: AppStyles.medium18White,
                                        maxLines: 1,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
