import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:switchify/src/utilities/utilities.dart';

part 'product_picture_state.dart';

class ProductPictureCubit extends Cubit<ProductPictureState> {
  ProductPictureCubit() : super(ProductPictureInitial());

  void getImage() async {
    final pickedFile = await Commons().getImage(isGallery: true);
    if (pickedFile.path.isNotEmpty) {
      emit(ProductPictureIsSuccess(pickedFile));
    }
  }

  void resetImage() {
    emit(ProductPictureInitial());
  }
}
