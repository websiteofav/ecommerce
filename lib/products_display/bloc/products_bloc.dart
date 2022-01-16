import 'package:bloc/bloc.dart';
import 'package:ecommerce/products_display/model/mobile.dart';
import 'package:ecommerce/products_display/repository/product_repository.dart';
import 'package:meta/meta.dart';

part 'products_event.dart';
part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  ProductsRepository repository;
  ProductsBloc({required this.repository}) : super(ProductsInitial()) {
    on<ProductsEvent>(
      (event, emit) async {
        if (event is getMobileData) {
          emit(ProductsLoading());
          MobileResponse model = await repository.getData(table: event.table);

          if (model.success == null) {
            emit(ProductsError(message: 'No data found'));
          } else {
            emit(ProductsLoaded(model: model));
          }
        }
      },
    );
  }
}
