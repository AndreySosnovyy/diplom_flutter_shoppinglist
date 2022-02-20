import 'package:diplom/features/auth/domain/entities/app_user.dart';

/// The class represents other user added to ShoppingList as a viewer or an editor
class CoAuthor extends AppUser {
  final bool canEdit;

  CoAuthor({
    required String name,
    required String handler,
    String? avatarUrl,
    this.canEdit = false,
  }) : super(
          name: name,
          handler: handler,
          avatarUrl: avatarUrl,
        );
}
