import 'package:ecommerce/products_display/bloc/products_bloc.dart';
import 'package:ecommerce/products_display/model/mobile_response_model.dart';
import 'package:ecommerce/products_display/screens/mobile_product_display.dart';
import 'package:ecommerce/utils/device_dimensions.dart';
import 'package:ecommerce/utils/images.dart';
import 'package:ecommerce/widgets/category_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AllProductDisplay extends StatefulWidget {
  final String productCategory;
  AllProductDisplay({Key? key, required this.productCategory})
      : super(key: key);

  @override
  _AllProductDisplayState createState() => _AllProductDisplayState();
}

class _AllProductDisplayState extends State<AllProductDisplay> {
  var category = '';

  void initState() {
    super.initState();

    if (widget.productCategory == 'Mobilephones') {
      BlocProvider.of<ProductsBloc>(context).add(GetAllMobilesEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    final dimensions = deviceDimensions(context);
    return Scaffold(
        appBar: PreferredSize(
          child: CategoryAppBar(
            category: widget.productCategory,
          ),
          preferredSize: const Size.fromHeight(55.0),
        ),
        body: BlocBuilder<ProductsBloc, ProductsState>(
          builder: (context, state) {
            if (state is ProductsLoaded) {
              return SizedBox(
                width: double.infinity,
                height: dimensions[0],
                child: ListView.builder(
                    itemCount: state.model.success.length,
                    itemBuilder: (context, index) {
                      MobileSuccessResponseModel product =
                          state.model.success[index];
                      return InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => MobileProductDisplay(
                                    product: product,
                                    productCategory: widget.productCategory,
                                  )));
                        },
                        child: Container(
                          height: 270,
                          width: dimensions[1],
                          decoration: BoxDecoration(
                              color: Colors.lightBlue[50],
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: dimensions[1] * 0.4,
                                    height: 200,
                                    child: Image.asset(
                                      '${Electronics.mobileImagePath}${product.image}.jpg',
                                      // height: 500,
                                      fit: BoxFit.fill,

                                      // width: 200,
                                      // fit: BoxFit.fill,
                                    ),
                                  ),
                                  Container(
                                    height: 250,
                                    alignment: Alignment.topCenter,
                                    padding: const EdgeInsets.only(top: 20),
                                    width: dimensions[1] * 0.4,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
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
                                                text:
                                                    '₹ ${product.realPrice.toString()}',
                                                style: const TextStyle(
                                                    color: Colors.grey,
                                                    decoration: TextDecoration
                                                        .lineThrough,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18,
                                                    letterSpacing: 1),
                                              ),
                                              TextSpan(
                                                text:
                                                    '   ₹ ${product.price.toString()}',
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
                                          height: 20,
                                        ),
                                        Wrap(
                                          spacing: 8,
                                          runSpacing: 10,
                                          children: [
                                            Container(
                                              padding: const EdgeInsets.all(
                                                10,
                                              ),
                                              // margin: EdgeInsets.only(bottom: 50),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                border: Border.all(
                                                    color: Colors.grey),
                                              ),
                                              child: Text(
                                                '${product.displaySize} inch',
                                                style: TextStyle(
                                                    color: Colors.orange[900],
                                                    fontSize: 14),
                                              ),
                                            ),
                                            Container(
                                              padding: const EdgeInsets.all(
                                                10,
                                              ),
                                              // margin: EdgeInsets.only(bottom: 50),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                border: Border.all(
                                                    color: Colors.grey),
                                              ),
                                              child: Text(
                                                '${product.clockSpeed} GHz',
                                                style: TextStyle(
                                                    color: Colors.orange[900],
                                                    fontSize: 14),
                                              ),
                                            ),
                                            Container(
                                              padding: const EdgeInsets.all(
                                                10,
                                              ),
                                              // margin: EdgeInsets.only(bottom: 50),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                border: Border.all(
                                                    color: Colors.grey),
                                              ),
                                              child: Text(
                                                '${product.internalStorage} GB',
                                                style: TextStyle(
                                                    color: Colors.orange[900],
                                                    fontSize: 14),
                                              ),
                                            )
                                          ],
                                        ),
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
            } else if (state is ProductsError) {
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
            } else {
              return Container(
                alignment: Alignment.center,
                child: CircularProgressIndicator(),
              );
            }
          },
        ));
  }
}
