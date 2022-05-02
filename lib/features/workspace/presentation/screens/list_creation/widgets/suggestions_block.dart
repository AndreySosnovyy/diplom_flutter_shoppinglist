import 'package:diplom/app/presentation/widgets/common_scroll_behavior.dart';
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
  double get height {
    if (widget.suggestionsNotifier.value.length < 3) {
      return widget.suggestionsNotifier.value.length * 44;
    } else {
      return 3 * 44;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: widget.suggestionsNotifier,
      builder: (context, List<Suggestion> value, child) {
        return widget.suggestionsNotifier.value.isNotEmpty
            ? Container(
                clipBehavior: Clip.hardEdge,
                decoration: const BoxDecoration(
                  color: AppColors.grey3,
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
                padding: const EdgeInsets.only(left: 16),
                child: SizedBox(
                  height: height,
                  child: ScrollConfiguration(
                    behavior: CommonScrollBehavior(),
                    child: ListView.separated(
                      shrinkWrap: true,
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      itemCount: widget.suggestionsNotifier.value.length,
                      itemBuilder: (context, index) => SuggestionTile(
                        suggestion: widget.suggestionsNotifier.value[index],
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
                ),
              )
            : const SizedBox();
      },
    );
  }
}
