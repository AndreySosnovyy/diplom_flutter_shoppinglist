/// The class represents the application user who can be identified
/// to be added to other users shopping lists
class AppUser {
  AppUser({
    required this.id,
    required this.name,
    required this.listIds,
    required this.isHidden,
    required this.authProvider,
    this.handler,
    this.avatarUrl,
  });

  final String id;
  final String name;
  final String? handler;
  final String? avatarUrl;
  final List<String> listIds;
  final bool isHidden;
  final String authProvider;

  factory AppUser.fromJson(String id, Map json) {
    return AppUser(
      id: id,
      name: json['name'],
      isHidden: json['isHidden'],
      listIds: [...json['listIds']],
      handler: json['handler'],
      avatarUrl: json['avatarUrl'],
      authProvider: json['authProvider']
    );
  }
}
