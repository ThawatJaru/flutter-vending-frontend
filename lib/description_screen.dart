import 'package:automated_ios/home_screen.dart';
import 'package:automated_ios/payment_screen.dart';
import 'package:flutter/material.dart';

class DescriptionPage extends StatefulWidget {
  const DescriptionPage({super.key});

  @override
  State<DescriptionPage> createState() => _DescriptionPage();
}

//class description
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
            SizedBox(
              //color: Colors.red,
              width: size.width * 0.4,
              height: size.height * 0.5,
              child: ClipRRect(
                child: Image.asset('assets/images/plant_outdoor_ex.jpg'),
              ),
            ),
            Row(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.only(left: 50.0, top: 23.0),
                  child: const Text(
                    'Description',
                    textAlign: TextAlign.start,
                    style: TextStyle(
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
                      child: const Text(
                        'Round Cactus is the common name for a type of cactus best known for its round shape. Barrel cacti grow natively throughout Central Mexico and the Southwestern United States.',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 22,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                  Row(
                    children: const <Widget>[
                      Text(
                        'Type: ',
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            fontStyle: FontStyle.normal),
                      ),
                      //Description plant type
                      Text(
                        'Outdoor',
                        style: TextStyle(
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
                              child: const Text(
                                '200 Baht',
                                textAlign: TextAlign.center,
                                style: TextStyle(
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