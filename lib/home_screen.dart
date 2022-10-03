import 'dart:async';
import 'dart:convert';
import 'dart:html';
import 'package:automated_ios/description_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreen();
}

//Plant Item Class
class PlantItem {
  final int id;
  final String name;
  final String category;
  final int price;

  const PlantItem({
    required this.id,
    required this.name,
    required this.category,
    required this.price,
  });

  static PlantItem fromJson(json) => PlantItem(
        id: json['id'],
        name: json['name'],
        category: json['category'],
        price: json['price'],
      );
}

Future<PlantItem> fetchPlant() async {
  final response = await http.get(Uri.parse(
      'https://6fa5c207-2538-4647-bd79-32c50f472ee1.mock.pstmn.io/plants'));

  if (response.statusCode == 200) {
    return PlantItem.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load plants');
  }
}

class _HomeScreen extends State<HomeScreen> {
  TextEditingController searchPlant = TextEditingController();

  Future<List<PlantItem>> plantsfuture = getPlants();

  static Future<List<PlantItem>> getPlants() async {
    const url =
        'https://6fa5c207-2538-4647-bd79-32c50f472ee1.mock.pstmn.io/plants';
    final response = await http.get(Uri.parse(url));
    final body = json.decode(response.body);

    return body.map<PlantItem>(PlantItem.fromJson).toList();
  }

  @override
  void dispose() {
    searchPlant.dispose();
    super.dispose();
  }

  Widget buildPlants(List<PlantItem> plants) => ListView.builder(
        itemCount: 6,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => Column(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(50.0),
              child: Container(
                height: 411.44, //size.height * 0.37,
                width: 233.52, //size.width * 0.28,
                margin: const EdgeInsets.all(5),
                color: Colors.grey[300],
                child: Column(
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.circular(40.0),
                      child: Container(
                        //alignment: Alignment.center,
                        height: 33.36, //size.height * 0.030,
                        width: 116.76, //size.width * 0.14,
                        margin: const EdgeInsets.all(10),
                        color: Colors.grey[50],
                        child: const Text('Outdoor plants',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold)),
                      ),
                    ),
                    //Test Image
                    Container(
                      margin: const EdgeInsets.all(3.0),
                      // color: Colors.red,
                      width: 133.44, //size.width * 0.12,
                      height: 158.46, //size.height * 0.19,
                      child: ClipRRect(
                        child: FittedBox(
                          fit: BoxFit.fill,
                          child:
                              Image.asset('assets/images/plant_outdoor_ex.jpg'),
                        ),
                      ),
                    ),
                    //Test Plant Price and Name
                    ClipRRect(
                      borderRadius: BorderRadius.circular(40.0),
                      child: Container(
                        margin: const EdgeInsets.only(
                          left: 10,
                          right: 10,
                          top: 10.0,
                        ),
                        color: Colors.white,
                        width: 1668, //size.width * 2,
                        height: 100, //size.height * 0.09,
                        child: Row(
                          children: <Widget>[
                            const Padding(
                              padding: EdgeInsets.only(left: 7.0),
                            ),
                            Column(
                              //remove the constant also!
                              children: const <Widget>[
                                Text(
                                  'Round Cactus',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FontStyle.normal,
                                  ),
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.only(left: 4.0, top: 10.0),
                                ),
                                Text(
                                  '200 Baht',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 22.0,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            //Button
                            Container(
                              margin: const EdgeInsets.only(left: 40.0),
                              height: 77.84, //size.height * 0.07,
                              width: 91.74, //size.width * 0.11,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.tealAccent[400],
                                  shape: const StadiumBorder(),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const DescriptionPage(),
                                    ),
                                  );
                                },
                                child: const Text(
                                  'Checkout',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FontStyle.normal),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
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
                margin: const EdgeInsets.only(top: 13.0),
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
                              iconSize: 100,
                              onPressed: () {},
                            ),
                          ),
                          Container(
                            alignment: Alignment.topCenter,
                            child: const Text('All',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black)),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 5.0),
                      width: size.width * 0.2,
                      height: size.height * 0.18,
                      //color: Colors.black,
                      child: Column(
                        children: <Widget>[
                          Container(
                            margin: const EdgeInsets.only(bottom: 5.0),
                            alignment: Alignment.topCenter,
                            width: size.width * 0.2,
                            height: size.height * 0.13,
                            child: IconButton(
                              icon:
                                  Image.asset('assets/images/indoor_plant.png'),
                              iconSize: 100,
                              onPressed: () {},
                            ),
                          ),
                          Container(
                            alignment: Alignment.topCenter,
                            child: const Text(
                              'Indoor',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 5.0),
                      width: size.width * 0.2,
                      height: size.height * 0.18,
                      //color: Colors.black,
                      child: Column(
                        children: <Widget>[
                          Container(
                            margin: const EdgeInsets.only(bottom: 5.0),
                            alignment: Alignment.topCenter,
                            width: size.width * 0.2,
                            height: size.height * 0.13,
                            child: IconButton(
                              icon: Image.asset(
                                  'assets/images/outdoor_plant.png'),
                              iconSize: 100,
                              onPressed: () {},
                            ),
                          ),
                          Container(
                            alignment: Alignment.topCenter,
                            child: const Text(
                              'Outdoor',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.only(left: 35.0),
                  ),
                  Container(
                    margin: const EdgeInsets.all(7.0),
                    padding: const EdgeInsets.only(top: 10.0),
                    // color: Colors.red,
                    height: size.height * 0.050,
                    child: const Text(
                      'List of the plants',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              //Testing phase for ListView Google cloud http GET request
              Container(
                padding: const EdgeInsets.all(6.0),
                margin: const EdgeInsets.only(left: 13.0, right: 13.0),
                //color: Colors.grey,
                height: size.height * 0.4,
                child: FutureBuilder<List<PlantItem>>(
                  future: plantsfuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasData) {
                      final plants = snapshot.data!;
                      return buildPlants(plants);
                    } else if (snapshot.hasError) {
                      return Text('Data error ${snapshot.error}');
                    } else {
                      return const Text('No Plant data.');
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
