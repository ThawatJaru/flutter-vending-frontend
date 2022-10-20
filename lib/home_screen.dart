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
    var url = '$PLANT_HOST/plant';
    final response =
        await http.get(Uri.parse(url)); //receiving URL http get Request
    final data = json.decode(response.body); //decoding json
    List<PlantItem> PlantItems = []; //empty list
    //add each item into empty list for displaying it in UI
    //for (int i = 0; i < 30; i++) {
    for (var p in data) {
      print(p['image']);
      //condition no description
      p['description'] = p['description'] ?? 'No Description Available';
      //condition no picture
      p['image'] = p['image'] ??
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
              p['category'], p['picture'], p['image']);
        } else {
          if (searchCategory == 1 && p['category'] == 'Indoor') {
            //Indoor
            plantItem = PlantItem(p['id'], p['name'], p['description'],
                p['category'], p['image'], p['price']);
          } else if (searchCategory == 2 && p['category'] == 'Outdoor') {
            //Outdoor
            plantItem = PlantItem(p['id'], p['name'], p['description'],
                p['category'], p['image'], p['price']);
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
                                            child: item.image
                                                    .isNotEmpty // check if picture is not empty
                                                ? Image.memory(base64Decode(
                                                    "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"))
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
