import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:diplom/app/values/colors.dart';
import 'package:diplom/features/workspace/domain/entities/shopping_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ShoppingListTile extends StatefulWidget {
  const ShoppingListTile({
    required this.shoppingList,
    required this.setIsMarked,
    required this.onTap,
    required this.onLongPress,
    required this.scrollNotifier,
    Key? key,
  }) : super(key: key);

  final ShoppingList shoppingList;
  final Function(bool value) setIsMarked;
  final VoidCallback onTap;
  final VoidCallback onLongPress;
  final ValueNotifier<bool> scrollNotifier;

  @override
  State<StatefulWidget> createState() => _ShoppingListTileState();
}

class _ShoppingListTileState extends State<ShoppingListTile>
    with SingleTickerProviderStateMixin {
  late double _scale;
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 50),
      lowerBound: 0.0,
      upperBound: 0.1,
    )..addListener(() => setState(() {}));
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ShoppingList shoppingList = widget.shoppingList;
    final Color tileColor = widget.shoppingList.color;

    _scale = 1 - _controller.value;
    void _tapDown() => _controller.forward();
    void _tapUp() => _controller.reverse();

    return ValueListenableBuilder(
      valueListenable: widget.scrollNotifier,
      builder: (context, _, __) {
        if (widget.scrollNotifier.value) {
          _tapUp();
        }
        return GestureDetector(
          onTap: widget.onTap,
          onLongPress: () {
            _tapUp();
            widget.onLongPress();
          },
          onTapDown: (_) => _tapDown(),
          onTapUp: (_) => _tapUp(),
          onPanEnd: (dragEndDetails) => _tapUp(),
          child: Transform.scale(
            scale: _scale,
            child: Container(
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
              padding:
                  const EdgeInsets.only(left: 14, right: 14, top: 8, bottom: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: AutoSizeText(
                          shoppingList.title,
                          style:
                              Theme.of(context).textTheme.subtitle1!.copyWith(
                                    color: AppColors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                          maxLines: 2,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() =>
                              shoppingList.isPinned = !shoppingList.isPinned);
                          widget.setIsMarked(shoppingList.isPinned);
                        },
                        icon: shoppingList.isPinned
                            ? const Icon(
                                CupertinoIcons.bookmark_fill,
                                size: 32,
                                color: AppColors.white,
                              )
                            : const Icon(
                                CupertinoIcons.bookmark,
                                size: 32,
                                color: AppColors.white,
                              ),
                      ),
                    ],
                  ),
                  Container(
                    width: double.infinity,
                    height: 1.8,
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
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      _IconTextPair(
                        text: shoppingList.listedProducts.length.toString(),
                        iconData: FontAwesomeIcons.cartArrowDown,
                        color: AppColors.white,
                      ),
                      _IconTextPair(
                        text: shoppingList.coAuthors.length.toString(),
                        iconData: FontAwesomeIcons.users,
                        color: AppColors.white,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _IconTextPair extends StatelessWidget {
  const _IconTextPair({
    required this.iconData,
    required this.text,
    required this.color,
    Key? key,
  }) : super(key: key);

  final IconData iconData;
  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 14),
      child: Row(
        children: [
          Icon(
            iconData,
            color: color,
            size: 13,
          ),
          const SizedBox(width: 6),
          Text(
            text,
            style:
                Theme.of(context).textTheme.bodyText2!.copyWith(color: color),
          ),
        ],
      ),
    );
  }
}
