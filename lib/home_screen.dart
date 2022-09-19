import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  TextEditingController searchPlant = TextEditingController();

  @override
  void dispose() {
    searchPlant.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.all(10.0),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.only(left: 25.0),
                  //color: Colors.red,
                  height: size.height * 0.1,
                  child: const Text(
                    'Discover your Plants',
                    style: TextStyle(
                      fontSize: 50,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.only(top: 25.0),
            ),
            Container(
              //color: Colors.red,
              alignment: Alignment.center,
              padding: const EdgeInsets.all(3.0),
              margin: const EdgeInsets.only(left: 25),
              child: TextField(
                controller: searchPlant,
                cursorColor: Colors.black,
                //cursorWidth: 35,
                //cursorHeight: 35,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 35,
                  fontWeight: FontWeight.w300,
                  fontStyle: FontStyle.normal,
                ),
                decoration: const InputDecoration(
                  icon: Icon(Icons.search, size: 50, color: Colors.green),
                  isDense: true,
                  border: InputBorder.none,
                  hintText: 'Find your Plants',
                  contentPadding: EdgeInsets.only(left: 10.0),
                  hintStyle: TextStyle(
                    fontSize: 35.0,
                    color: Colors.grey,
                  ),
                ),
                // onChanged:
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 20.0),
              padding: const EdgeInsets.only(left: 25.0),
              // color: Colors.red,
              height: size.height * 0.1,
              child: Row(
                //mainAxisAlignment: MainAxisAlignment.start,
                children: const <Widget>[
                  Text(
                    'Plant Categories',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 33.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              // color: Colors.red,
              //width: 100,
              height: size.height * 0.18,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.only(bottom: 5.0),
                      width: size.width * 0.2,
                      height: size.height * 0.18,
                      //color: Colors.white,
                      child: Column(
                        children: <Widget>[
                          Container(
                            // color: Colors.black,
                            margin: const EdgeInsets.only(bottom: 5.0),
                            alignment: Alignment.topCenter,
                            width: size.width * 0.2,
                            height: size.height * 0.13,
                            child: IconButton(
                              icon: Image.asset(
                                  'assets/images/all_plant_144.png'),
                              iconSize: 120,
                              onPressed: () {},
                            ),
                          ),
                          Container(
                            alignment: Alignment.topCenter,
                            child: const Text('All',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 22, fontWeight: FontWeight.bold)),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: size.width * 0.2,
                      height: size.height * 0.25,
                      color: Colors.black,
                    ),
                    Container(
                      width: size.width * 0.2,
                      height: size.height * 0.25,
                      color: Colors.black,
                    ),
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}
