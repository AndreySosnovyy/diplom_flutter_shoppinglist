import 'package:auto_route/annotations.dart';
import 'package:diplom/features/auth/presentation/screens/sign_in/sign_in_view.dart';
import 'package:diplom/features/auth/presentation/screens/sign_up/sign_up_view.dart';
import 'package:diplom/features/settings/presentation/screens/settings/settings_view.dart';
import 'package:diplom/features/workspace/presentation/screens/list_creation/list_creation_view.dart';
import 'package:diplom/features/workspace/presentation/screens/lists/lists_view.dart';

@AdaptiveAutoRouter(routes: <AutoRoute>[
  AutoRoute(page: SignInView),
  AutoRoute(page: SignUpView),
  AutoRoute(page: ListsView, initial: true),
  AutoRoute(page: ListCreationView),
  AutoRoute(page: SettingsView),
])
class $AppRouter {}

