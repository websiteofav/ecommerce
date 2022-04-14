import 'dart:developer';

import 'package:ecommerce/widgets/message_pop_up.dart';
import 'package:flutter/cupertino.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class Payment {
  BuildContext context;
  Razorpay razorpay;
  Payment({required this.context, required this.razorpay});
  void handlerPaymentSuccess(PaymentSuccessResponse response) {
    validationAlert('Payment SuccessFull', from: 'Success', context: context);
  }

  void handlerPaymentError(PaymentFailureResponse response) {
    // log('GFalire ${response.code.toString()}');
    validationAlert('Payment Failure', from: 'Failure', context: context);
  }

  void handlerExternalWallet(ExternalWalletResponse response) {
    validationAlert('Payment SuccessFull', from: 'Success', context: context);
  }

  void openCheckout({price, name}) {
    var options = {
      "key": "rzp_test_tw2jElwPjXWxdY",
      "amount": (double.parse(price) * 100).toString(),
      "name": name,
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
}
