import 'package:auto_route/annotations.dart';
import 'package:diplom/features/auth/presentation/screens/sign_in/sign_in_view.dart';
import 'package:diplom/features/auth/presentation/screens/sign_in_with_phone/sign_in_with_phone_code_view.dart';
import 'package:diplom/features/auth/presentation/screens/sign_in_with_phone/sign_in_with_phone_view.dart';
import 'package:diplom/features/settings/presentation/screens/settings/settings_view.dart';
import 'package:diplom/features/workspace/presentation/screens/list_editing/list_editing_view.dart';
import 'package:diplom/features/workspace/presentation/screens/lists/lists_view.dart';

@AdaptiveAutoRouter(routes: <AutoRoute>[
  AutoRoute(page: ListsView, initial: true),
  AutoRoute(page: ListEditingView),
  AutoRoute(page: SettingsView),
  AutoRoute(page: SignInView),
  AutoRoute(page: SignInWithPhoneView),
  AutoRoute<String>(page: SignInWithPhoneCodeView),
])
class $AppRouter {}

