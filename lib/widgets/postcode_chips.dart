import 'package:flutter/material.dart';
import 'package:postcodes/styles/app_styles.dart';

class PostcodeChips extends StatelessWidget {
  const PostcodeChips({super.key, required this.postcodes});

  final List<String> postcodes;

  @override
  Widget build(BuildContext context) {
    if (postcodes.isEmpty) {
      return const Text(
        'No hi ha codis postals per a aquesta població.',
        style: AppStyles.statusMessage,
      );
    }

    return Wrap(
      spacing: AppStyles.smallSpace,
      runSpacing: AppStyles.smallSpace,
      children: [
        for (final code in postcodes)
          Chip(
            label: Text(code, style: AppStyles.chipText),
            backgroundColor: AppStyles.primaryLight,
            side: BorderSide.none,
          ),
      ],
    );
  }
}
