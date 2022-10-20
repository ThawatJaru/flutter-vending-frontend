import 'dart:async';
import 'dart:convert';
import 'package:automated_ios/description_screen.dart';
import 'package:automated_ios/main.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:automated_ios/plant_item.dart';
import 'package:flutter/services.dart';
import 'dart:developer';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  TextEditingController searchPlant = TextEditingController();
  int searchCategory = 0;

  Future<List<PlantItem>> getPlants() async {
    var url = '$PLANT_HOST/plants';
    final response =
        await http.get(Uri.parse(url)); //receiving URL http get Request
    final data = json.decode(response.body); //decoding json
    List<PlantItem> PlantItems = []; //empty list
    //add each item into empty list for displaying it in UI
    //for (int i = 0; i < 30; i++) {
    for (var p in data) {
      //condition no description
      p['description'] = p['description'] ?? 'No Description Available';
      //condition no picture
      p['picture'] = p['picture'] ??
          'https://mpics.mgronline.com/pics/Images/558000002578001.JPEG'; //Picture test for now
      try {
        late PlantItem plantItem;

        if (searchPlant.text.isNotEmpty) {
          if (!p['name']
              .toString()
              .toLowerCase()
              .contains(searchPlant.text.toLowerCase())) {
            continue; //if name doesn't match continue
          }
        }

        if (searchCategory <= 0) {
          //All Category
          plantItem = PlantItem(p['id'], p['name'], p['description'],
              p['category'], p['picture'], p['price']);
        } else {
          if (searchCategory == 1 && p['category'] == 'Indoor') {
            //Indoor
            plantItem = PlantItem(p['id'], p['name'], p['description'],
                p['category'], p['picture'], p['price']);
          } else if (searchCategory == 2 && p['category'] == 'Outdoor') {
            //Outdoor
            plantItem = PlantItem(p['id'], p['name'], p['description'],
                p['category'], p['picture'], p['price']);
          }
        }
        PlantItems.add(plantItem);
      } catch (e) {
        log('err: $e');
      }
    }
    //}
    print(PlantItems.length);
    return PlantItems;
  }

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: []); //show only flutter screen
    searchPlant.text = '';
  }

  @override
  void dispose() {
    searchPlant.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.fromLTRB(5.0, 20.0, 5.0, 5.0),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.only(left: 25.0),
                  // color: Colors.red,
                  // height: size.height * 0.1,
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
              padding: EdgeInsets.only(top: 15.0),
            ),
            Container(
              // color: Colors.red,
              alignment: Alignment.center,
              padding: const EdgeInsets.all(3.0),
              margin: const EdgeInsets.only(left: 25),
              child: Row(
                children: [
                  SizedBox(
                    width: size.width * 0.9,
                    height: size.height * 0.05,
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
                      onChanged: (String val) => setState(() {}),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        searchCategory = 0;
                        searchPlant.clear(); //refresh or delete your search
                      });
                    },
                    icon: const Icon(
                      Icons.clear_sharp,
                      size: 36.0,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 18.0),
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
                    color: searchCategory == 0
                        ? Colors.green.shade100
                        : Colors.transparent,
                    child: Column(
                      children: <Widget>[
                        Container(
                          // color: Colors.black,
                          margin: const EdgeInsets.only(bottom: 5.0),
                          alignment: Alignment.topCenter,
                          width: size.width * 0.2,
                          height: size.height * 0.13,
                          child: IconButton(
                            icon:
                                Image.asset('assets/images/all_plant_144.png'),
                            iconSize: 100,
                            onPressed: () {
                              setState(() {
                                searchCategory = 0;
                              });
                            },
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
                    color: searchCategory == 1
                        ? Colors.green.shade100
                        : Colors.transparent,
                    child: Column(
                      children: <Widget>[
                        Container(
                          margin: const EdgeInsets.only(bottom: 5.0),
                          alignment: Alignment.topCenter,
                          width: size.width * 0.2,
                          height: size.height * 0.13,
                          child: IconButton(
                            icon: Image.asset('assets/images/indoor_plant.png'),
                            iconSize: 100,
                            onPressed: () {
                              setState(() {
                                searchCategory = 1;
                              });
                            },
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
                    color: searchCategory == 2
                        ? Colors.green.shade100
                        : Colors.transparent,
                    child: Column(
                      children: <Widget>[
                        Container(
                          margin: const EdgeInsets.only(bottom: 5.0),
                          alignment: Alignment.topCenter,
                          width: size.width * 0.2,
                          height: size.height * 0.13,
                          child: IconButton(
                            icon:
                                Image.asset('assets/images/outdoor_plant.png'),
                            iconSize: 100,
                            onPressed: () {
                              setState(() {
                                searchCategory = 2;
                              });
                            },
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
                  margin: const EdgeInsets.fromLTRB(7.0, 25.0, 7.0, 0.0),
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
              margin: const EdgeInsets.only(left: 13.0, right: 13.0, top: 0.0),
              // color: Colors.grey,
              height: size.height * 0.4,
              child: FutureBuilder(
                future: getPlants(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                        child: CircularProgressIndicator(
                      color: Colors.green,
                    ));
                  } else if (snapshot.hasData) {
                    final plants = snapshot.data!;
                    if (plants.length > 0) {
                      return ListView.builder(
                        primary: true,
                        itemCount: plants.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          PlantItem item = plants[index];
                          return Column(
                            children: <Widget>[
                              ClipRRect(
                                borderRadius: BorderRadius.circular(50.0),
                                child: Container(
                                  height: size.height * 0.37,
                                  width: size.width * 0.32,
                                  margin: const EdgeInsets.fromLTRB(
                                    5.0,
                                    5.0,
                                    15.0,
                                    5.0,
                                  ),
                                  color: Colors.grey.shade300,
                                  child: Column(
                                    children: <Widget>[
                                      ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(40.0),
                                        child: Container(
                                          //alignment: Alignment.center,
                                          height: size.height * 0.030,
                                          width: size.width * 0.13,
                                          margin: const EdgeInsets.all(10),
                                          color: Colors.grey[50],
                                          child: Text(item.category,
                                              textAlign: TextAlign.center,
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold)),
                                        ),
                                      ),
                                      //Test Image
                                      Container(
                                        margin: const EdgeInsets.all(3.0),
                                        // color: Colors.red,
                                        width: size.width * 0.12,
                                        height: size.height * 0.19,
                                        child: ClipRRect(
                                          child: FittedBox(
                                            fit: BoxFit.fill,
                                            child: item.picture
                                                    .isNotEmpty // check if picture is not empty
                                                ? Image.network(
                                                    item.picture, //if have picture from json
                                                  )
                                                : Image.asset(
                                                    'assets/images/plant_outdoor_ex.jpg'), // test image from website
                                          ),
                                        ),
                                      ),
                                      //Test Plant Price and Name
                                      ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(40.0),
                                        child: Container(
                                          margin: const EdgeInsets.only(
                                            left: 10,
                                            right: 10,
                                            top: 10.0,
                                          ),
                                          color: Colors.white,
                                          width: size.width * 15,
                                          height: size.height * 0.09,
                                          child: Row(
                                            children: <Widget>[
                                              const Padding(
                                                padding:
                                                    EdgeInsets.only(left: 7.0),
                                              ),
                                              Column(
                                                //remove the constant also!
                                                children: <Widget>[
                                                  Text(
                                                    item.name,
                                                    textAlign: TextAlign.start,
                                                    style: const TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 18.0,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontStyle:
                                                          FontStyle.normal,
                                                    ),
                                                  ),
                                                  const Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 4.0, top: 10.0),
                                                  ),
                                                  Text(
                                                    '${item.price} Baht',
                                                    textAlign: TextAlign.center,
                                                    style: const TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 22.0,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                              //Button
                                              Container(
                                                margin: const EdgeInsets.only(
                                                    left: 30.0),
                                                height: size.height * 0.07,
                                                width: size.width * 0.13,
                                                child: ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        Colors.tealAccent[400],
                                                    shape:
                                                        const StadiumBorder(),
                                                  ),
                                                  onPressed: () {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            DescriptionPage(
                                                                plant:
                                                                    item), //pass data plant[Item]
                                                      ),
                                                    );
                                                  },
                                                  child: const Text(
                                                    'Checkout',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontSize: 20.0,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontStyle:
                                                            FontStyle.normal),
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
                          );
                        },
                      );
                    } else {
                      return const Center(
                        child: Text(
                          'The product you searched for was not found.\nPlease type your product again',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 32.0,
                            color: Colors.red,
                            // fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
                    }
                  } else if (snapshot.hasError) {
                    //print(snapshot);
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
    );
  }
}
