import 'dart:async';

import 'package:ecommerce/utils/device_dimensions.dart';
import 'package:ecommerce/utils/images.dart';
import 'package:flutter/material.dart';
import 'package:page_view_indicators/circle_page_indicator.dart';

class ElectronicsAutoScroll extends StatefulWidget {
  const ElectronicsAutoScroll({Key? key}) : super(key: key);

  @override
  _ElectronicsAutoScrollState createState() => _ElectronicsAutoScrollState();
}

class _ElectronicsAutoScrollState extends State<ElectronicsAutoScroll> {
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

      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeIn,
      );
    });
  }

  void disposeAll() {
    super.dispose();
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 200,
          width: double.infinity,
          child: PageView.builder(
            onPageChanged: (int index) => _pageNotifier.value = index,
            itemCount: Electronics.electronicImages.length,
            controller: _pageController,
            itemBuilder: (context, i) {
              var index = i.toString();
              return Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image:
                        AssetImage(Electronics.electronicImages[index] ?? ''),
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
          ),
        ),
        _buildCircleIndicator7()
      ],
    );
  }

  Widget _buildCircleIndicator7() {
    final dimensions = deviceDimensions(context);

    return Container(
      width: double.infinity,
      height: 20,
      color: Colors.black54,
      child: CirclePageIndicator(
        dotSpacing: dimensions[1] * 0.8 / Electronics.electronicImages.length,
        size: 8.0,
        selectedSize: 15.0,
        selectedDotColor: Colors.white,
        dotColor: Colors.grey,
        itemCount: Electronics.electronicImages.length,
        currentPageNotifier: _pageNotifier,
      ),
    );
  }
}
