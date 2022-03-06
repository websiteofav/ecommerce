import 'package:flutter/material.dart';

class PWATEst extends StatefulWidget {
  const PWATEst({Key? key}) : super(key: key);

  @override
  _PWATEstState createState() => _PWATEstState();
}

class _PWATEstState extends State<PWATEst> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        titleSpacing: size.width * 0.1,
        backgroundColor: Colors.blue,
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
        title: const Text(
          'Test',
          style: TextStyle(color: Colors.white),
        ),
        actions: const [
          IconButton(
            onPressed: null,
            icon: Icon(
              Icons.notifications,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Wrap(
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              width: 300,
              height: size.height,
              color: Colors.black,
            ),

            Container(
              height: size.height,
              width: 300,
              color: Colors.red,
            ),
            Container(
              width: 300,
              color: Colors.yellow,
              height: size.height,
            ),
            //    Container(
            //    width: size.width * 0.2,
            //    color:  Colors.amberAccent,
            //  ),
          ],
        ),
      ),
    );
  }
}
