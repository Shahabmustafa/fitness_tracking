import 'package:fitness_tracking/core/exports.dart';

class SplashServices{

  void splash(BuildContext context){
    Timer(Duration(seconds: 3), (){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));
    });
  }
}