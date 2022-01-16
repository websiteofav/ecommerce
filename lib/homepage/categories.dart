import 'dart:developer';

import 'package:ecommerce/utils/device_dimensions.dart';
import 'package:ecommerce/utils/images.dart';
import 'package:flutter/material.dart';

class Categories extends StatefulWidget {
  const Categories({Key? key}) : super(key: key);

  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
          children: List.generate(AllCategory.categoryImages.length, (i) {
        var index = i.toString();
        return GestureDetector(
          onTap: () {
            if (i == 0) {
              Navigator.pushNamed(context, '/allCategories');
            }
          },
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            alignment: Alignment.topCenter,
            height: 80,
            width: 100,
            decoration: const BoxDecoration(
                color: Colors.lightBlueAccent,
                border:
                    Border(right: BorderSide(color: Colors.black, width: 5))),
            child: Column(
              children: [
                Image.asset(
                  AllCategory.categoryImages[index].toString(),
                  height: 40,
                ),
                Text(
                  AllCategory.categoryImagesName[index].toString(),
                  style: const TextStyle(color: Colors.black, fontSize: 14),
                )
              ],
            ),
          ),
        );
      })),
    );
  }
}
