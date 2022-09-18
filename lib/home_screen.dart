import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Column(children: <Widget>[
          const Padding(
            padding: EdgeInsets.all(10.0),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.only(left: 15.0),
                //color: Colors.red,
                height: size.height * 0.1,
                child: const Text('Discover your Plants',
                    style: TextStyle(
                      fontSize: 42,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    )),
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
