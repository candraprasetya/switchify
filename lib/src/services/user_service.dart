part of 'services.dart';

class UserService {
  //Init Collection
  final usersCollection =
      FirebaseFirestore.instance.collection(usersCollectionName);

  Future<Either<String, UserModel>> registerWithEmail(
      {String? email, String? password, String? name}) async {
    try {
      final userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email!, password: password!);

      //Kumpulkan Data
      final userData = UserModel(
          admin: false,
          email: userCredential.user!.email,
          photoProfile: '',
          uid: userCredential.user!.uid,
          username: name);

      //Uplload Data ke firebase firestore
      usersCollection.doc(userCredential.user!.uid).set(userData.toMap());

      return right(userData);
    } on FirebaseAuthException catch (e) {
      return left(e.toString().split(']').last);
    }
  }

  //TODO: Login With Email

  //TODO: Get User Data

}
