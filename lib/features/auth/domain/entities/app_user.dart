/// The class represents the application user who can be identified
/// to be added to other users shopping lists
class AppUser {
  AppUser({
    required this.id,
    required this.name,
    required this.listIds,
    required this.isHidden,
    this.handler,
    this.avatarUrl,
  });

  final String id;
  final String name;
  final String? handler;
  final String? avatarUrl;
  final List<String> listIds;
  final bool isHidden;

  factory AppUser.fromJson(String id, Map<String, dynamic> json) {
    return AppUser(
      id: id,
      name: json['name'],
      isHidden: json['isHidden'],
      listIds: json['listIds'],
      handler: json['handler'],
      avatarUrl: json['avatarUrl'],
    );
  }
}
