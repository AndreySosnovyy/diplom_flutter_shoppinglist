import 'package:auto_size_text/auto_size_text.dart';
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
      children: [
        SizedBox(
          width: 36,
          height: 36,
          child: widget.suggestion.imageUrl != null
              ? CachedNetworkImage(imageUrl: widget.suggestion.imageUrl!)
              : Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.white,
                ),
                padding: const EdgeInsets.all(4),
                child: Icon(
                  CupertinoIcons.question,
                  color: AppColors.blue.withOpacity(0.3),
                ),
              ),
        ),
        const SizedBox(width: 16),
        AutoSizeText(
          widget.suggestion.name,
          style: Theme.of(context).textTheme.bodyText1,
        ),
      ],
    );
  }
}
