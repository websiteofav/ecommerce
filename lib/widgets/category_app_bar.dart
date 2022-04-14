import 'package:badges/badges.dart';
import 'package:ecommerce/cart/bloc/cart_bloc.dart';
import 'package:ecommerce/cart/screens/cart.dart';
import 'package:ecommerce/utils/device_dimensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryAppBar extends StatefulWidget {
  final String category;
  const CategoryAppBar({Key? key, required this.category}) : super(key: key);

  @override
  State<CategoryAppBar> createState() => _CategoryAppBarState();
}

class _CategoryAppBarState extends State<CategoryAppBar> {
  String cartCount = '';

  @override
  void initState() {
    BlocProvider.of<CartBloc>(context).add(TotalCartItemsEvent());
  }

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
        widget.category,
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
        widget.category.contains('Cart')
            ? const Text('')
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: Badge(
                  alignment: Alignment.topLeft,
                  badgeContent: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: BlocListener<CartBloc, CartState>(
                      listener: (context, state) {
                        if (state is TotalCartItemLoaded) {
                          setState(() {
                            cartCount = state.items;
                          });
                        }
                      },
                      child: Text(
                        cartCount,
                        style: const TextStyle(fontSize: 15),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ),
                  borderRadius: BorderRadius.circular(8),
                  child: IconButton(
                      icon: const Icon(
                        Icons.shopping_cart,
                        color: Colors.white,
                        size: 35,
                      ),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const Cart()));
                      }),
                ),
              ),
      ],
    );
  }
}
