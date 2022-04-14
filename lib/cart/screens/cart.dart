import 'package:ecommerce/cart/bloc/cart_bloc.dart';
import 'package:ecommerce/cart/models/cart_response_model.dart';
import 'package:ecommerce/cart/screens/quantity_counter.dart';
import 'package:ecommerce/utils/device_dimensions.dart';
import 'package:ecommerce/utils/images.dart';
import 'package:ecommerce/widgets/category_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Cart extends StatefulWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  String errorMessage = '';
  CartResponseModel? cartModel;

  @override
  void initState() {
    BlocProvider.of<CartBloc>(context).add(GetCartEvent());

    super.initState();
  }

//   static const bottomNavigationBarTheme = BottomNavigationBarThemeData(
//     backgroundColor: Colors.white,
//     selectedIconTheme: IconThemeData(
//       color: Colors.purple,
//       size: 24,
//     ),
//     selectedLabelStyle: TextStyle(
//       fontWeight: FontWeight.bold,
//       color: Colors.black,
//       fontSize: 20,
//     ),
//     selectedItemColor: Colors.black,
//     unselectedIconTheme: IconThemeData(
//       color: Colors.blue,
//       size: 24,
//     ),
//     unselectedItemColor: Colors.black,
//     unselectedLabelStyle: TextStyle(
//       fontWeight: FontWeight.bold,
//       color: Colors.black,
//       fontSize: 20,
//     ),

//     // Uncommenting this changes the color of the title but not the icon
// //    selectedItemColor: Colors.deepPurple,
// //    unselectedItemColor: Colors.deepPurpleAccent,
//   );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: bottomBar(),
        backgroundColor: Colors.blue[50],
        appBar: const PreferredSize(
          child: CategoryAppBar(
            category: 'Your Cart',
          ),
          preferredSize: Size.fromHeight(55.0),
        ),
        body: BlocListener<CartBloc, CartState>(
          listener: (context, state) {
            if (state is CartLoaded) {
              BlocProvider.of<CartBloc>(context).add(TotalCartItemsEvent());

              cartModel = state.model;
            } else if (state is CartError) {
              errorMessage = state.message;
            }
          },
          child: BlocBuilder<CartBloc, CartState>(
            builder: (context, state) {
              if (state is CartLoaded && cartModel != null) {
                return cartProducts();
              } else if (state is CartError) {
                return Container(
                  alignment: Alignment.center,
                  color: Colors.lightBlue,
                  child: Text(
                    state.message,
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                  ),
                );
              } else if (cartModel != null) {
                return cartProducts();
              } else {
                return Container(
                  alignment: Alignment.center,
                  child: const CircularProgressIndicator(),
                );
              }
            },
          ),
        ));
  }

  Widget bottomBar() {
    return Container(
      alignment: Alignment.center,
      height: 60,
      color: Colors.lightBlue,
      child: InkWell(
        onTap: () => null,
        child: const Text(
          'Place Order for All',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
    );
  }

  Widget cartProducts() {
    final dimensions = deviceDimensions(context);

    return SizedBox(
      width: double.infinity,
      height: dimensions[0],
      child: ListView.builder(
          itemCount: cartModel!.success.length,
          itemBuilder: (context, index) {
            CartSuccessResponseModel product = cartModel!.success[index];
            return InkWell(
              onTap: () {
                // Navigator.of(context).push(MaterialPageRoute(
                //     builder: (context) => MobileProductDisplay(
                //           product: product,
                //           productCategory: widget.productCategory,
                //         )));
              },
              child: Container(
                height: 350,
                width: dimensions[1],
                decoration: BoxDecoration(
                    color: Colors.lightBlue[50],
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: dimensions[1] * 0.4,
                          height: 200,
                          child: Image.asset(
                            '${ImagePaths.productsPath}${product.image}.jpg',
                            // height: 500,
                            fit: BoxFit.fill,

                            // width: 200,
                            // fit: BoxFit.fill,
                          ),
                        ),
                        Container(
                          height: 200,
                          alignment: Alignment.topCenter,
                          padding: const EdgeInsets.only(top: 20),
                          width: dimensions[1] * 0.4,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                product.name,
                                style: const TextStyle(
                                    color: Colors.indigo,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    letterSpacing: 2),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              RichText(
                                text: TextSpan(
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: '₹ ${product.realPrice.toString()}',
                                      style: const TextStyle(
                                          color: Colors.grey,
                                          decoration:
                                              TextDecoration.lineThrough,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                          letterSpacing: 1),
                                    ),
                                    TextSpan(
                                      text: ' ₹ ${product.price.toString()}',
                                      style: const TextStyle(
                                          color: Colors.green,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                          letterSpacing: 1),
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                '(${product.discount}% off)',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Colors.green),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              const QuantityCounter()
                            ],
                          ),
                        ),
                        const IconButton(
                          onPressed: null,
                          icon: Icon(
                            Icons.favorite,
                            color: Colors.grey,
                          ),
                        )
                      ],
                    ),
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.white)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            style: ButtonStyle(
                              elevation: MaterialStateProperty.all<double>(12),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                Colors.red,
                              ),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      side: const BorderSide(
                                          color: Colors.black))),
                            ),
                            onPressed: () {
                              BlocProvider.of<CartBloc>(context)
                                  .add(RemoveItemEvent(id: product.id));
                            },
                            child: const Text(
                              'Remove Item',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ),
                          ElevatedButton(
                            style: ButtonStyle(
                              elevation: MaterialStateProperty.all<double>(12),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                Colors.green,
                              ),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      side: const BorderSide(
                                          color: Colors.black))),
                            ),
                            onPressed: () {},
                            child: const Text(
                              'Place Order',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          )
                        ],
                      ),
                    ),
                    const Divider(
                      color: Colors.green,
                      thickness: 10,
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }

  void bottomBarOnTap() {}
}
