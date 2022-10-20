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
                    ? Image.memory(base64Decode(
                        "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"))
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
