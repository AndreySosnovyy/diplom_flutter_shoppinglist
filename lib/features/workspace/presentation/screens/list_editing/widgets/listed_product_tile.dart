import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:diplom/app/utils/common_utils.dart';
import 'package:diplom/app/values/colors.dart';
import 'package:diplom/features/workspace/domain/entities/listed_product.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ListedProductTile extends StatefulWidget {
  const ListedProductTile({
    required this.index,
    required this.product,
    required this.incQuantityCallback,
    required this.decQuantityCallback,
    required this.onTap,
    required this.onLongPress,
    required this.onImageTap,
    required this.onUnitTap,
    required this.deleteCallback,
    this.showImages = true,
    Key? key,
  }) : super(key: key);

  final int index;
  final ListedProduct product;
  final VoidCallback incQuantityCallback;
  final VoidCallback decQuantityCallback;
  final VoidCallback onTap;
  final VoidCallback onLongPress;
  final VoidCallback onImageTap;
  final VoidCallback onUnitTap;
  final VoidCallback deleteCallback;
  final bool showImages;

  @override
  State<StatefulWidget> createState() => _ListedProductTileState();
}

class _ListedProductTileState extends State<ListedProductTile> {
  bool isIncPressed = false;
  bool isDecPressed = false;

  Color get _tileColor {
    switch (widget.product.status) {
      case Status.unchecked:
        return AppColors.white;
      case Status.checked:
        return AppColors.green.withOpacity(0.24);
      case Status.unavailable:
        return AppColors.red.withOpacity(0.24);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: UniqueKey(),
      startActionPane: ActionPane(
        motion: const ScrollMotion(),
        dismissible: DismissiblePane(
          onDismissed: widget.deleteCallback,
        ),
        children: [
          SlidableAction(
            onPressed: (_) => widget.deleteCallback(),
            backgroundColor: AppColors.red,
            foregroundColor: AppColors.white,
            icon: CupertinoIcons.delete_solid,
            label: 'Удалить',
          ),
        ],
      ),

      // The end action pane is the one at the right or the bottom side.
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        dismissible: DismissiblePane(
          onDismissed: widget.deleteCallback,
        ),
        children: [
          SlidableAction(
            onPressed: (_) => widget.deleteCallback(),
            backgroundColor: AppColors.red,
            foregroundColor: AppColors.white,
            icon: CupertinoIcons.delete_solid,
            label: 'Удалить',
          ),
        ],
      ),
      child: GestureDetector(
        onTap: () {
          setState(() => widget.product.status =
              widget.product.status != Status.checked
                  ? Status.checked
                  : Status.unchecked);
          widget.onTap();
        },
        onLongPress: () {
          setState(() => widget.product.status =
              widget.product.status != Status.unavailable
                  ? Status.unavailable
                  : Status.unchecked);
          widget.onLongPress();
        },
        behavior: HitTestBehavior.opaque,
        child: Container(
          color: _tileColor,
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: widget.onImageTap,
                    child: SizedBox(
                      width: 46,
                      height: 46,
                      child:
                          widget.product.imageUrl != null && widget.showImages
                              ? ClipOval(
                                  child: CachedNetworkImage(
                                    imageUrl: widget.product.imageUrl!,
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : Container(
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColors.grey3,
                                  ),
                                  padding: const EdgeInsets.all(4),
                                  child: Center(
                                    child: Icon(
                                      CupertinoIcons.photo_camera,
                                      color: AppColors.blue.withOpacity(0.5),
                                    ),
                                  ),
                                ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.45,
                    child: AutoSizeText(
                      widget.product.name,
                      maxLines: 2,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ),
                ],
              ),
              // todo: not update while pressing
              Row(
                children: [
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      widget.decQuantityCallback();
                      setState(() {});
                    },
                    onLongPressStart: (_) async {
                      isDecPressed = true;
                      do {
                        widget.decQuantityCallback();
                        await Future.delayed(const Duration(milliseconds: 10));
                      } while (isDecPressed);
                    },
                    onLongPressEnd: (_) => isDecPressed = false,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      margin: const EdgeInsets.symmetric(vertical: 6),
                      decoration: const BoxDecoration(
                        color: AppColors.red,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          bottomLeft: Radius.circular(20),
                        ),
                      ),
                      child: const Center(
                        child:
                            Icon(CupertinoIcons.minus, color: AppColors.white),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: widget.onUnitTap,
                    behavior: HitTestBehavior.opaque,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 5,
                        vertical: 15,
                      ),
                      child: Text(
                        '${widget.product.amount} '
                        '${WorkspaceUtils.unitToString(widget.product.unit)}',
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2!
                            .copyWith(color: AppColors.grey1),
                      ),
                    ),
                  ),
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      widget.incQuantityCallback();
                      setState(() {});
                    },
                    onLongPressStart: (_) async {
                      isIncPressed = true;
                      do {
                        widget.incQuantityCallback();
                        await Future.delayed(const Duration(milliseconds: 10));
                      } while (isIncPressed);
                    },
                    onLongPressEnd: (_) => isIncPressed = false,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      margin: const EdgeInsets.symmetric(vertical: 6),
                      decoration: const BoxDecoration(
                        color: AppColors.green,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        ),
                      ),
                      child: const Center(
                        child:
                            Icon(CupertinoIcons.plus, color: AppColors.white),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
