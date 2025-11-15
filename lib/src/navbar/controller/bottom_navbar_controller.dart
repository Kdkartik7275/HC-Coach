import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:hicoach_coach/src/bookings/views/schedule_view.dart';
import 'package:hicoach_coach/src/profile/views/coach_profile_view.dart';


class BottomNavBarController extends GetxController {
  List studentPages = [
   Center(child: Text('Home')),
   Center(child: Text('Favourites')),
   ScheduleView(),
   Center(child: Text('Notifications')),
   CoachProfileView(),
  ];

  var selectedIndex = 0.obs;

  void onItemTapped(int index) {
    selectedIndex.value = index;
  }
}
