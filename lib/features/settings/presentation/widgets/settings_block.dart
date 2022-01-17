import 'package:diplom/app/values/colors.dart';
import 'package:diplom/features/settings/domain/entities/settings_tile_model.dart';
import 'package:diplom/features/settings/presentation/widgets/settings_tile.dart';
import 'package:flutter/material.dart';

class SettingsBlock extends StatelessWidget {
  final String title;
  final List<SettingsTileModel> settingsContent;
  final String? description;

  const SettingsBlock({
    Key? key,
    required this.title,
    required this.settingsContent,
    this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 14),
            child: Text(
              title.toUpperCase(),
              style: Theme.of(context)
                  .textTheme
                  .bodyText2
                  ?.copyWith(color: AppColors.grey1),
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: AppColors.white,
            ),
            child: Column(
              children: [
                for (var i = 0; i < settingsContent.length; i++)
                  SettingsTile(
                    content: settingsContent[i],
                    hasBottomBorder: i != settingsContent.length - 1,
                  ),
              ],
            ),
          ),
          if (description != null)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 14),              child: Text(
                description!,
                style: Theme.of(context)
                    .textTheme
                    .bodyText2
                    ?.copyWith(color: AppColors.grey1),
              ),
            ),
        ],
      ),
    );
  }
}
