import 'package:flutter/material.dart';

import 'app/app.dart';
import 'app/dependencies.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupDependencies();
  runApp(const App());
}
