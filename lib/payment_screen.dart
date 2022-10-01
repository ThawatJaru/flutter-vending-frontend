import 'package:automated_ios/home_screen.dart';
import 'package:flutter/material.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPage();
}

//class description
class _PaymentPage extends State<PaymentPage> {
  bool showQRCode = true;
  bool showConfirmPayment = false;
  bool showArrowQRPaymentPage = true;
  bool showArrowConfirmPaymentPage = false;
  @override
  Widget build(BuildContext context) {
    //Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: PaymentPage(),
      ),
    );
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HomeScreen(),
                    ),
                  );
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
        showConfirmMessageView();
      },
      child: const Text('Press Button'),
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
            margin: const EdgeInsets.only(top: 25.0),
            color: Colors.grey,
            width: size.width * 0.55,
            height: size.height * 0.55,
            //Testing QR code from webserver
            child: Container(
              margin: const EdgeInsets.all(40.0),
              color: Colors.white,
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
          const Text(
            '200 Baht',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.black,
                fontSize: 45.0,
                fontWeight: FontWeight.bold),
          ),
          TestButton()
        ],
      ),
    );
  }
}
