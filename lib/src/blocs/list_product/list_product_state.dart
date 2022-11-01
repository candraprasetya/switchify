part of 'list_product_bloc.dart';

@immutable
abstract class ListProductState {}

class ListProductInitial extends ListProductState {}

class ListProductIsLoading extends ListProductState {}

class ListProductIsFailed extends ListProductState {
  final String message;

  ListProductIsFailed(this.message);
}

class ListProductIsSuccess extends ListProductState {
  final List<ProductModel> products;

  ListProductIsSuccess(this.products);
}
