part of 'services.dart';

class UserService {
  final userCollection =
      FirebaseFirestore.instance.collection(userCollectionName);

  Future<Either<String, UserModel>> registerWithEmail(
      {String? email, String? pass, String? name}) async {
    // Once signed in, return the UserCredential
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email!, password: pass!);
      UserModel userModel = UserModel(
          admin: false,
          email: email,
          photoProfile: '',
          uid: userCredential.user!.uid,
          username: name,
          walletId: '');
      userCollection.doc(userCredential.user!.uid).set(userModel.toJson());

      return loadUserData(userCredential.user!.uid);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return left('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        return left('The account already exists for that email.');
      }
      return left(e.toString().split(']').last);
    }
  }

  Future<Either<String, UserModel>> loginWithEmail(
      {String? email, String? pass}) async {
    // Once signed in, return the UserCredential
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email!, password: pass!);
      return loadUserData(userCredential.user!.uid);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return left('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        return left('The account already exists for that email.');
      }
      return left(e.toString().split(']').last);
    }
  }

  Future<Either<String, UserModel>> loadUserData(String? uid) async {
    // Once signed in, return the UserCredential
    try {
      final userData = await userCollection.doc(uid).get();
      if (userData.data()!.isNotEmpty) {
        log(UserModel.fromJson(userData.data()!).username!, name: 'TAHU BULAT');

        return right(UserModel.fromJson(userData.data()!));
      } else {
        return left('Data Not Found');
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return left('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        return left('The account already exists for that email.');
      }
      return left(e.toString().split(']').last);
    }
  }
}
