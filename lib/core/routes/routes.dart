


import 'package:fitness_tracking/core/exports.dart';
import 'package:fitness_tracking/view/bottom_navigation_bar/home_screen.dart';
import 'package:fitness_tracking/view/bottom_navigation_bar/profile_screen.dart';
import 'package:fitness_tracking/view/bottom_navigation_bar/rank_screen.dart';

class Routes{


  static Widget bottomNavigationRoutes(int currentIndex){
    switch(currentIndex){
      case 0:
        return HomeScreen();
      case 1:
        return RankScreen();
      case 2:
        return ProfileScreen();
      default:
        return HomeScreen();
    }
  }
}