import 'package:fitness_tracking/core/exports.dart';

import '../../controller/authentication/auhentication_controller.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  AuthenticationController authenticationController = AuthenticationController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            spacing: 20,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(
                  "https://i.pinimg.com/736x/3c/ae/07/3cae079ca0b9e55ec6bfc1b358c9b1e2.jpg",
                ),
              ),
              AppTextFormField(
                hintText: "Name",
              ),
              AppTextFormField(
                hintText: "Email",
                enabled: false,
              ),
              AppTextFormField(
                hintText: "Age",
              ),
              AppTextFormField(
                hintText: "Height cm",
              ),
              AppTextFormField(
                hintText: "Weight kg",
              ),
              AppTextFormField(
                hintText: "Gender",
              ),
              AppButton(
                text: "Update",
                onTap: (){
        
                }
              ),
              AppButton(
                text: "Log out",
                color: AppColor.white,
                textStyle: TextStyle(
                  fontSize: 15,
                  color: AppColor.primaryColor,
                ),
                onTap: (){
                  authenticationController.logOut(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
