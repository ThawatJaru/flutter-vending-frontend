import 'dart:convert';

import 'package:automated_ios/home_screen.dart';
import 'package:automated_ios/payment_screen.dart';
import 'package:automated_ios/plant_item.dart';
import 'package:flutter/material.dart';

class DescriptionPage extends StatefulWidget {
  final PlantItem plant;
  const DescriptionPage({Key? key, required this.plant}) : super(key: key);

  @override
  State<DescriptionPage> createState() => _DescriptionPage();
}

//class description
class _DescriptionPage extends State<DescriptionPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
              Container(
                padding: const EdgeInsets.all(10.0),
                child: IconButton(
                  icon: const Icon(Icons.arrow_back_ios,
                      color: Colors.black, size: 30.0),
                  onPressed: () => Navigator.of(context).pop(
                    const HomeScreen(),
                  ),
                ),
              ),
            ]),
            const Padding(
              padding: EdgeInsets.only(top: 1.0),
            ),
            //Name Plant description page
            Text(
              widget.plant.name,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 40,
                  fontWeight: FontWeight.bold),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 20.0),
            ),
            //Picture plant in description page
            SizedBox(
              //color: Colors.red,
              width: size.width * 0.4,
              height: size.height * 0.5,
              child: ClipRRect(
                child: widget.plant.image.isNotEmpty
                    ? Image.memory(base64Decode(widget.plant.image), //from Json
                        fit: BoxFit.cover)
                    : Image.asset(
                        'assets/images/plant_outdoor_ex.jpg'), //testing only
              ),
            ),
            Row(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.only(left: 50.0, top: 23.0),
                  child: Text(
                    widget.plant.name,
                    textAlign: TextAlign.start,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 35.0,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            //Test Description
            Container(
              margin: const EdgeInsets.only(top: 8.0, left: 50.0, right: 20.0),
              //color: Colors.brown,r
              height: size.height * 0.2,
              width: size.width,
              child: Column(
                children: <Widget>[
                  Flexible(
                    child: SizedBox(
                      //color: Colors.red,
                      width: size.width,
                      height: size.height * 0.1,
                      child: SingleChildScrollView(
                        child: Text(
                          widget.plant.description,
                          textAlign: TextAlign.start,
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 22,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      const Text(
                        'Type: ',
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            fontStyle: FontStyle.normal),
                      ),
                      //Description plant type
                      Text(
                        widget.plant.category,
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.only(),
                        //color: Colors.blue,
                        width: size.width * 0.3,
                        height: size.height * 0.08,
                        child: Column(
                          children: <Widget>[
                            Container(
                              padding: const EdgeInsets.only(left: 70.0),
                              child: const Text(
                                'Price',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 20.0,
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            //Price Description page
                            Container(
                              padding:
                                  const EdgeInsets.only(left: 70.0, top: 5.0),
                              child: Text(
                                '${widget.plant.price} Baht',
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 22.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 120.0),
                        //color: Colors.blue,
                        width: size.width * 0.18,
                        height: size.height * 0.09,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.tealAccent[400],
                            shape: const StadiumBorder(),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const PaymentPage(),
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
