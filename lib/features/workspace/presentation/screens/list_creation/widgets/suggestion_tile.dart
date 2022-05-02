import 'package:cached_network_image/cached_network_image.dart';
import 'package:diplom/app/values/colors.dart';
import 'package:diplom/features/workspace/domain/entities/suggestion.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SuggestionTile extends StatefulWidget {
  const SuggestionTile({
    required this.suggestion,
    Key? key,
  }) : super(key: key);

  final Suggestion suggestion;

  @override
  State<StatefulWidget> createState() => _SuggestionTileState();
}

class _SuggestionTileState extends State<SuggestionTile> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            SizedBox(
              width: 24,
              height: 24,
              child: widget.suggestion.imageUrl != null
                  ? CachedNetworkImage(imageUrl: widget.suggestion.imageUrl!)
                  : GestureDetector(
                      onTap: () {},
                      child: Container(
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.grey2,
                        ),
                        padding: const EdgeInsets.all(4),
                        child: const Icon(
                          CupertinoIcons.photo_camera,
                          color: AppColors.blue,
                        ),
                      ),
                    ),
            ),
            const SizedBox(width: 8),
            Text(
              widget.suggestion.name,
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ],
        ),
        Container(
          width: 20,
          height: 10,
          color: AppColors.blue,
        ),
      ],
    );
  }
}
