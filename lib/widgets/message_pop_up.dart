import 'package:ecommerce/utils/device_dimensions.dart';
import 'package:flutter/material.dart';

validationAlert(BuildContext context, msg, from) {
  final dimesions = deviceDimensions(context);
  // Create button
  Widget okButton = TextButton(
    child: const Text("OK"),
    onPressed: () {
      FocusScopeNode currentFocus = FocusScope.of(context);

      if (!currentFocus.hasPrimaryFocus) {
        currentFocus.unfocus();
      }
      Navigator.of(context).pop();
    },
  );

  // Create AlertDialog
  AlertDialog alert = AlertDialog(
    backgroundColor: Colors.white,
    title: const Text(
      "Alert",
      style: TextStyle(color: Colors.black, fontSize: 24),
    ),
    content:
        Text(msg, style: const TextStyle(color: Colors.black, fontSize: 20)),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    barrierDismissible: true,
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
