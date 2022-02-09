import 'dart:developer';

import 'package:ecommerce/products_display/model/mobile_response_model.dart';
import 'package:ecommerce/utils/images.dart';
import 'package:ecommerce/widgets/category_app_bar.dart';
import 'package:ecommerce/widgets/message_pop_up.dart';
import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class MobileProductDisplay extends StatefulWidget {
  MobileSuccessResponseModel product;
  String productCategory;
  MobileProductDisplay(
      {Key? key, required this.product, required this.productCategory})
      : super(key: key);

  @override
  State<MobileProductDisplay> createState() => _MobileProductDisplayState();
}

class _MobileProductDisplayState extends State<MobileProductDisplay> {
  late BuildContext ctx;
  late Razorpay razorpay;
  final int _currentIndex = 0;
  static const bottomNavigationBarTheme = BottomNavigationBarThemeData(
    backgroundColor: Colors.white,
    selectedIconTheme: IconThemeData(
      color: Colors.purple,
      size: 24,
    ),
    selectedLabelStyle: TextStyle(
      fontWeight: FontWeight.bold,
      color: Colors.black,
      fontSize: 20,
    ),
    selectedItemColor: Colors.black,
    unselectedIconTheme: IconThemeData(
      color: Colors.blue,
      size: 24,
    ),
    unselectedItemColor: Colors.black,
    unselectedLabelStyle: TextStyle(
      fontWeight: FontWeight.bold,
      color: Colors.black,
      fontSize: 20,
    ),

    // Uncommenting this changes the color of the title but not the icon
//    selectedItemColor: Colors.deepPurple,
//    unselectedItemColor: Colors.deepPurpleAccent,
  );

  @override
  void initState() {
    razorpay = Razorpay();
    super.initState();
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlerPaymentSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlerPaymentError);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handlerExternalWallet);
  }

  @override
  void dispose() {
    super.dispose();

    razorpay.clear();
  }

  void handlerPaymentSuccess(PaymentSuccessResponse response) {
    validationAlert(ctx, 'Payment SuccessFull', 'Success');
  }

  void handlerPaymentError(PaymentFailureResponse response) {
    // log('GFalire ${response.code.toString()}');
    validationAlert(ctx, 'Payment Failure', 'Failure');
  }

  void handlerExternalWallet(ExternalWalletResponse response) {
    validationAlert(ctx, 'Payment SuccessFull', 'Success');
  }

  void openCheckout() {
    var options = {
      "key": "rzp_test_tw2jElwPjXWxdY",
      "amount": (double.parse(widget.product.price) * 100).toString(),
      "name": widget.product.name,
      "description": "Payable Amount",
      "prefill": {
        "contact": "1234567890",
        "email": "test1@gmail.com",
      },
      "external": {
        "wallets": ["paytm"]
      }
    };

    try {
      razorpay.open(options);
    } catch (e) {
      log(e.toString());
    }
  }

  void bottomBarOnTap(index) {
    if (index == 0) {
      log('Same');
    } else {
      openCheckout();
    }
  }

  @override
  Widget build(BuildContext context) {
    // final dimensions = deviceDimensions(context);
    ctx = context;
    return Scaffold(
      bottomNavigationBar: Theme(
        data: Theme.of(context)
            .copyWith(bottomNavigationBarTheme: bottomNavigationBarTheme),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) => bottomBarOnTap(index),
          backgroundColor: Colors.greenAccent,
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart),
              label: 'Add to cart',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shop),
              label: 'Buy',
            ),
          ],
        ),
      ),
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        child: CategoryAppBar(
          category: widget.productCategory,
        ),
        preferredSize: const Size.fromHeight(55.0),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.topRight,
              child: const IconButton(
                onPressed: null,
                icon: Icon(
                  Icons.favorite,
                  color: Colors.grey,
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: 280,
              child: Image.asset(
                '${Electronics.mobileImagePath}${widget.product.image}.jpg',
                // height: 500,
                fit: BoxFit.fill,

                // width: 200,
                // fit: BoxFit.fill,
              ),
            ),
            Container(
              padding: const EdgeInsets.all(15),
              child: Text(
                widget.product.name,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(15.0),
              color: Colors.white,
              child: RichText(
                text: TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                      text: '₹ ${widget.product.realPrice.toString()}',
                      style: const TextStyle(
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough,
                          backgroundColor: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          letterSpacing: 1),
                    ),
                    TextSpan(
                      text: '   ₹ ${widget.product.price.toString()}',
                      style: const TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                    TextSpan(
                      text: '  (${widget.product.discount}% off)',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.green),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(15.0),
              child: const Text(
                'Key Highlights :',
                style: TextStyle(color: Colors.black, fontSize: 22),
              ),
            ),
            Container(
              height: 50,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.grey[300],
                  border:
                      const Border(bottom: BorderSide(color: Colors.black38))),
              padding: const EdgeInsets.all(15.0),
              child: Row(
                children: [
                  const Icon(
                    Icons.memory,
                    color: Colors.black,
                  ),
                  Text(
                    'RAM - 6GB',
                    style: TextStyle(color: Colors.blue[900], fontSize: 20),
                  )
                ],
              ),
            ),
            Container(
              height: 50,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.grey[300],
                  border:
                      const Border(bottom: BorderSide(color: Colors.black38))),
              padding: const EdgeInsets.all(15.0),
              child: Row(
                children: [
                  const Icon(
                    Icons.camera,
                    color: Colors.black,
                  ),
                  Text(
                    'Camera - ${widget.product.camera1}MP + ${widget.product.camera2}MP',
                    style: TextStyle(color: Colors.blue[900], fontSize: 20),
                  )
                ],
              ),
            ),
            Container(
              height: 50,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.grey[300],
                  border:
                      const Border(bottom: BorderSide(color: Colors.black38))),
              padding: const EdgeInsets.all(15.0),
              child: Row(
                children: [
                  const Icon(
                    Icons.mobile_friendly_sharp,
                    color: Colors.black,
                  ),
                  Text(
                    'Display - ${widget.product.displaySize} inch',
                    style: TextStyle(color: Colors.blue[900], fontSize: 20),
                  )
                ],
              ),
            ),
            Container(
              height: 50,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.grey[300],
                  border:
                      const Border(bottom: BorderSide(color: Colors.black38))),
              padding: const EdgeInsets.all(15.0),
              child: Row(
                children: [
                  const Icon(
                    Icons.battery_charging_full,
                    color: Colors.black,
                  ),
                  Text(
                    'Battery - ${widget.product.batteryCapicity} mAh',
                    style: TextStyle(color: Colors.blue[900], fontSize: 20),
                  )
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(15.0),
              child: const Text(
                'Other Details :',
                style: TextStyle(color: Colors.black, fontSize: 22),
              ),
            ),
            Container(
              height: 50,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.lime[100],
                  border:
                      const Border(bottom: BorderSide(color: Colors.black38))),
              padding: const EdgeInsets.only(
                left: 15.0,
                right: 50,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Network Type',
                    style: TextStyle(color: Colors.blue[900], fontSize: 20),
                  ),
                  Text(
                    widget.product.networkType,
                    style: TextStyle(color: Colors.blue[900], fontSize: 20),
                  )
                ],
              ),
            ),
            Container(
              height: 50,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.lime[100],
                  border:
                      const Border(bottom: BorderSide(color: Colors.black38))),
              padding: const EdgeInsets.only(
                left: 15.0,
                right: 50,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Storage',
                    style: TextStyle(color: Colors.blue[900], fontSize: 20),
                  ),
                  Text(
                    '${widget.product.internalStorage} GB',
                    style: TextStyle(color: Colors.blue[900], fontSize: 20),
                  )
                ],
              ),
            ),
            Container(
              height: 50,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.lime[100],
                  border:
                      const Border(bottom: BorderSide(color: Colors.black38))),
              padding: const EdgeInsets.only(
                left: 15.0,
                right: 50,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Operating System',
                    style: TextStyle(color: Colors.blue[900], fontSize: 20),
                  ),
                  Text(
                    widget.product.operatingSystem,
                    style: TextStyle(color: Colors.blue[900], fontSize: 20),
                  )
                ],
              ),
            ),
            Container(
              height: 50,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.lime[100],
                  border:
                      const Border(bottom: BorderSide(color: Colors.black38))),
              padding: const EdgeInsets.only(
                left: 15.0,
                right: 50,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Primary Clock',
                    style: TextStyle(color: Colors.blue[900], fontSize: 20),
                  ),
                  Text(
                    '${widget.product.clockSpeed} GHz',
                    style: TextStyle(color: Colors.blue[900], fontSize: 20),
                  )
                ],
              ),
            ),
            Container(
              height: 50,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.lime[100],
                  border:
                      const Border(bottom: BorderSide(color: Colors.black38))),
              padding: const EdgeInsets.only(
                left: 15.0,
                right: 50,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Hybrid Sim',
                    style: TextStyle(color: Colors.blue[900], fontSize: 20),
                  ),
                  Text(
                    widget.product.hybridSimSlot ? 'Yes' : 'No',
                    style: TextStyle(color: Colors.blue[900], fontSize: 20),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
