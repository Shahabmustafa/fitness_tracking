import 'package:fitness_tracking/core/exports.dart';

class SplashServices {
  void splash(BuildContext context) {
    Timer(const Duration(seconds: 2), () {
      final session = Supabase.instance.client.auth.currentSession;
      final user = session?.user;

      if (user == null) {
        /// Not logged in
        Navigator.pushReplacementNamed(context, Routes.login);
      } else if (user.emailConfirmedAt == null) {
        /// Email not verified
        Navigator.pushReplacementNamed(context, Routes.verify);
      } else {
        /// Email verified
        Navigator.pushReplacementNamed(context, Routes.bottomNavigation);
      }
    });
  }
}
