import 'package:fitness_tracking/core/exports.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

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
              child: Column(
                spacing: 10,
                children: [
                  AppTextFormField(
                    hintText: "Email",
                  ),
                  AppTextFormField(
                    hintText: "Password",
                    obscureText: true,
                  ),
                  SizedBox(height: 20,),
                  AppButton(
                    text: "Register",
                    onTap: (){

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
