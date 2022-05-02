import 'dart:math';

import 'package:diplom/app/values/colors.dart';
import 'package:diplom/features/workspace/domain/entities/suggestion.dart';
import 'package:diplom/features/workspace/presentation/screens/list_creation/widgets/suggestion_tile.dart';
import 'package:flutter/cupertino.dart';

class SuggestionsBlock extends StatefulWidget {
  const SuggestionsBlock({
    required this.suggestionsNotifier,
    Key? key,
  }) : super(key: key);

  final ValueNotifier<List<Suggestion>> suggestionsNotifier;

  @override
  State<StatefulWidget> createState() => _SuggestionsBlockState();
}

class _SuggestionsBlockState extends State<SuggestionsBlock> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: widget.suggestionsNotifier,
      builder: (context, List<Suggestion> value, child) {
        return widget.suggestionsNotifier.value.isNotEmpty
            ? Container(
                decoration: const BoxDecoration(
                  color: AppColors.grey3,
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
                padding: const EdgeInsets.all(8),
                child: ListView.separated(
                  padding: const EdgeInsets.only(bottom: 8),
                  shrinkWrap: true,
                  itemCount: min(widget.suggestionsNotifier.value.length, 3),
                  itemBuilder: (context, index) => SuggestionTile(
                    suggestion: widget.suggestionsNotifier.value[index],
                  ),
                  separatorBuilder: (_, __) => const SizedBox(height: 8),
                ),
              )
            : const SizedBox();
      },
    );
  }
}
