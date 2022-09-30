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
  @override
  Widget build(BuildContext context) {
    //Size size = MediaQuery.of(context).size;
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
        child: PaymentPage(),
      ),
    );
  }

  //Show paymentPage true --> false
  void showConfirmMessageView() {
    setState(() {
      showQRCode = false; //unshow this one
      showConfirmPayment = true; //show this one
    });
  }

  //Payment Page
  // ignore: non_constant_identifier_names
  Widget PaymentPage() {
    Size size = MediaQuery.of(context).size;
    return Visibility(
      visible: showQRCode, //show QR code page
      child: Column(
        children: <Widget>[
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
        ],
      ),
    );
  }
}
