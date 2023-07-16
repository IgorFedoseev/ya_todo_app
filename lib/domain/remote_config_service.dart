import 'package:firebase_remote_config/firebase_remote_config.dart';

class RemoteConfigService {
  final FirebaseRemoteConfig _remoteConfig;

  RemoteConfigService(this._remoteConfig);

  Future<void> init() async {
    await _remoteConfig.setDefaults(<String, dynamic>{
      'change_color': 'false',
    });
    await _remoteConfig.fetchAndActivate();
  }

  bool get isColorChanged => _remoteConfig.getBool('change_color');
}
