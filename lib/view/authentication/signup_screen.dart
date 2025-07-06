import 'package:fitness_tracking/core/exports.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../controller/authentication/auhentication_controller.dart';


class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  final email = TextEditingController();
  final password = TextEditingController();
  final _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Register your account",style: Theme.of(context).textTheme.titleLarge,),
            Form(
              key: _key,
              child: Column(
                spacing: 10,
                children: [
                  AppTextFormField(
                    hintText: "Email",
                    controller: email,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your email";
                      } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                        return "Please enter a valid email address";
                      }
                      return null;
                    },
                  ),
                  Consumer(
                    builder: (context, ref, child) {
                      final visible = ref.watch(signupPasswordVisible);
                      return AppTextFormField(
                        hintText: "Password",
                        obscureText: !visible,
                        controller: password,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter your password";
                          } else if (value.length < 6) {
                            return "Password must be at least 6 characters";
                          }
                          return null;
                        },
                        suffixIcon: IconButton(
                          icon: Icon(
                            visible ? Icons.visibility : Icons.visibility_off,
                          ),
                          onPressed: () {
                            ref.read(signupPasswordVisible.notifier).state = !ref.read(signupPasswordVisible);
                          },
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 20,),
                  Consumer(
                    builder: (context,ref,_){
                      final authController = ref.watch(signUpProvider.notifier);
                      final isLoading = ref.watch(signUpProvider);
                      return AppButton(
                        text: "Register",
                        loading: isLoading,
                        onTap: (){
                          if (_key.currentState!.validate()) {
                            authController.signUp(context,email.text, password.text);
                          }
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Already have an account ",style: Theme.of(context).textTheme.titleMedium,),
                InkWell(
                  onTap: (){
                    Navigator.pop(context);
                  },
                  child: Text(" Login",style: Theme.of(context).textTheme.titleMedium!.copyWith(color: AppColor.primaryColor),),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
