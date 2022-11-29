// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'order_bloc.dart';

@immutable
abstract class OrderEvent {}

class OrderRequest extends OrderEvent {
  final double totalPrice;
  final List<ProductModel> products;

  OrderRequest(
    this.totalPrice,
    this.products,
  );
}
