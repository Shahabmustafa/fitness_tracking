import 'package:fitness_tracking/core/routes/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../color/app_colors.dart';

class BottomNavigationBarScreen extends StatefulWidget {
  const BottomNavigationBarScreen({super.key});
  @override
  State<BottomNavigationBarScreen> createState() => _BottomNavigationBarScreenState();
}

class _BottomNavigationBarScreenState extends State<BottomNavigationBarScreen> {


  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      Routes.bottomNavigationRoutes(0),
      Routes.bottomNavigationRoutes(1),
      Routes.bottomNavigationRoutes(2),
      Routes.bottomNavigationRoutes(3),
    ];

    print("Build Bottom Navigation Bar");
    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: AppColor.white,
        unselectedItemColor: AppColor.grey.shade400,
        backgroundColor: AppColor.primaryColor,
        currentIndex: currentIndex,
        type: BottomNavigationBarType.fixed,
        onTap: (index){
          setState(() {
            currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(currentIndex == 0 ? Icons.home : Icons.home_outlined),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(currentIndex == 2 ? Icons.message : Icons.message_outlined),
            label: "Rank",
          ),
          BottomNavigationBarItem(
            icon: Icon(currentIndex == 4 ? CupertinoIcons.person_alt : CupertinoIcons.person),
            label: "Profile",
          ),
        ] ,
      ),
    );
  }
}
