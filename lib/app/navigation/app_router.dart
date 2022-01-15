import 'package:auto_route/annotations.dart';
import 'package:diplom/features/auth/presentation/screens/signin/signin_view.dart';

@AdaptiveAutoRouter(routes: <AutoRoute>[
  AutoRoute(page: SignInView, initial: true),
])
class $AppRouter {}

