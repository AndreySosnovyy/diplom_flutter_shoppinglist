import 'package:diplom/app/presentation/widgets/common_scroll_behavior.dart';
import 'package:diplom/app/values/colors.dart';
import 'package:diplom/features/workspace/domain/entities/co_author.dart';
import 'package:diplom/features/workspace/presentation/screens/list_editing/widgets/co_author_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CoAuthorsHandler extends StatelessWidget {
  const CoAuthorsHandler({
    Key? key,
    // required this.coAuthorsNotifier,
    required this.coAuthors,
    required this.showAddingCoAuthorDialog,
    required this.deleteCoAuthor,
  }) : super(key: key);

  // final ValueNotifier<List<CoAuthor>> coAuthorsNotifier;
  final List<CoAuthor> coAuthors;
  final Function() showAddingCoAuthorDialog;
  final Function(String userHandler) deleteCoAuthor;

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: CommonScrollBehavior(),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: showAddingCoAuthorDialog,
              child: const SizedBox(
                child: Icon(
                  CupertinoIcons.plus_circled,
                  size: 64,
                  color: AppColors.blue,
                ),
              ),
            ),
            const SizedBox(width: 12),
            coAuthors.isNotEmpty
                ? SizedBox(
                    width: MediaQuery.of(context).size.width - 108,
                    height: 70,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: coAuthors.length,
                      itemBuilder: (context, index) => CoAuthorTile(
                        avatarUrl: coAuthors[index].avatarUrl,
                        name: coAuthors[index].name,
                        handler: coAuthors[index].handler,
                        deleteCallback: () =>
                            deleteCoAuthor(coAuthors[index].handler),
                      ),
                      separatorBuilder: (context, index) =>
                          const SizedBox(width: 12),
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: Text(
                      'Соавторы',
                      style: Theme.of(context)
                          .textTheme
                          .subtitle1!
                          .copyWith(color: AppColors.grey1),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
