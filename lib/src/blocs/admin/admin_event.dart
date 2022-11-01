part of 'admin_bloc.dart';

@immutable
abstract class AdminEvent {}

class AddProduct extends AdminEvent {
  final String? name;
  final double? price;

  AddProduct({this.name, this.price});
}

class DeleteProduct extends AdminEvent {
  final String? id;

  DeleteProduct(this.id);
}
