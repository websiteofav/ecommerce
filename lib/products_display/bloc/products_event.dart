part of 'products_bloc.dart';

@immutable
abstract class ProductsEvent {}

class getMobileData extends ProductsEvent {
  String table;
  getMobileData({required this.table});
}
