import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:diplom/app/values/colors.dart';
import 'package:diplom/features/workspace/domain/entities/shopping_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ShoppingListTile extends StatefulWidget {
  const ShoppingListTile({
    required this.shoppingList,
    required this.setIsMarked,
    Key? key,
  }) : super(key: key);

  final ShoppingList shoppingList;
  final Function(bool value) setIsMarked;

  @override
  State<StatefulWidget> createState() => _ShoppingListTileState();
}

class _ShoppingListTileState extends State<ShoppingListTile> {
  @override
  Widget build(BuildContext context) {
    final ShoppingList shoppingList = widget.shoppingList;
    final Color tileColor = widget.shoppingList.color;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.centerRight,
          colors: [
            Color.fromARGB(
              255,
              min(tileColor.red + 30, 255),
              min(tileColor.green + 30, 255),
              min(tileColor.blue + 30, 255),
            ),
            Color.fromARGB(
              255,
              max(tileColor.red - 10, 0),
              max(tileColor.green - 10, 0),
              max(tileColor.blue - 10, 0),
            ),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.grey1.withOpacity(0.3),
            spreadRadius: 3,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                shoppingList.title,
                style: Theme.of(context)
                    .textTheme
                    .headline2!
                    .copyWith(color: AppColors.white),
              ),
              IconButton(
                onPressed: () {
                  setState(() => shoppingList.isPinned = !shoppingList.isPinned);
                  widget.setIsMarked(shoppingList.isPinned);
                },
                icon: shoppingList.isPinned
                    ? const Icon(
                        CupertinoIcons.bookmark_fill,
                        size: 36,
                        color: AppColors.white,
                      )
                    : const Icon(
                        CupertinoIcons.bookmark,
                        size: 36,
                        color: AppColors.white,
                      ),
              ),
            ],
          ),
          Container(
            width: double.infinity,
            height: 2.4,
            decoration: const BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            margin: const EdgeInsets.symmetric(vertical: 8),
          ),
          if (shoppingList.description != null)
            AutoSizeText(
              shoppingList.description!,
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(color: AppColors.white),
              maxLines: 3,
              minFontSize: 14,
              overflow: TextOverflow.ellipsis,
            ),
        ],
      ),
    );
  }
}
