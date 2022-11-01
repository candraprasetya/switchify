part of 'product_picture_cubit.dart';

@immutable
abstract class ProductPictureState {}

class ProductPictureInitial extends ProductPictureState {}

class ProductPictureIsSuccess extends ProductPictureState {
  final File file;

  ProductPictureIsSuccess(this.file);
}

class ProductPictureIsFailed extends ProductPictureState {}

class ProductPictureIsLoading extends ProductPictureState {}
