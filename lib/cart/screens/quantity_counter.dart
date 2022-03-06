import 'package:ecommerce/utils/device_dimensions.dart';
import 'package:flutter/material.dart';

class QuantityCounter extends StatefulWidget {
  const QuantityCounter({Key? key}) : super(key: key);

  @override
  State<QuantityCounter> createState() => _QuantityCounterState();
}

class _QuantityCounterState extends State<QuantityCounter> {
  int counter = 1;
  @override
  Widget build(BuildContext context) {
    final dimensions = deviceDimensions(context);
    return SizedBox(
      width: dimensions[1] * 0.4,
      child: Card(
        color: Colors.blueGrey,
        elevation: 1.0,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              _decrementButton(2),
              Text(
                counter.toString(),
                style: const TextStyle(
                  fontSize: 24.0,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              _incrementButton(1),
            ],
          ),
        ),
      ),
    );
  }

  Widget _incrementButton(int index) {
    return FloatingActionButton(
      heroTag: Text('increase'),
      child: const Icon(Icons.add_circle, color: Colors.black87),
      backgroundColor: Colors.white,
      onPressed: () {
        setState(() {
          counter = counter + 1;
        });
      },
    );
  }

  Widget _decrementButton(int index) {
    return FloatingActionButton(
        heroTag: Text('decrease'),
        onPressed: () {
          setState(() {
            if (counter > 1) {
              counter = counter - 1;
            }
          });
        },
        child: const Icon(Icons.do_not_disturb_on, color: Colors.black87),
        backgroundColor: Colors.white);
  }
}
