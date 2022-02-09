import 'dart:async';

import 'package:ecommerce/products_display/screens/all_products_display.dart';
import 'package:ecommerce/utils/device_dimensions.dart';
import 'package:ecommerce/utils/images.dart';
import 'package:ecommerce/widgets/category_app_bar.dart';
import 'package:flutter/material.dart';

class SubCategory extends StatefulWidget {
  const SubCategory({Key? key, required this.category}) : super(key: key);
  final String category;

  @override
  State<SubCategory> createState() => _SubCategoryState();
}

class _SubCategoryState extends State<SubCategory> {
  int _currentPage = 0;
  late Timer _timer;
  final PageController _pageController = PageController(
    initialPage: 0,
  );

  final ValueNotifier<int> _pageNotifier = ValueNotifier<int>(0);

  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 4), (Timer timer) {
      if (_currentPage < 5) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      WidgetsBinding.instance!.addPostFrameCallback((_) {
        if (_pageController.hasClients) {
          _pageController.animateToPage(
            _currentPage,
            duration: const Duration(milliseconds: 350),
            curve: Curves.easeIn,
          );
        }
      });
    });
  }

  void disposeAll() {
    super.dispose();
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    // final arg = ModalRoute.of(context)!.settings.arguments as Map;
    // var category = arg['category'];

    final dimensions = deviceDimensions(context);
    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: PreferredSize(
        child: CategoryAppBar(
          category: widget.category,
        ),
        preferredSize: const Size.fromHeight(55.0),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 15),
              color: Colors.yellow,
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Special Offer's on Mobile",
                    style: TextStyle(
                      color: Colors.brown[800],
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    width: 30,
                    child: Icon(
                      Icons.alarm_on_sharp,
                      color: Colors.red,
                      size: 30,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 200,
              child: PageView.builder(
                onPageChanged: (int index) => _pageNotifier.value = index,
                itemCount: Electronics.mobileImages.length,
                controller: _pageController,
                itemBuilder: (context, i) {
                  var index = i.toString();
                  return Column(children: [
                    Container(
                      alignment: Alignment.bottomRight,
                      width: double.infinity,
                      height: 200,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image:
                              AssetImage(Electronics.mobileImages[index] ?? ''),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Container(
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          '',
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  ]);
                },
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                vertical: 10,
              ),
              alignment: Alignment.center,
              color: Colors.yellow,
              height: 90,
              width: double.infinity,
              child: Column(
                children: [
                  Text(
                    'Your one Stop for all types of ${widget.category}',
                    style: const TextStyle(color: Colors.black, fontSize: 20),
                  ),
                  const Icon(
                    Icons.arrow_downward_rounded,
                    color: Colors.blue,
                    size: 40,
                  )
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(20),
              alignment: Alignment.center,
              child: Wrap(
                  spacing: 20,
                  children: List.generate(Electronics.electronicImages.length,
                      (index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AllProductDisplay(
                                    productCategory:
                                        Electronics.electronicImagesName[
                                                index.toString()] ??
                                            '',
                                  )),
                        );
                      },
                      child: Container(
                        width: dimensions[1] * 0.4,
                        height: 200,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: AssetImage(
                              Electronics.electronicImages[index.toString()] ??
                                  '',
                            ),
                          ),
                        ),
                        child: Text(
                          Electronics.electronicImagesName[index.toString()] ??
                              '',
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    );
                  })),
            )
          ],
        ),
      ),
    );
  }
}
