// ignore_for_file: public_member_api_docs, sort_constructors_first

part of 'models.dart';

class ProductModel {
  final String? id;
  final DateTime? dateTime;
  final String? name;
  final double? price;
  final String? picture;
  final String? desc;
  final List<String>? variant;
  ProductModel({
    this.id,
    this.dateTime,
    this.name,
    this.price,
    this.picture,
    this.desc,
    this.variant,
  });

  ProductModel copyWith({
    String? id,
    DateTime? dateTime,
    String? name,
    double? price,
    String? picture,
    String? desc,
    List<String>? variant,
  }) {
    return ProductModel(
      id: id ?? this.id,
      dateTime: dateTime ?? this.dateTime,
      name: name ?? this.name,
      price: price ?? this.price,
      picture: picture ?? this.picture,
      desc: desc ?? this.desc,
      variant: variant ?? this.variant,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'dateTime': dateTime?.millisecondsSinceEpoch,
      'name': name,
      'price': price,
      'picture': picture,
      'desc': desc,
      'variant': variant,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id'] != null ? map['id'] as String : null,
      dateTime: map['dateTime'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['dateTime'] as int)
          : null,
      name: map['name'] != null ? map['name'] as String : null,
      price: map['price'] != null ? map['price'] as double : null,
      picture: map['picture'] != null ? map['picture'] as String : null,
      desc: map['desc'] != null ? map['desc'] as String : null,
      variant: map['variant'] != null ? List.from(map['variant']) : [],
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductModel.fromJson(String source) =>
      ProductModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
