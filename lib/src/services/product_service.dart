part of 'services.dart';

class ProductService {
  final productCollection =
      FirebaseFirestore.instance.collection(productCollectionName);

  Future<Either<String, List<ProductModel>>> fetchListProduct() async {
    try {
      final querySnapshot = await productCollection.get();

      final data = querySnapshot.docs
          .map((e) => ProductModel.fromMap(e.data()))
          .toList();
      return right(data);
    } catch (e) {
      return left(e.toString());
    }
  }

  Future<Either<String, List<ProductModel>>> fetchListProductCaraKedua() async {
    try {
      final querySnapshot = await productCollection.get();

      final dataSatu = <ProductModel>[];
      for (var element in querySnapshot.docs) {
        dataSatu.add(ProductModel.fromMap(element.data()));
      }
      return right(dataSatu);
    } catch (e) {
      return left(e.toString());
    }
  }
}

//Query Snapshot => banyak document

//Document Snapshot => satu document