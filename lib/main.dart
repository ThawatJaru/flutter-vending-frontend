import 'package:automated_ios/home_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp()); //
}

String PLANT_HOST = 'https://plant-shop-server.herokuapp.com/api/v1';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Automated_Shop',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        primaryColor: Colors.lightGreen,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const HomeScreen(),
    );
  }
}
