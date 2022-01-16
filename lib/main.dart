import 'dart:developer';

import 'package:ecommerce/auth/login.dart';
import 'package:ecommerce/auth/signup.dart';
import 'package:ecommerce/helpers/db_helpers.dart';
import 'package:ecommerce/homepage/homepage.dart';
import 'package:ecommerce/products_display/all_categories.dart';
import 'package:ecommerce/products_display/all_products_display.dart';
import 'package:ecommerce/products_display/bloc/products_bloc.dart';
import 'package:ecommerce/products_display/repository/product_repository.dart';
import 'package:ecommerce/products_display/sub_category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ProductsBloc(
            repository: ProductsRepository(),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          brightness: Brightness.dark,
          primaryColor: Colors.blue[800],
          textTheme: const TextTheme(
            headline1: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
              color: Colors.purple,
            ),
            headline6: TextStyle(
              fontSize: 15.0,
              fontStyle: FontStyle.italic,
            ),
          ),
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blue,
        ),
        home: const Login(),
        // Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        //   Container(
        //     color: Colors.white,
        //     child: TextButton(
        //       onPressed: () {
        //         DBHelper.deleteData('mobiles', '0');
        //         // DBHelper.insertMobile('mobiles', {
        //         //   'id': '2',
        //         //   'name': 'Redni1',
        //         //   'image': 'assets/images/electronic/mobiles/mobile2.jpg',
        //         //   'realPrice': '32000',
        //         //   'offerPrice': '25222',
        //         //   'discount': '13',
        //         //   'size': '6',
        //         //   'battery': '5500',
        //         //   'storage': '128',
        //         //   'operatingSystem': 'Android 12',
        //         //   'networkType': '5G',
        //         //   'camera1': '64',
        //         //   'camera2': '6',
        //         //   'hybridSim': 'Yes',
        //         //   'clock': '2.5'
        //         // });
        //         // DBHelper.insertMobile('mobiles', {
        //         //   'id': '3',
        //         //   'name': 'Micro',
        //         //   'image': 'assets/images/electronic/mobiles/mobile3.jpg',
        //         //   'realPrice': '40000',
        //         //   'offerPrice': '30222',
        //         //   'discount': '20',
        //         //   'size': '5.5',
        //         //   'battery': '6000',
        //         //   'storage': '254',
        //         //   'operatingSystem': 'Android 10',
        //         //   'networkType': '5G',
        //         //   'camera1': '128',
        //         //   'camera2': '32',
        //         //   'hybridSim': 'Yes',
        //         //   'clock': '3.2'
        //         // });
        //         // DBHelper.insertMobile('mobiles', {
        //         //   'id': '4',
        //         //   'name': 'Max',
        //         //   'image': 'assets/images/electronic/mobiles/mobile4.jpg',
        //         //   'realPrice': '40000',
        //         //   'offerPrice': '30222',
        //         //   'discount': '20',
        //         //   'size': '5.5',
        //         //   'battery': '6000',
        //         //   'storage': '254',
        //         //   'operatingSystem': 'Android 10',
        //         //   'networkType': '5G',
        //         //   'camera1': '128',
        //         //   'camera2': '32',
        //         //   'hybridSim': 'Yes',
        //         //   'clock': '3.2'
        //         // });
        //         // DBHelper.insertMobile('mobiles', {
        //         //   'id': '5',
        //         //   'name': 'Samsay',
        //         //   'image': 'assets/images/electronic/mobiles/mobile5.jpg',
        //         //   'realPrice': '40000',
        //         //   'offerPrice': '30222',
        //         //   'discount': '20',
        //         //   'size': '5.5',
        //         //   'battery': '6000',
        //         //   'storage': '254',
        //         //   'operatingSystem': 'Android 10',
        //         //   'networkType': '5G',
        //         //   'camera1': '128',
        //         //   'camera2': '32',
        //         //   'hybridSim': 'Yes',
        //         //   'clock': '3.2'
        //         // });
        //         // DBHelper.insertMobile('mobiles', {
        //         //   'id': '1',
        //         //   'name': 'Samsay New',
        //         //   'image': 'assets/images/electronic/mobiles/mobile1.jpg',
        //         //   'realPrice': '50000',
        //         //   'offerPrice': '30222',
        //         //   'discount': '35',
        //         //   'size': '5.5',
        //         //   'battery': '6500',
        //         //   'storage': '1024',
        //         //   'operatingSystem': 'Android 11',
        //         //   'networkType': '5G',
        //         //   'camera1': '128',
        //         //   'camera2': '32',
        //         //   'hybridSim': 'Yes',
        //         //   'clock': '3.8'
        //         // });
        //       },
        //       child: const Text(
        //         'Hello',
        //         style: TextStyle(color: Colors.black),
        //       ),
        //     ),
        //   ),
        //   Container(
        //     color: Colors.white,
        //     child: TextButton(
        //       onPressed: () async {
        //         final data = await DBHelper.getData('mobiles');
        //         data.map((e) {
        //           log(e['id']);
        //         }).toList();
        //       },
        //       child: const Text(
        //         'Fetch',
        //         style: TextStyle(color: Colors.black),
        //       ),
        //     ),
        //   ),
        // ]),

        routes: {
          '/login': (context) => const Login(),
          '/signup': (context) => const SignUp(),
          '/homepage': (context) => const HomePage(),
          '/allCategories': (context) => const AllCategories(),
          '/subCategory': (context) => const SubCategory(),
          '/productDisplay': (context) => AllProductDisplay(
                productCategory: '',
              ),
        },
      ),
    );
  }
}
