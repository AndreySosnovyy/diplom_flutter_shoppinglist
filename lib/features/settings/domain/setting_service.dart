import 'package:package_info_plus/package_info_plus.dart';

class SettingsService {
  late final PackageInfo _packageInfo;
  late final String displayVersion;

  Future init() async {
    _packageInfo = await PackageInfo.fromPlatform();
    displayVersion = _packageInfo.version;
  }
}
