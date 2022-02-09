import 'package:ecommerce/auth/bloc/auth_bloc.dart';
import 'package:ecommerce/homepage/screens/categories.dart';
import 'package:ecommerce/homepage/screens/electronic_auto_scroll.dart';
import 'package:ecommerce/homepage/screens/offer_page.dart';
import 'package:ecommerce/homepage/screens/search_bar.dart';
import 'package:ecommerce/homepage/screens/trending.dart';

import 'package:ecommerce/utils/device_dimensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final dimensions = deviceDimensions(context);

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is LogoutLoaded) {
          // WidgetsBinding.instance!.addPostFrameCallback((_) {});
          SchedulerBinding.instance!.addPostFrameCallback((_) {
            Navigator.popUntil(context, ModalRoute.withName("/"));
          });
        }
      },
      child: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);

          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: Scaffold(
            backgroundColor: Colors.white,
            drawer: Theme(
              data: Theme.of(context).copyWith(
                // Set the transparency here
                canvasColor: Colors.blue[
                    600], //or any other color you want. e.g Colors.blue.withOpacity(0.5)
              ),
              child: Drawer(
                // Add a ListView to the drawer. This ensures the user can scroll
                // through the options in the drawer if there isn't enough vertical
                // space to fit everything.
                child: Column(
                  // Important: Remove any padding from the ListView.
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.popUntil(
                            context, ModalRoute.withName('/homepage'));

                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => const HomePage()));
                      },
                      child: SizedBox(
                        height: 150,
                        child: DrawerHeader(
                          decoration: const BoxDecoration(
                            color: Colors.blue,
                          ),
                          child: Row(
                            children: const [
                              Icon(Icons.home),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                'Home',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    ListTile(
                      leading: const Icon(
                        Icons.category,
                        color: Colors.yellow,
                        size: 18,
                      ),
                      title: const Text(
                        'All Categories',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                      onTap: () {
                        Navigator.pushNamed(context, '/allCategories');
                      },
                    ),
                    ListTile(
                      leading: const Icon(
                        Icons.local_offer,
                        color: Colors.yellow,
                        size: 18,
                      ),
                      title: const Text(
                        'Offers',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                      onTap: () {
                        // Update the state of the app.
                        // ...
                      },
                    ),
                    ListTile(
                      leading: const Icon(
                        Icons.payment,
                        color: Colors.yellow,
                        size: 18,
                      ),
                      title: const Text(
                        'My Orders',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                      onTap: () {
                        // Update the state of the app.
                        // ...
                      },
                    ),
                    ListTile(
                      leading: const Icon(
                        Icons.shopping_cart,
                        color: Colors.yellow,
                      ),
                      title: const Text(
                        'My Cart',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                      onTap: () {
                        // Update the state of the app.
                        // ...
                      },
                    ),
                    ListTile(
                      leading: const Icon(
                        Icons.account_box,
                        color: Colors.yellow,
                        size: 20,
                      ),
                      title: const Text(
                        'My Acoount',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                      onTap: () {
                        // Update the state of the app.
                        // ...
                      },
                    ),
                    Expanded(
                      child: ListTile(
                        leading: const Icon(
                          Icons.logout_rounded,
                          color: Colors.yellow,
                          size: 20,
                        ),
                        title: const Text(
                          'Logout',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                        onTap: () {
                          BlocProvider.of<AuthBloc>(context).add(LogoutEvent());
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            appBar: AppBar(
              titleSpacing: dimensions[1] * 0.1,
              backgroundColor: Colors.blue,
              titleTextStyle:
                  const TextStyle(color: Colors.white, fontSize: 16),
              title: RichText(
                text: const TextSpan(
                  text: 'Shop Here \n',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                      color: Colors.cyanAccent),
                  children: <TextSpan>[
                    TextSpan(
                        text: 'Join Premium',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            color: Colors.yellow)),
                  ],
                ),
              ),
              actions: const [
                IconButton(
                  onPressed: null,
                  icon: Icon(
                    Icons.notifications,
                    color: Colors.white,
                  ),
                ),
                IconButton(
                    icon: Icon(Icons.shopping_cart, color: Colors.white),
                    onPressed: null)
              ],
            ),
            body: SingleChildScrollView(
              child: Column(
                children: const [
                  SearchBar(),
                  Categories(),
                  OfferPage(),
                  ElectronicsAutoScroll(),
                  Trending()
                ],
              ),
            )),
      ),
    );
  }
}
