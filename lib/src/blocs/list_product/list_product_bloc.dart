import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:switchify/src/models/models.dart';
import 'package:switchify/src/services/services.dart';

part 'list_product_event.dart';
part 'list_product_state.dart';

class ListProductBloc extends Bloc<ListProductEvent, ListProductState> {
  ListProductBloc() : super(ListProductInitial()) {
    on<FetchProductList>((event, emit) async {
      emit(ListProductIsLoading());
      final result = await ProductService().fetchProductList();
      result.fold((l) => emit(ListProductIsFailed(l)),
          (r) => emit(ListProductIsSuccess(r)));
    });
  }
}
