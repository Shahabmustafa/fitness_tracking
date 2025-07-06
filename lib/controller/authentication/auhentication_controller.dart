import 'package:fitness_tracking/core/exports.dart';
import 'package:fitness_tracking/utils/utils.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


/// StateProvider for managing password visibility in the login screen
final loginPasswordVisible = StateProvider<bool>((ref) => false);

/// StateNotifierProvider for managing login state
final loginProvider = StateNotifierProvider<AuthenticationController, bool>((ref) {
  return AuthenticationController();
});

/// StateProvider for managing password visibility in the signup screen
final signupPasswordVisible = StateProvider<bool>((ref) => false);

/// StateNotifierProvider for managing signup state
final signUpProvider = StateNotifierProvider<AuthenticationController, bool>((ref) {
  return AuthenticationController();
});


/// StateNotifier for handling authentication logic
class AuthenticationController extends StateNotifier<bool>{

  /// Constructor initializes the state to false (not loading)
  AuthenticationController() : super(false);

  /// Supabase client instance
  final _auth = Supabase.instance.client;

  /// Login method to authenticate user with email and password
  Future<AuthResponse?> login(BuildContext context, String email, String password) async {
    state = true;
    try {
      final response = await _auth.auth.signInWithPassword(
        email: email,
        password: password,
      );

      final user = response.user;

      if (user != null && user.emailConfirmedAt != null) {
        Utils.showMessage(message: "Login Successful");
        Navigator.pushReplacementNamed(context, Routes.bottomNavigation);
      } else {
        Utils.showMessage(message: "Please verify your email");
        Navigator.pushReplacementNamed(context, Routes.verify);
      }

    } on AuthException catch (e) {
      if (e.message.toLowerCase().contains('email not confirmed') ||
          e.message.toLowerCase().contains('email_not_confirmed')) {
        Utils.showMessage(message: "Please verify your email");
        Navigator.pushReplacementNamed(context, Routes.verify);
      } else {
        Utils.showMessage(message: "Login Failed: ${e.message}");
      }
    } catch (e) {
      Utils.showMessage(message: "Unexpected Error: ${e.toString()}");
    } finally {
      state = false;
    }

    return null;
  }

  /// Sign Up method to create a new user account
  Future<AuthResponse?> signUp(context,String email, String password) async {
    state = true;
    try {
      final response = await _auth.auth.signUp(
        email: email,
        password: password,
        emailRedirectTo: 'io.supabase.flutter://login-callback',
      );

      final user = response.user;

      if (user != null) {
        await _auth.from('users').insert({
          'name': "",
          'email': email,
          'age': "",
          'height': "",
          'weight': "",
          'gender': "",
          'emailVerified': false,
        });

        Utils.showMessage(message: "Sign Up Successful. Check email to verify.");
        Navigator.pushReplacementNamed(context, Routes.verify);
      }
      state = false;
    } catch (e) {
      Utils.showMessage(message: "Sign Up Failed: ${e.toString()}");
      state = false;
      print(e.toString());
    }
    return null;
  }

  /// logout method to sign out the user
  Future<void> logOut(BuildContext context) async {
    try {
      await _auth.auth.signOut();
      Utils.showMessage(message: "Logout Successful");
      Navigator.pushReplacementNamed(context, Routes.login);
    } catch (e) {
      Utils.showMessage(message: "Logout Failed: ${e.toString()}");
    }
  }

  /// Refresh & Check Email Verification
  Future<bool> isEmailVerified() async {
    try {
      final user = await _auth.auth.getUser();
      return user.user?.emailConfirmedAt != null;
    } catch (e) {
      return false;
    }
  }
}
