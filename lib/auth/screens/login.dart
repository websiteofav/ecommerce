import 'dart:developer';

import 'package:ecommerce/auth/bloc/auth_bloc.dart';
import 'package:ecommerce/auth/repository/auth_repository.dart';
import 'package:ecommerce/widgets/circular_indicator.dart';
import 'package:ecommerce/widgets/message_pop_up.dart';
import 'package:ecommerce/utils/device_dimensions.dart';
import 'package:ecommerce/utils/images.dart';
import 'package:ecommerce/utils/validators.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _emailEditingController = TextEditingController();
  final _passwordEditingController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  @override
  Widget build(BuildContext context) {
    final LoadingOverlay _loadingOverlay = LoadingOverlay();

    final textTheme = Theme.of(context).textTheme;
    final dimensions = deviceDimensions(context);
    return BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is LoginRegisterLoaded) {
            _loadingOverlay.hide();

            BlocProvider.of<AuthBloc>(context).add(GetAuthUserEvent());
          } else if (state is AuthError) {
            _loadingOverlay.hide();
            validationAlert(context, state.message, from: 'login');
          } else if (state is AuthLoading) {
            _loadingOverlay.show(context);
          } else if (state is AuthLoaded) {
            _loadingOverlay.hide();
            _emailEditingController.text = '';
            _passwordEditingController.text = '';

            Navigator.pushNamed(context, '/homepage');
          }
        },
        child: GestureDetector(
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);

            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            decoration: BoxDecoration(
              image: DecorationImage(
                colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.3), BlendMode.dstATop),
                image:
                    const AssetImage(BackgroundCollection.ecommerceBackground),
                fit: BoxFit.fill,
              ),
            ),
            child: Scaffold(
              resizeToAvoidBottomInset: true,
              backgroundColor: Colors.transparent,
              body: Container(
                margin: EdgeInsets.only(top: dimensions[0] * 0.2),
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Welcome to your favourite Shopping Place',
                          style: textTheme.headline1,
                          textAlign: TextAlign.center,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          width: dimensions[1] * 0.8,
                          height: 100,
                          child: TextFormField(
                            controller: _emailEditingController,
                            validator: (value) {
                              if (Validators.emailValidator(value) == false) {
                                return 'Email Id not valid';
                              } else {
                                return null;
                              }
                            },
                            style: const TextStyle(color: Colors.blue),
                            decoration: const InputDecoration(
                              hintText: 'Email Id',
                              hintStyle: TextStyle(fontWeight: FontWeight.bold),
                              enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                // width: 0.0 produces a thin "hairline" border
                                borderSide: BorderSide(
                                    color: Colors.white,
                                    width: 3.0,
                                    style: BorderStyle.solid),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          width: dimensions[1] * 0.8,
                          height: 100,
                          child: TextFormField(
                            controller: _passwordEditingController,
                            validator: (value) {
                              final val = value!.trim();
                              if (val.trim().isEmpty) {
                                return 'Password not valid';
                              } else {
                                return null;
                              }
                            },
                            style: const TextStyle(color: Colors.blue),
                            decoration: const InputDecoration(
                              hintText: 'Password',
                              hintStyle: TextStyle(fontWeight: FontWeight.bold),
                              enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                // width: 0.0 produces a thin "hairline" border
                                borderSide: BorderSide(
                                    color: Colors.white,
                                    width: 3.0,
                                    style: BorderStyle.solid),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(40),
                            ),
                          ),
                          width: dimensions[1] * 0.4,
                          child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                BlocProvider.of<AuthBloc>(context).add(
                                    LoginEvent(
                                        password:
                                            _passwordEditingController.text,
                                        email: _emailEditingController.text));
                              }
                            },
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.blue)),
                            child: const Text(
                              'Login',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            text: 'New here? Please',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                                color: Colors.cyanAccent),
                            children: <TextSpan>[
                              TextSpan(
                                  text: ' SignUp',
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () =>
                                        Navigator.pushNamed(context, '/signup'),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      color: Colors.blue)),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
