import 'package:diplom/app/presentation/widgets/common_scroll_behavior.dart';
import 'package:diplom/app/values/colors.dart';
import 'package:diplom/features/workspace/domain/entities/co_author.dart';
import 'package:diplom/features/workspace/presentation/screens/list_editing/widgets/co_author_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CoAuthorsHandler extends StatelessWidget {
  const CoAuthorsHandler({
    Key? key,
    required this.coAuthors,
    required this.showAddingCoAuthorDialog,
    required this.deleteCoAuthor,
    required this.currentUserHandler,
  }) : super(key: key);

  final List<CoAuthor> coAuthors;
  final Function() showAddingCoAuthorDialog;
  final Function(String userHandler) deleteCoAuthor;
  final String currentUserHandler;

  @override
  Widget build(BuildContext context) {
    final tempCoAuthors = [...coAuthors];
    tempCoAuthors
        .removeWhere((coAuthor) => coAuthor.handler == currentUserHandler);
    return ScrollConfiguration(
      behavior: CommonScrollBehavior(),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(width: 12),
            SizedBox(
              height: 70,
              child: coAuthors.length > 1
                  ? ListView.separated(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: coAuthors.length,
                      itemBuilder: (context, index) {
                        return CoAuthorTile(
                          avatarUrl: coAuthors[index].avatarUrl,
                          name: coAuthors[index].name,
                          handler: coAuthors[index].handler,
                          deleteCallback: () =>
                              deleteCoAuthor(coAuthors[index].handler),
                        );
                      },
                      separatorBuilder: (context, index) =>
                          const SizedBox(width: 12),
                    )
                  : Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: Center(
                        child: Text(
                          'Соавторы',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(color: AppColors.grey1),
                        ),
                      ),
                    ),
            ),
            GestureDetector(
              onTap: showAddingCoAuthorDialog,
              child: const Padding(
                padding: EdgeInsets.only(left: 16),
                child: SizedBox(
                  child: Icon(
                    CupertinoIcons.add_circled,
                    size: 44,
                    color: AppColors.blue,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
