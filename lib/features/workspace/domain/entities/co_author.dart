/// The class represents other user added to ShoppingList
class CoAuthor {
  CoAuthor({
    required this.name,
    required this.handler,
    this.avatarUrl,
  });

  final String name;
  final String handler;
  final String? avatarUrl;

  Map toJson() => {
        'name': name,
        'handler': handler,
        'avatarUrl': avatarUrl,
      };

  factory CoAuthor.fromJson(Map json) {
    return CoAuthor(
      name: json['name'],
      handler: json['handler'],
      avatarUrl: json['avatarUrl'],
    );
  }
}
