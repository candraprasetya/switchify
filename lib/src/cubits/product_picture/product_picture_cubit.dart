import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:switchify/src/utilities/utilities.dart';

part 'product_picture_state.dart';

class ProductPictureCubit extends Cubit<ProductPictureState> {
  ProductPictureCubit() : super(ProductPictureInitial());

  void getImage() async {
    final file = await Commons().getImage();
    if (file.path.isNotEmpty) {
      emit(ProductPictureIsLoaded(file: file));
    } else {
      emit(ProductPictureIsFailed());
    }
  }

  void resetImage() {
    emit(ProductPictureInitial());
  }
}
