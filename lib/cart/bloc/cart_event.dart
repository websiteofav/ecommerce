part of 'cart_bloc.dart';

@immutable
abstract class CartEvent {}

class GetCartEvent extends CartEvent {}

class AddItemEvent extends CartEvent {
  final String name;
  final String price;
  final String realprice;
  final String discount;
  final String image;

  AddItemEvent({
    required this.name,
    required this.price,
    required this.realprice,
    required this.discount,
    required this.image,
  });
}

class ChangeQuantityEvent extends CartEvent {
  final String quantity;

  ChangeQuantityEvent({
    required this.quantity,
  });
}

class RemoveItemEvent extends CartEvent {
  final String id;
  RemoveItemEvent({required this.id});
}
