part of 'cart_bloc.dart';

@immutable
abstract class CartState {}

class CartInitial extends CartState {}

class CartLoading extends CartState {}

class CartLoaded extends CartState {
  final CartResponseModel model;
  CartLoaded({required this.model});
}

class AddItemLoaded extends CartState {
  final List<CartResponseModel> model;
  AddItemLoaded({required this.model});
}

class CartItemQuantityLoaded extends CartState {
  final CartResponseModel model;
  CartItemQuantityLoaded({required this.model});
}

class CartItemDeleteLoaded extends CartState {
  final CartResponseModel model;
  CartItemDeleteLoaded({required this.model});
}

class CartError extends CartState {
  final String message;
  CartError({required this.message});
}
