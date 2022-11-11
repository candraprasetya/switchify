part of 'utilities.dart';

class Commons {
  final prefs = SharedPreferences.getInstance();
  final picker = ImagePicker();

  void setUID(String uid) async {
    final storage = await prefs;
    await storage.setString(myUID, uid);
  }

  Future<String> getUID() async {
    final storage = await prefs;
    return storage.getString(myUID)!;
  }

  Future<bool> removeUID() async {
    final storage = await prefs;
    return storage.remove(myUID);
  }

  void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: message.text.make()));
  }

  //fungsi untuk get Image from gallery
  Future<File> getImage() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 10,
    );
    return File(pickedFile!.path);
  }
}
