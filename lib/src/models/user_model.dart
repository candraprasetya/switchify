part of 'models.dart';
// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  final String? username;
  final String? email;
  final String? uid;
  final String? photoProfile;
  final String? walletId;
  final bool? admin;

  UserModel(
      {this.username,
      this.email,
      this.uid,
      this.photoProfile,
      this.walletId,
      this.admin});

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        username: json["username"],
        email: json["email"],
        uid: json["uid"],
        photoProfile: json["photo_profile"] ?? '',
        walletId: json["wallet_id"],
        admin: json["admin"],
      );

  Map<String, dynamic> toJson() => {
        "username": username,
        "email": email,
        "uid": uid,
        "photo_profile": photoProfile,
        "wallet_id": walletId,
        "admin": admin,
      };
}
