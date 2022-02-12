import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'app/app.dart';
import 'app/dependencies.dart';

void main() async {
  // todo: add Firebase Crachlytics or Sentry
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await setupDependencies();
  runApp(const App());
}
