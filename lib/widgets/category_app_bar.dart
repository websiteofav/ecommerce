import 'package:ecommerce/cart/screens/cart.dart';
import 'package:ecommerce/utils/device_dimensions.dart';
import 'package:flutter/material.dart';

class CategoryAppBar extends StatelessWidget {
  final String category;
  const CategoryAppBar({Key? key, required this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dimensions = deviceDimensions(context);
    return AppBar(
      titleSpacing: dimensions[1] * 0.1,
      backgroundColor: Colors.blue,
      titleTextStyle: const TextStyle(
        color: Colors.white,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
      title: Text(
        category,
        style: const TextStyle(color: Colors.white),
      ),
      actions: [
        const IconButton(
          onPressed: null,
          icon: Icon(
            Icons.notifications,
            color: Colors.white,
          ),
        ),
        category.contains('Cart')
            ? const Text('')
            : IconButton(
                icon: const Icon(Icons.shopping_cart, color: Colors.white),
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => const Cart()));
                })
      ],
    );
  }
}
