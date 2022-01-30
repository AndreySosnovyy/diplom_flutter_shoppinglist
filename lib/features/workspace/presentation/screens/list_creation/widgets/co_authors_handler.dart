import 'package:diplom/app/values/colors.dart';
import 'package:diplom/features/workspace/domain/entities/co_author.dart';
import 'package:diplom/features/workspace/presentation/screens/list_creation/widgets/co_author_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CoAuthorsHandler extends StatelessWidget {
  final List<CoAuthor> coAuthors;
  final VoidCallback addCoAuthorCallback;

  const CoAuthorsHandler({
    Key? key,
    required this.coAuthors,
    required this.addCoAuthorCallback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: addCoAuthorCallback,
                  child: const SizedBox(
                    child: Icon(
                      CupertinoIcons.plus_circled,
                      size: 54,
                      color: AppColors.blue,
                    ),
                  ),
                ),
                if (coAuthors.isEmpty)
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: Text(
                      'Соавторы',
                      style: Theme.of(context)
                          .textTheme
                          .subtitle1!
                          .copyWith(color: AppColors.grey1),
                    ),
                  ),
                const SizedBox(width: 12),
                if (coAuthors.isNotEmpty)
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 98,
                    height: 54,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: coAuthors.length,
                      itemBuilder: (context, index) => CoAuthorTile(
                        avatarUrl: coAuthors[index].avatarUrl,
                        name: coAuthors[index].name,
                        handler: coAuthors[index].handler,
                        deleteCallback: () {},
                      ),
                      separatorBuilder: (context, index) =>
                          const SizedBox(width: 12),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
