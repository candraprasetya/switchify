part of 'services.dart';

class ProductService {
  final productCollection =
      FirebaseFirestore.instance.collection(productCollectionName);

  Future<Either<String, List<ProductModel>>> fetchProductList() async {
    try {
      QuerySnapshot querySnapshot = await productCollection.get();
      final products = querySnapshot.docs
          .map((e) => ProductModel.fromMap(e.data() as Map<String, dynamic>))
          .toList();
      return right(products);
    } on FirebaseAuthException catch (e) {
      return left(e.toString().split(']').last);
    }
  }

  Future<Either<String, String>> updateProduct(
      String idDoc, ProductModel productModel) async {
    // Once signed in, return the UserCredential
    try {
      productCollection.doc(idDoc).update(productModel.toMap());

      return right('Sukses menambah data');
    } on FirebaseAuthException catch (e) {
      return left(e.toString().split(']').last);
    }
  }
}
