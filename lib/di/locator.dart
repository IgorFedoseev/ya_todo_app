import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../domain/remote_config_service.dart';
import '../firebase_options.dart';

abstract class Locator {
  static final GetIt _locator = GetIt.instance;

  static RemoteConfigService get remoteConfig =>
      _locator<RemoteConfigService>();

  static Future<void> setupLocator() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Hive.initFlutter();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    FlutterError.onError = (errorDetails) {
      FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
    };

    PlatformDispatcher.instance.onError = (error, stack) {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      return true;
    };

    _locator.registerLazySingleton<FirebaseRemoteConfig>(
      () => FirebaseRemoteConfig.instance,
    );
    final remoteConfigService =
        RemoteConfigService(_locator.get<FirebaseRemoteConfig>());
    await remoteConfigService.init();
    _locator.registerSingleton<RemoteConfigService>(remoteConfigService);
  }

  static FirebaseAnalytics get analytics => FirebaseAnalytics.instance;
}
