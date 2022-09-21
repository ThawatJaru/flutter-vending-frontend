import 'package:automated_ios/home_screen.dart';
import 'package:flutter/material.dart';

class DescriptionPage extends StatefulWidget {
  const DescriptionPage({super.key});

  @override
  State<DescriptionPage> createState() => _DescriptionPage();
}

class _DescriptionPage extends State<DescriptionPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: 50.0,
        leading: IconButton(
          icon:
              const Icon(Icons.arrow_back_ios, color: Colors.black, size: 20.0),
          onPressed: () => Navigator.of(context).pop(
            const HomeScreen(),
          ),
        ),
        // backgroundColor: Colors.green,
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.only(top: 26.0),
            ),
            //Name Plant description page
            const Text(
              'Round Cactus',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 40,
                  fontWeight: FontWeight.bold),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 20.0),
            ),
            //Picture plant in description page
            Container(
              color: Colors.red,
              width: size.width * 0.5,
              height: size.height * 0.36,
            ),
          ],
        ),
      ),
    );
  }
}
