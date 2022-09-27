import 'package:automated_ios/home_screen.dart';
import 'package:flutter/material.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPage();
}

//class description
class _PaymentPage extends State<PaymentPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          toolbarHeight: 50.0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios,
                color: Colors.black, size: 20.0),
            onPressed: () => Navigator.of(context).pop(
              const HomeScreen(),
            ),
          ),
          // backgroundColor: Colors.green,
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              Container(
                color: Colors.red,
                width: 50,
                height: 50,
              )
            ],
          ),
        ));
  }
}
