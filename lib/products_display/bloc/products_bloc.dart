import 'package:bloc/bloc.dart';
import 'package:ecommerce/products_display/models/mobile_response_model.dart';
import 'package:ecommerce/products_display/repository/product_repository.dart';
import 'package:meta/meta.dart';

part 'products_event.dart';
part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  ProductsRepository repository;
  ProductsBloc({required this.repository}) : super(ProductsInitial()) {
    on<ProductsEvent>(
      (event, emit) async {
        if (event is GetAllMobilesEvent) {
          emit(ProductsLoading());
          MobileResponseModel model = await repository.getAllMobiles();

          if (model.status == 200) {
            emit(ProductsLoaded(model: model));
          } else {
            emit(ProductsError(message: model.error));
          }
        }
      },
    );
  }
}
