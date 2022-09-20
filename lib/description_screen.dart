import 'package:flutter/material.dart';

class DescriptionPage extends StatefulWidget {
  const DescriptionPage({super.key});

  @override
  State<DescriptionPage> createState() => _DescriptionPage();
}

class _DescriptionPage extends State<DescriptionPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: Column(children: <Widget>[
          Container(
            color: Colors.red,
            width: size.width * 0.3,
            height: size.height * 0.2,
          ),
        ]),
      ),
    );
  }
}
