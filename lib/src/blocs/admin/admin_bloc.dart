import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:switchify/src/cubits/cubits.dart';
import 'package:switchify/src/models/models.dart';
import 'package:switchify/src/services/services.dart';

part 'admin_event.dart';
part 'admin_state.dart';

class AdminBloc extends Bloc<AdminEvent, AdminState> {
  final ProductPictureCubit pictureCubit;
  AdminBloc(this.pictureCubit) : super(AdminInitial()) {
    on<AddProduct>((event, emit) async {
      emit(AdminIsLoading());
      ProductModel model = ProductModel(
        name: event.name,
        price: event.price,
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        dateTime: DateTime.now(),
      );
      final result = await AdminService().addNewProduct(model,
          pickedFile: (pictureCubit.state is ProductPictureIsSuccess)
              ? (pictureCubit.state as ProductPictureIsSuccess).file
              : null);
      result.fold((l) => emit(AdminIsFailed(l)), (r) {
        emit(AdminIsSuccess(r));
      });
    });
    on<DeleteProduct>((event, emit) async {
      emit(AdminIsLoading());
      final result = await AdminService().deleteProduct(event.id!);
      result.fold((l) => emit(AdminIsFailed(l)), (r) {
        emit(AdminIsSuccess(r));
      });
    });
  }
}
