part of 'utilities.dart';

enum SnackbarType { error, success, info }

class Commons {
  final picker = ImagePicker();
  final Future<SharedPreferences> prefs = SharedPreferences.getInstance();
  void setUid(String uid) async {
    final SharedPreferences storage = await prefs;

    await storage.setString(myUid, uid);
  }

  Future<String?> getUid() async {
    final SharedPreferences storage = await prefs;
    String uid = storage.getString(myUid)!;
    print("MY UID $uid");
    return uid;
  }

  void showSnackBar(BuildContext context, String message, SnackbarType type) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: (type == SnackbarType.info)
            ? colorName.accentBlue
            : (type == SnackbarType.error)
                ? colorName.accentRed
                : colorName.accentGreen,
        content: message.text.make()));
  }

  Future<File> getImage({bool isGallery = true}) async {
    final pickedFile = await picker.pickImage(
      source: isGallery ? ImageSource.gallery : ImageSource.camera,
      imageQuality: 10,
    );
    final File file = File(pickedFile!.path);
    return file;
  }

  String convertToIdr(dynamic number, int decimalDigit) {
    NumberFormat currencyFormatter = NumberFormat.currency(
      locale: 'id',
      symbol: 'Rp',
      decimalDigits: decimalDigit,
    );
    return currencyFormatter.format(number);
  }
}
