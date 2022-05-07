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
    required this.incQuantity,
    required this.decQuantity,
    Key? key,
  }) : super(key: key);

  final int index;
  final ListedProduct product;
  final VoidCallback incQuantity;
  final VoidCallback decQuantity;

  @override
  State<StatefulWidget> createState() => _ListedProductTileState();
}

class _ListedProductTileState extends State<ListedProductTile> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            SizedBox(
              width: 46,
              height: 46,
              child: widget.product.imageUrl != null
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
                          CupertinoIcons.question,
                          color: AppColors.blue.withOpacity(0.5),
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
                widget.decQuantity();
                setState(() {});
              },
              child: Container(
                padding: const EdgeInsets.all(2),
                decoration: const BoxDecoration(
                  color: AppColors.red,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                  ),
                ),
                child: const Center(
                  child: Icon(
                    CupertinoIcons.minus,
                    color: AppColors.white,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Text(
                '${widget.product.amount} '
                '${WorkspaceUtils.unitToString(widget.product.unit)}',
                style: Theme.of(context)
                    .textTheme
                    .bodyText2!
                    .copyWith(color: AppColors.grey1),
                maxLines: 2,
              ),
            ),
            GestureDetector(
              onTap: () {
                widget.incQuantity();
                setState(() {});
              },
              child: Container(
                padding: const EdgeInsets.all(2),
                decoration: const BoxDecoration(
                  color: AppColors.green,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                ),
                child: const Center(
                  child: Icon(
                    CupertinoIcons.plus,
                    color: AppColors.white,
                  ),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
