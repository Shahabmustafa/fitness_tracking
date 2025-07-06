
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../controller/authentication/auhentication_controller.dart';
import '../../core/exports.dart';


class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

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
            Text("Login your account",style: Theme.of(context).textTheme.titleLarge,),
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
                      final visible = ref.watch(loginPasswordVisible);
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
                            ref.read(loginPasswordVisible.notifier).state = !ref.read(loginPasswordVisible);
                          },
                        ),
                      );
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: (){

                        },
                        child: Text("Forget password",style: Theme.of(context).textTheme.titleMedium,),
                      ),
                    ],
                  ),
                  Consumer(
                    builder: (context,ref,_){
                      final authController = ref.watch(loginProvider.notifier);
                      final isLoading = ref.watch(loginProvider);
                      return AppButton(
                        text: "Login",
                        loading: isLoading,
                        onTap: (){
                          if (_key.currentState!.validate()) {
                            authController.login(context,email.text, password.text);
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
                Text("Don't have an account? ",style: Theme.of(context).textTheme.titleMedium,),
                InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpScreen()));
                  },
                  child: Text(" Register",style: Theme.of(context).textTheme.titleMedium!.copyWith(color: AppColor.primaryColor),),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
