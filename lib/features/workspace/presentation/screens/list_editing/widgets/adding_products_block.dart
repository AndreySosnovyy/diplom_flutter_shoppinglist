import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:diplom/app/presentation/widgets/common_scroll_behavior.dart';
import 'package:diplom/app/utils/string_extensions.dart';
import 'package:diplom/app/values/colors.dart';
import 'package:diplom/features/workspace/data/suggestions_source.dart';
import 'package:diplom/features/workspace/domain/entities/suggestion.dart';
import 'package:diplom/features/workspace/presentation/screens/list_editing/widgets/suggestion_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddingProductsBlock extends StatefulWidget {
  const AddingProductsBlock({
    required this.searchTextNotifier,
    required this.onSuggestionTap,
    required this.addByProductName,
    this.showImages = true,
    this.showSuggestions = true,
    Key? key,
  }) : super(key: key);

  final ValueNotifier<String> searchTextNotifier;
  final bool showImages;
  final bool showSuggestions;
  final Function(Suggestion suggestion) onSuggestionTap;
  final Function(String productName) addByProductName;

  @override
  State<StatefulWidget> createState() => _AddingProductsBlockState();
}

class _AddingProductsBlockState extends State<AddingProductsBlock> {
  final suggestionsSource = SuggestionsSource();
  final List<Suggestion> currentSuggestions = <Suggestion>[];

  double get blockHeight {
    const double defaultHeight = 54;
    if (widget.searchTextNotifier.value.isEmpty) return 0;
    if (!widget.showSuggestions) return defaultHeight;
    if (currentSuggestions.isEmpty) return defaultHeight;
    return min(currentSuggestions.length, 3) * 45 + defaultHeight + 24;
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
          height: blockHeight,
          clipBehavior: Clip.hardEdge,
          decoration: const BoxDecoration(
            color: AppColors.grey3,
            borderRadius: BorderRadius.all(Radius.circular(30)),
          ),
          padding: const EdgeInsets.only(left: 16),
          margin: const EdgeInsets.only(top: 16),
          child: ScrollConfiguration(
            behavior: CommonScrollBehavior(),
            child: Column(
              children: [
                const SizedBox(height: 8),
                GestureDetector(
                  onTap: () => widget.addByProductName(value),
                  behavior: HitTestBehavior.opaque,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 36,
                        height: 36,
                        child: Container(
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.white,
                          ),
                          padding: const EdgeInsets.all(4),
                          child: const Center(
                            child: Icon(
                              CupertinoIcons.plus,
                              color: AppColors.blue,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: AutoSizeText(
                          'Добавить «${value.capitalize()}»',
                          maxLines: 1,
                          style: Theme.of(context).textTheme.bodyText1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
                if (currentSuggestions.isNotEmpty && widget.showSuggestions)
                  Column(
                    children: [
                      Container(
                        height: 1,
                        margin: const EdgeInsets.only(top: 6, bottom: 6),
                        color: AppColors.blue,
                      ),
                      Center(
                        child: Text(
                          'Возможно вы искали:',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2!
                              .copyWith(color: AppColors.grey1),
                        ),
                      ),
                    ],
                  ),
                if (widget.showSuggestions)
                  Expanded(
                    child: Scrollbar(
                      child: ListView.separated(
                        shrinkWrap: true,
                        padding: const EdgeInsets.only(top: 4, bottom: 6),
                        itemCount: currentSuggestions.length,
                        itemBuilder: (context, index) => SuggestionTile(
                          suggestion: currentSuggestions[index],
                          onTap: () =>
                              widget.onSuggestionTap(currentSuggestions[index]),
                          showImages: widget.showImages,
                        ),
                        separatorBuilder: (_, __) => Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const SizedBox(),
                            Container(
                              height: 0.6,
                              width: MediaQuery.of(context).size.width * 0.76,
                              margin: const EdgeInsets.symmetric(vertical: 2.6),
                              color: AppColors.grey2,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
