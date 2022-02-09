import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:intl/intl.dart';

class OfferPage extends StatelessWidget {
  const OfferPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var now = DateTime.now();
    now = now.add(const Duration(days: 7));
    final date = DateFormat('dd-MMM').format(now);

    return Container(
      width: double.infinity,
      height: 100,
      decoration: BoxDecoration(
          border: Border.all(
            color: Colors.yellowAccent,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(100))),
      child: Card(
        color: Colors.yellowAccent,
        elevation: 5,
        child: ListTile(
          title: Text(
            'Offers on Selected Cards',
            style: TextStyle(
              color: Colors.blue[900],
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            'Valid till $date',
            style: const TextStyle(
              color: Colors.red,
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }
}
