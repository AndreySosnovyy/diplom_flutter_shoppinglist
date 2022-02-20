
/// The class represents the application user who can be identified
/// to be added to other users shopping lists
class AppUser {
  final String name;
  final String handler;
  final String? avatarUrl;

  AppUser({
    required this.name,
    required this.handler,
    this.avatarUrl,
  });
}