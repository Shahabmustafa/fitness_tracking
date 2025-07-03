import 'core/exports.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fitness Tracking',
      debugShowCheckedModeBanner: false,
      theme: LightTheme.lightTheme,
      home: SplashScreen(),
    );
  }
}

