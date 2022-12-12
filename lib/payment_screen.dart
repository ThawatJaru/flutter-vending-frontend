import 'dart:convert';

import 'package:automated_ios/home_screen.dart';
import 'package:automated_ios/main.dart';
import 'package:automated_ios/plant_image.dart';
import 'package:automated_ios/plant_item.dart';
import 'package:automated_ios/plant_statement.dart';
import 'package:flutter/material.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:http/http.dart' as http;

PlantItem current_plant = new PlantItem("", "", "", "", new PlantImage(""), 0);
String statement_id = "";
bool statement_confirm = true;

class PaymentPage extends StatefulWidget {
  final PlantStatement statement;
  final PlantItem plant;
  PaymentPage({super.key, required this.statement, required this.plant}) {
    current_plant = plant;
    statement_id = this.statement.statement_id;
    statement_confirm = false;
  }

  @override
  State<PaymentPage> createState() => _PaymentPage();
}

/////////////////////////////

//class description
class _PaymentPage extends State<PaymentPage> {
  String paypalTelNumber = "0970638685";
  String paypalPrice = current_plant.price.toString();

  bool showQRCode = true;
  bool showConfirmPayment = false;
  bool showArrowQRPaymentPage = true;
  bool showArrowConfirmPaymentPage = false;

  @override
  Widget build(BuildContext context) {
    //Size size = MediaQuery.of(context).size;
    if (statement_confirm == false) MqttConnection();
    return Scaffold(
      body: Center(
        child: PaymentPage(),
      ),
    );
  }

  //////////////////////////////////////////

  Future MqttConnection() async {
    MqttServerClient client = MqttServerClient.withPort(
        "projecttech.thddns.net", "flutter-client", 5052);
    //MqttServerClient client = MqttServerClient("localhost", "flutter-client");
    //client.logging(on: true);

    client.onConnected = onConnected;
    client.onDisconnected = onDisconnected;
    client.onUnsubscribed = onUnsubscribed;
    client.onSubscribed = onSubscribed;
    client.onSubscribeFail = onSubscribeFail;
    client.pongCallback = pong;
    client.keepAlivePeriod = 60;
    client.setProtocolV311();

    final connMessage = MqttConnectMessage()
        .withWillTopic('willtopic')
        .withWillMessage('Will message')
        .startClean()
        .withWillQos(MqttQos.atLeastOnce);

    print('MQTT_LOGS::Mosquitto client connecting....');

    // Try to Connect to broker
    try {
      await client.connect();
    } catch (e) {
      print('Exception: $e');
      client.disconnect();
    }

    if (client.connectionStatus!.state == MqttConnectionState.connected) {
      print('MQTT_LOGS::Mosquitto client connected');
    } else {
      print(
          'MQTT_LOGS::ERROR Mosquitto client connection failed - disconnecting, status is ${client.connectionStatus}');
      client.disconnect();
    }

    subscribeTopic(client);
  }

  void subscribeTopic(MqttServerClient client) {
    print('MQTT_LOGS::Subscribing to the test topic');
    const topic = 'statement_confirm';
    client.subscribe(topic, MqttQos.atMostOnce);

    client.updates!.listen((List<MqttReceivedMessage<MqttMessage?>>? c) {
      final recMess = c![0].payload as MqttPublishMessage;
      final pt =
          MqttPublishPayload.bytesToStringAsString(recMess.payload.message);

      print(
          'MQTT_LOGS:: New data arrived: topic is <${c[0].topic}>, payload is $pt');
      print('');

      // Json Decode
      final pt1 = json.decode(pt);

      // Statement get confirmed
      if (pt1['statement_id'] == statement_id) {
        showConfirmMessageView();
        statement_confirm = true;
        client.disconnect();
      }
    });
  }

  /////////////////////////////
  ////// Callback Preset //////

  void onConnected() {
    print('MQTT_LOGS:: Connected');
  }

  void onDisconnected() {
    print('MQTT_LOGS:: Disconnected');
  }

  void onSubscribed(String topic) {
    print('MQTT_LOGS:: Subscribed topic: $topic');
  }

  void onSubscribeFail(String topic) {
    print('MQTT_LOGS:: Failed to subscribe $topic');
  }

  void onUnsubscribed(String? topic) {
    print('MQTT_LOGS:: Unsubscribed topic: $topic');
  }

  void pong() {
    print('MQTT_LOGS:: Ping response client callback invoked');
  }

  //Show paymentPage true --> false
  void showConfirmMessageView() {
    setState(
      () {
        showQRCode = false; //unshow this one
        showConfirmPayment = true; //show this one
        showArrowQRPaymentPage = true; //show this one arrow back
        showArrowConfirmPaymentPage =
            false; //show this one arrow back false in Confirm page
      },
    );
  }

  //Payment Page (QR and Confirm)
  // ignore: non_constant_identifier_names
  Widget PaymentPage() {
    return Column(
      children: <Widget>[
        QRPage(),
        ConfirmPaymentPage(),
      ],
    );
  }

  // ignore: non_constant_identifier_names
  Widget ConfirmPaymentPage() {
    Size size = MediaQuery.of(context).size;
    return Visibility(
      visible: showConfirmPayment,
      child: Column(
        //mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.only(top: 250.0),
          ),
          Container(
            padding: const EdgeInsets.all(6.0),
            //color: Colors.red,
            height: size.height * 0.2,
            width: size.width * 0.6,
            child: Text(
              'Thank you for purchasing with us',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.tealAccent[400],
                  fontSize: 50.0,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.normal),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 30.0),
          ),
          SizedBox(
            //color: Colors.red,
            width: size.width * 0.7,
            height: size.height * 0.2,
            child: const Text(
              'Your plant is now ready for you. The door will now open for you  and you may retrieve your plants. We are glad to be in your service.',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20.0,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w500),
            ),
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            Container(
              padding: const EdgeInsets.all(3.0),
              width: size.width * 0.27,
              height: size.height * 0.15,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.tealAccent[400],
                  shape: const StadiumBorder(),
                ),
                child: const Text(
                  'Return to Home Page',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold),
                ),
                onPressed: () {
                  setState(() {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomeScreen(),
                      ),
                    );
                  });
                },
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 70.0),
            ),
            SizedBox(
              width: size.width * 0.12,
              height: size.height * 0.19,
              child: ClipRRect(
                child: FittedBox(
                  fit: BoxFit.fill,
                  child: Image.asset('assets/images/flower_cartoon.jpg'),
                ),
              ),
            ),
          ]),
        ],
      ),
    );
  }

  //Testing for Confirm Payment button for setState, Not Used in Real project!
  // ignore: non_constant_identifier_names
  Widget TestButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(backgroundColor: Colors.lightBlue),
      onPressed: () {
        notify_payment();
      },
      child: const Text('Notify'),
    );
  }

  //QR Page
  // ignore: non_constant_identifier_names
  Widget QRPage() {
    Size size = MediaQuery.of(context).size;
    return Visibility(
      visible: showQRCode, //show QR code page
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
            padding: EdgeInsets.only(bottom: 40.0),
          ),
          const Text(
            'Scan the QR code',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 40.0,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 15.0),
            color: Colors.grey,
            width: size.width * 0.40,
            height: size.height * 0.60,
            //Testing QR code from webserver
            child: Container(
              margin: const EdgeInsets.all(30.0),
              //color: Colors.white,
              decoration: new BoxDecoration(
                shape: BoxShape.rectangle,
                image: new DecorationImage(
                  fit: BoxFit.fill,
                  image: new NetworkImage("https://promptpay.io/" +
                      paypalTelNumber +
                      "/" +
                      paypalPrice +
                      ".png"),
                ),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 14.0),
          ),
          Text(
            'Price',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.grey[500],
                fontSize: 30,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.normal),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 3.0),
          ),
          //Text Price payment Test
          Text(
            current_plant.price.toString() + ' Baht',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.black,
                fontSize: 45.0,
                fontWeight: FontWeight.bold),
          ),
          TestButton(),
        ],
      ),
    );
  }

  // Post Request --> notify
  // Body: {
  //    "statement_id": UUID
  // }
  // return "Success"
  dynamic notify_payment() async {
    var url = '$PLANT_HOST/statement_confirm';
    final response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{'statement_id': statement_id}),
    );

    return response.statusCode;
  }
}
