import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:hicoach_coach/src/chats/view/chats_view.dart';
import 'package:hicoach_coach/src/home/view/home_view.dart';
import 'package:hicoach_coach/src/profile/views/coach_profile_view.dart';

class BottomNavBarController extends GetxController {
  List studentPages = [
    HomeView(),
    Center(child: Text('Favourites')),
    ChatsView(),

    Center(child: Text('Notifications')),
    CoachProfileView(),
  ];

  var selectedIndex = 0.obs;

  void onItemTapped(int index) {
    selectedIndex.value = index;
  }
}
