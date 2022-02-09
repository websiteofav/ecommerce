import 'package:ecommerce/utils/device_dimensions.dart';
import 'package:flutter/material.dart';

class SearchBar extends StatefulWidget {
  const SearchBar({Key? key}) : super(key: key);

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  @override
  Widget build(BuildContext context) {
    final dimensions = deviceDimensions(context);

    return Container(
      color: Colors.blue,
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      height: 100,
      child: TextField(
        onChanged: (value) {
          if (value.toString().trim().length > 2) {}
        },
        style: const TextStyle(color: Colors.blue),
        decoration: const InputDecoration(
          fillColor: Colors.grey,
          filled: true,
          hintText: 'Search...',
          hintStyle: TextStyle(fontWeight: FontWeight.bold),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            // width: 0.0 produces a thin "hairline" border
            borderSide: BorderSide(
                color: Colors.black, width: 1.0, style: BorderStyle.solid),
          ),
        ),
      ),
    );
  }
}
