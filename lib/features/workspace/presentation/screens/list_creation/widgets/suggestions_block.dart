import 'package:diplom/features/workspace/domain/entities/suggestion.dart';
import 'package:flutter/cupertino.dart';

class SuggestionsBlock extends StatelessWidget {
  const SuggestionsBlock({
    required this.suggestionsNotifier,
    Key? key,
  }) : super(key: key);

  final ValueNotifier<List<Suggestion>> suggestionsNotifier;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: suggestionsNotifier,
      builder: (context, List<Suggestion> value, child) {
        return Container();
      },
    );
  }
}
