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
}
