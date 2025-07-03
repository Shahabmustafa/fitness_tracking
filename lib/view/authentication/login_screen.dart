import 'package:fitness_tracking/core/exports.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

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
              child: Column(
                spacing: 10,
                children: [
                  AppTextFormField(
                    hintText: "Email",
                  ),
                  AppTextFormField(
                    hintText: "Password",
                    obscureText: true,
                    suffixIcon: Icon(Icons.visibility_off_outlined),
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
                  AppButton(
                    text: "Login",
                    onTap: (){
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => BottomNavigationBarScreen()));
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
