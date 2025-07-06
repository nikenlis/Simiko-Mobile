import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:simiko/features/profile/presentation/pages/profile_page.dart';


import '../feed/presentation/pages/feed_page.dart';
import '../home/presentation/pages/home_page.dart';
import '../home/presentation/pages/search_page.dart';


class BottomNavigationBarCubit extends Cubit<int> {
  BottomNavigationBarCubit() : super(0);

  change(int i) => emit(i);
  void resetToHome() {
    emit(0);
  }
  

  final List menuBottomNavigationBarCubit = [
    ['Home', 'images/icon_home.png', const HomePage()],
    ['Search', 'images/icon_search.png', const SearchPage()],
    ['News', 'images/icon_news.png', FeedPage()],
    ['Profile', 'images/image_profile.png', ProfilePage()],
  ];

  Widget get page => menuBottomNavigationBarCubit[state][2];

}
