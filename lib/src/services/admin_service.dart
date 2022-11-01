part of 'services.dart';

class AdminService {
  final productCollection =
      FirebaseFirestore.instance.collection(productCollectionName);

  Future<Either<String, String>> addNewProduct(ProductModel productModel,
      {File? pickedFile}) async {
    try {
      productCollection.doc(productModel.id!).set(productModel.toMap());
      if (pickedFile != null) {
        Reference ref = FirebaseStorage.instance.ref().child(productModel.id!);
        TaskSnapshot storageTaskSnapshot = await ref.putFile(pickedFile);
        String downloadUrl = await storageTaskSnapshot.ref.getDownloadURL();
        if (downloadUrl.isNotEmpty) {
          updateProduct(
              productModel.id!,
              productModel.copyWith(
                picture: downloadUrl,
              ));
        }
      }

      return right('Sukses menambah data');
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

  Future<Either<String, String>> deleteProduct(String idDoc) async {
    // Once signed in, return the UserCredential
    try {
      productCollection.doc(idDoc).delete();

      return right('Sukses menghapus data');
    } on FirebaseAuthException catch (e) {
      return left(e.toString().split(']').last);
    }
  }
}
