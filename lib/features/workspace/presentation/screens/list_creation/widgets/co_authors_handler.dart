import 'package:diplom/app/values/colors.dart';
import 'package:diplom/features/workspace/domain/entities/co_author.dart';
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
            Text(
              'Соавторы',
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(color: AppColors.grey1),
            ),
            const SizedBox(height: 8),
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
                      size: 42,
                      color: AppColors.grey1,
                    ),
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
