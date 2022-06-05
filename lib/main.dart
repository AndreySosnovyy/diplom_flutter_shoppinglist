import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import 'app/app.dart';
import 'app/dependencies.dart';

void main() async {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    // todo: set firebase rules (storage & database)
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    await Firebase.initializeApp();
    await setupDependencies();
    await setupSentry();
    await setupAppMetrica();
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    runApp(const App());
  }, (exception, stackTrace) async {
    await FirebaseCrashlytics.instance.recordError(exception, stackTrace);
    await Sentry.captureException(exception, stackTrace: stackTrace);
  });
}
