


import 'package:fitness_tracking/core/exports.dart';
import 'package:fitness_tracking/view/bottom_navigation_bar/home_screen.dart';
import 'package:fitness_tracking/view/bottom_navigation_bar/profile_screen.dart';
import 'package:fitness_tracking/view/bottom_navigation_bar/rank_screen.dart';
import 'package:fitness_tracking/view/bottom_navigation_bar/water_target_screen.dart';
import 'package:fitness_tracking/view/bottom_navigation_bar/workout_screen.dart';

import '../../view/authentication/email_verification_screen.dart';

class Routes{

  static const String splash = '/';
  static const String login = '/login';
  static const String signup = '/signup';
  static const String bottomNavigation = '/bottomNavigation';
  static const String verify = '/verify';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case login:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case signup:
        return MaterialPageRoute(builder: (_) => SignUpScreen());
      case verify:
        return MaterialPageRoute(builder: (_) => const EmailVerificationScreen());
      case bottomNavigation:
        return MaterialPageRoute(builder: (_) => const BottomNavigationBarScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text('No route defined')),
          ),
        );
    }
  }



  static Widget bottomNavigationRoutes(int currentIndex){
    switch(currentIndex){
      case 0:
        return HomeScreen();
      case 1:
        return WaterTargetScreen();
      case 2:
        return WorkoutListScreen(
          workouts: [
            Workout(
              id: 'w232',
              userId: 'user123',
              type: "Running",
              durationMin: 30 ,
              distanceKm: 2.5,
              calories: 200,
              date: DateTime.now().subtract(Duration(days: 1)),
              createdAt: DateTime.now().subtract(Duration(days: 2, hours: 2)),
            ),
          ],
        );
      case 3:
        return RankScreen();
      case 4:
        return ProfileScreen();
      default:
        return HomeScreen();
    }
  }
}