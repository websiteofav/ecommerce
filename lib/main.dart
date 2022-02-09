import 'package:ecommerce/auth/bloc/auth_bloc.dart';
import 'package:ecommerce/auth/repository/auth_repository.dart';
import 'package:ecommerce/auth/screens/login.dart';
import 'package:ecommerce/auth/screens/signup.dart';
import 'package:ecommerce/homepage/screens/homepage.dart';

import 'package:ecommerce/products_display/bloc/products_bloc.dart';
import 'package:ecommerce/products_display/repository/product_repository.dart';
import 'package:ecommerce/products_display/screens/all_categories.dart';
import 'package:ecommerce/products_display/screens/all_products_display.dart';
import 'package:ecommerce/products_display/screens/sub_category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

Future<void> main() async {
  const storage = FlutterSecureStorage();
  WidgetsFlutterBinding.ensureInitialized();

  final token = await storage.containsKey(key: 'token');
  runApp(MyApp(
    isLoggedIn: token,
  ));
}

class MyApp extends StatelessWidget {
  bool isLoggedIn;
  MyApp({Key? key, required this.isLoggedIn}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ProductsBloc(
            repository: ProductsRepository(),
          ),
        ),
        BlocProvider(
          create: (context) => AuthBloc(
            repository: AuthRepository(),
          ),
        ),
      ],
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is LogoutLoaded) {
            isLoggedIn = false;
          } else {
            isLoggedIn = true;
          }
        },
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
            primarySwatch: Colors.blue,
          ),
          home: isLoggedIn ? const HomePage() : const Login(),
          routes: {
            '/login': (context) => const Login(),
            '/signup': (context) => const SignUp(),
            '/homepage': (context) => const HomePage(),
            '/allCategories': (context) => const AllCategories(),
            '/subCategory': (context) => const SubCategory(
                  category: '',
                ),
            '/productDisplay': (context) => AllProductDisplay(
                  productCategory: '',
                ),
          },
        ),
      ),
    );
  }
}
