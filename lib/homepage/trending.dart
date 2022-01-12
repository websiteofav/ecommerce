import 'package:ecommerce/utils/device_dimensions.dart';
import 'package:ecommerce/utils/images.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Trending extends StatelessWidget {
  const Trending({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dimensions = deviceDimensions(context);
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(color: Colors.blueAccent, width: 15),
        ),
      ),
      child: Column(
        children: [
          Container(
            height: 50,
            color: Colors.yellow,
            width: double.infinity,
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Today's Special Offer's",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.blue[900],
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Icon(
                  Icons.star_rate_sharp,
                  color: Colors.blue,
                  size: 50,
                )
              ],
            ),
          ),
          Row(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                      padding: const EdgeInsets.all(10),
                      alignment: Alignment.bottomCenter,
                      height: dimensions[0] * 0.3,
                      width: dimensions[1] * 0.5,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white),
                        image: DecorationImage(
                          image: AssetImage(Fashion.fashionImages['1'] ?? ''),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          text: Fashion.fashionImagesName['1'] ?? '',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.blueGrey[900],
                              backgroundColor: Colors.white),
                          children: const <TextSpan>[
                            TextSpan(
                              text: '  upto 20% Off',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red,
                                  fontSize: 18),
                            ),
                          ],
                        ),
                      )),
                  Container(
                      padding: const EdgeInsets.all(10),
                      alignment: Alignment.bottomCenter,
                      height: dimensions[0] * 0.3,
                      width: dimensions[1] * 0.5,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        image: DecorationImage(
                          image: AssetImage(Beauty.beautyImages['1'] ?? ''),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          text: Beauty.beautyImagesName['1'] ?? '',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.blueGrey[900],
                              backgroundColor: Colors.white),
                          children: const <TextSpan>[
                            TextSpan(
                              text: '  upto 30% Off',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red,
                                  fontSize: 18),
                            ),
                          ],
                        ),
                      )),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                      padding: const EdgeInsets.all(10),
                      alignment: Alignment.bottomCenter,
                      height: dimensions[0] * 0.3,
                      width: dimensions[1] * 0.5,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        image: DecorationImage(
                          image: AssetImage(Sports.sportsImages['1'] ?? ''),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          text: Sports.sportsImagesName['1'] ?? '',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.blueGrey[900],
                              backgroundColor: Colors.white),
                          children: const <TextSpan>[
                            TextSpan(
                              text: '  upto 30% Off',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red,
                                  fontSize: 18),
                            ),
                          ],
                        ),
                      )),
                  Container(
                      padding: const EdgeInsets.all(10),
                      alignment: Alignment.bottomCenter,
                      height: dimensions[0] * 0.3,
                      width: dimensions[1] * 0.5,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        image: DecorationImage(
                          image: AssetImage(Grocery.groceryImages['1'] ?? ''),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          text: Grocery.groceryImagesName['1'] ?? '',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.blueGrey[900],
                              backgroundColor: Colors.white),
                          children: const <TextSpan>[
                            TextSpan(
                              text: '  upto 30% Off',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red,
                                  fontSize: 18),
                            ),
                          ],
                        ),
                      )),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
