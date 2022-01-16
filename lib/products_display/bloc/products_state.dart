part of 'products_bloc.dart';

@immutable
abstract class ProductsState {}

class ProductsInitial extends ProductsState {}

class ProductsLoading extends ProductsState {}

class ProductsLoaded extends ProductsState {
  final MobileResponse model;

  ProductsLoaded({required this.model});
}

class ProductsError extends ProductsState {
  final String message;

  ProductsError({required this.message});
}
