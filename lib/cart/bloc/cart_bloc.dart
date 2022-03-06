import 'package:bloc/bloc.dart';
import 'package:ecommerce/cart/models/cart_response_model.dart';
import 'package:ecommerce/cart/repository/cart_repository.dart';
import 'package:meta/meta.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final CartRepository repository;

  CartBloc({required this.repository}) : super(CartInitial()) {
    on<CartEvent>((event, emit) async {
      if (event is GetCartEvent) {
        emit(CartLoading());

        try {
          final CartResponseModel model = await repository.getCart();

          if (model.status == 200) {
            emit(CartLoaded(model: model));
          } else {
            emit(CartError(message: model.error));
          }
        } catch (e) {
          emit(CartError(message: e.toString()));
        }
      } else if (event is AddItemEvent) {
        emit(CartLoading());

        try {
          Map<String, String> jsonBody = {
            'name': event.name,
            'price': event.price,
            'realprice': event.realprice,
            'discount': event.discount,
            'image': event.image,
          };

          final CartResponseModel model =
              await repository.addItemToCart(jsonPostdata: jsonBody);

          if (model.status == 200) {
            emit(CartLoaded(model: model));
          } else {
            emit(CartError(message: model.error));
          }
        } catch (e) {
          emit(CartError(message: e.toString()));
        }
      } else if (event is RemoveItemEvent) {
        emit(CartLoading());

        try {
          final CartResponseModel model =
              await repository.removeItemFromCart(id: event.id);

          if (model.status == 200) {
            emit(CartLoaded(model: model));
          } else {
            emit(CartError(message: model.error));
          }
        } catch (e) {
          emit(CartError(message: e.toString()));
        }
      }
    });
  }
}
