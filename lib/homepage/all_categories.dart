import 'dart:developer';

import 'package:ecommerce/utils/device_dimensions.dart';
import 'package:ecommerce/utils/images.dart';
import 'package:flutter/material.dart';

class AllCategories extends StatefulWidget {
  const AllCategories({Key? key}) : super(key: key);

  @override
  _AllCategoriesState createState() => _AllCategoriesState();
}

class _AllCategoriesState extends State<AllCategories> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
          children: List.generate(AllCategory.categoryImages.length, (i) {
        var index = i.toString();
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          alignment: Alignment.topCenter,
          height: 80,
          width: 100,
          decoration: const BoxDecoration(
              color: Colors.lightBlueAccent,
              border: Border(right: BorderSide(color: Colors.black, width: 5))),
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
        );
      })),
    );
  }
}
