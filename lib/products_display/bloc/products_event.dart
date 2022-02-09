part of 'products_bloc.dart';

@immutable
abstract class ProductsEvent {}

class GetAllMobilesEvent extends ProductsEvent {
  GetAllMobilesEvent();
}
