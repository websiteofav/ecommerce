import 'package:ecommerce/products_display/screens/sub_category.dart';
import 'package:ecommerce/utils/device_dimensions.dart';
import 'package:ecommerce/utils/images.dart';
import 'package:ecommerce/widgets/category_app_bar.dart';
import 'package:flutter/material.dart';

class AllCategories extends StatelessWidget {
  const AllCategories({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var ind = -1;
    final dimensions = deviceDimensions(context);
    return Scaffold(
        backgroundColor: Colors.blue[50],
        appBar: const PreferredSize(
          child: CategoryAppBar(
            category: 'All Categories',
          ),
          preferredSize: Size.fromHeight(55.0),
        ),
        body: Container(
          margin: const EdgeInsets.all(15),
          child: ListView.builder(
              itemCount: 3,
              itemBuilder: (context, i) {
                ind = ind + 2;
                String ind2 = ind.toString();
                return Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        // Navigator.pushNamed(context, '/subCategory',
                        //     arguments: {
                        //       'category': AllCategory.categoryImagesName[ind2]
                        //     });

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SubCategory(
                                  category:
                                      AllCategory.categoryImagesName[ind2] ??
                                          '')),
                        );
                      },
                      child: Column(
                        children: [
                          SizedBox(
                            width: dimensions[1] * 0.5 - 25,
                            height: dimensions[0] * 0.3,
                            child: FittedBox(
                              fit: BoxFit.fill,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(100.0),
                                child: Image.asset(
                                  AllCategory.categoryImages[ind2].toString(),
                                ),
                              ),
                            ),
                          ),
                          Text(
                            AllCategory.categoryImagesName[ind2].toString(),
                            style: const TextStyle(
                                color: Colors.black87,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      children: [
                        SizedBox(
                          width: dimensions[1] * 0.5 - 25,
                          height: dimensions[0] * 0.3,
                          child: FittedBox(
                            fit: BoxFit.fill,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100.0),
                              child: Image.asset(
                                AllCategory.categoryImages[(ind + 1).toString()]
                                    .toString(),
                              ),
                            ),
                          ),
                        ),
                        Text(
                          AllCategory.categoryImagesName[(ind + 1).toString()]
                              .toString(),
                          style: const TextStyle(
                              color: Colors.black87,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ],
                );
              }),
        ));
  }
}
