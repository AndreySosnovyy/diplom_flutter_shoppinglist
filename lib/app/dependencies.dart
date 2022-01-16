import 'package:get_it/get_it.dart';

import 'navigation/app_router.gr.dart';

final sl = GetIt.instance;

Future<void> setupDependencies() async {
  sl.registerSingleton<AppRouter>(AppRouter());
  // sl.registerSingleton<FirebaseApp>(await getFirebaseApp());
}

// Future<FirebaseApp> getFirebaseApp() async {
//   return await Firebase.initializeApp(
//     options: const FirebaseOptions(
//
//     );
// }
