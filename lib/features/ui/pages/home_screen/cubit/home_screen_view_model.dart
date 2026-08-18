import 'package:e_commerce_app/features/ui/pages/home_screen/cubit/home_screen_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../tabs/favorite_tab/favorite_tab.dart';
import '../tabs/home_tab/home_tab.dart';
import '../tabs/products_tab/products_tab.dart';
import '../tabs/user_tab/user_tab.dart';

@injectable
class HomeScreenViewModel extends Cubit<HomeScreenStates>{
  HomeScreenViewModel():super(HomeInitialState());
  //todo: hold data - handle logic
  int selectedIndex = 0;
  List<Widget> bodyList = [
     HomeTab(),
    ProductsTab(),
    FavoriteTab(),
    const UserTab()
  ];
  void bottomNavOnTap(int index) {
    selectedIndex = index;
    emit(ChangeSelectedIndexState());
  }
}