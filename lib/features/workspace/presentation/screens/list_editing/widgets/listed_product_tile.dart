import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:diplom/app/utils/common_utils.dart';
import 'package:diplom/app/values/colors.dart';
import 'package:diplom/features/workspace/domain/entities/listed_product.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ListedProductTile extends StatefulWidget {
  const ListedProductTile({
    required this.index,
    required this.product,
    required this.incQuantityCallback,
    required this.decQuantityCallback,
    required this.onImageTap,
    required this.onUnitTap,
    this.showImages = true,
    Key? key,
  }) : super(key: key);

  final int index;
  final ListedProduct product;
  final VoidCallback incQuantityCallback;
  final VoidCallback decQuantityCallback;
  final VoidCallback onImageTap;
  final VoidCallback onUnitTap;
  final bool showImages;

  @override
  State<StatefulWidget> createState() => _ListedProductTileState();
}

class _ListedProductTileState extends State<ListedProductTile> {
  bool isIncPressed = false;
  bool isDecPressed = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            GestureDetector(
              onTap: widget.onImageTap,
              child: SizedBox(
                width: 46,
                height: 46,
                child: widget.product.imageUrl != null && widget.showImages
                    ? ClipOval(
                        child: CachedNetworkImage(
                          imageUrl: widget.product.imageUrl!,
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
        Row(
          children: [
            GestureDetector(
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
                padding: const EdgeInsets.all(2),
                decoration: const BoxDecoration(
                  color: AppColors.red,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                  ),
                ),
                child: const Center(
                  child: Icon(CupertinoIcons.minus, color: AppColors.white),
                ),
              ),
            ),
            GestureDetector(
              onTap: widget.onUnitTap,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
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
                padding: const EdgeInsets.all(2),
                decoration: const BoxDecoration(
                  color: AppColors.green,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
                child: const Center(
                  child: Icon(CupertinoIcons.plus, color: AppColors.white),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
