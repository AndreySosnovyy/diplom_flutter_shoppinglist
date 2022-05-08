import 'package:firebase_database/firebase_database.dart';
import 'package:package_info_plus/package_info_plus.dart';

class SettingsService {
  SettingsService({
    required this.database,
  });

  final FirebaseDatabase database;
  late final PackageInfo _packageInfo;
  late final String displayVersion;
  late bool isHidden;
  late bool showProductImages;
  late bool autoDelete;
  late Duration? autoDeleteDelay;

  Future init() async {
    _packageInfo = await PackageInfo.fromPlatform();
    displayVersion = _packageInfo.version;

    // todo: init with values from database
    isHidden = false;
    showProductImages = true;
    autoDelete = false;
    autoDeleteDelay = null;
  }

  // todo: implement method
  Future updateName(String newName) async => throw UnimplementedError();

  // todo: implement method
  Future updateHandler(String newHandler) async => throw UnimplementedError();

  Future setIsHiddenAccount(bool value) async {
    isHidden = value;
    // todo: update database
  }

  Future setShowProductImages(bool value) async {
    showProductImages = value;
    // todo: update database
  }

  // todo: implement method
  Future showAutoDeletePickerDialog() async => throw UnimplementedError();
}
