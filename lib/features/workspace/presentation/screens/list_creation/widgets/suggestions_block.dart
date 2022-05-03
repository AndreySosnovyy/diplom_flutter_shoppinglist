import 'package:diplom/app/presentation/widgets/common_scroll_behavior.dart';
import 'package:diplom/app/values/colors.dart';
import 'package:diplom/features/workspace/data/suggestions_source.dart';
import 'package:diplom/features/workspace/domain/entities/suggestion.dart';
import 'package:diplom/features/workspace/presentation/screens/list_creation/widgets/suggestion_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SuggestionsBlock extends StatefulWidget {
  const SuggestionsBlock({
    required this.searchTextNotifier,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  final ValueNotifier<String> searchTextNotifier;
  final Function(Suggestion suggestion) onTap;

  @override
  State<StatefulWidget> createState() => _SuggestionsBlockState();
}

class _SuggestionsBlockState extends State<SuggestionsBlock> {
  final suggestionsSource = SuggestionsSource();
  final List<Suggestion> currentSuggestions = <Suggestion>[];

  double get height {
    if (currentSuggestions.length < 3) {
      return currentSuggestions.length * 45;
    } else {
      return 3 * 45;
    }
  }

  void onSearchUpdate(String text) {
    currentSuggestions.clear();
    if (text.isEmpty) return;
    for (final suggestion in suggestionsSource.suggestions) {
      if (suggestion.name.toLowerCase().contains(text.toLowerCase())) {
        currentSuggestions.add(suggestion);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: widget.searchTextNotifier,
      builder: (context, String value, child) {
        onSearchUpdate(value);
        return Container(
          height: height,
          clipBehavior: Clip.hardEdge,
          decoration: const BoxDecoration(
            color: AppColors.grey3,
            borderRadius: BorderRadius.all(Radius.circular(30)),
          ),
          padding: const EdgeInsets.only(left: 16),
          child: ScrollConfiguration(
            behavior: CommonScrollBehavior(),
            child: ListView.separated(
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(vertical: 6),
              itemCount: currentSuggestions.length,
              itemBuilder: (context, index) => SuggestionTile(
                suggestion: currentSuggestions[index],
                onTap: () => widget.onTap(currentSuggestions[index]),
              ),
              separatorBuilder: (_, __) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(),
                    Container(
                      height: 0.8,
                      margin: const EdgeInsets.symmetric(vertical: 2.6),
                      width: MediaQuery.of(context).size.width * 0.76,
                      color: AppColors.grey2,
                    ),
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }
}
