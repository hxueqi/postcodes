import 'package:flutter/material.dart';
import 'package:postcodes/styles/app_styles.dart';

class StatusMessage extends StatelessWidget {
  const StatusMessage({
    super.key,
    required this.icon,
    required this.title,
    required this.message,
    this.iconColor = AppStyles.primary,
    this.buttonLabel,
    this.onButtonPressed,
  });

  final IconData icon;
  final String title;
  final String message;
  final Color iconColor;
  final String? buttonLabel;
  final VoidCallback? onButtonPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(AppStyles.hugeSpace),
        child: Column(
          children: [
            Icon(icon, size: AppStyles.statusIconSize, color: iconColor),
            AppStyles.mediumSeparator,
            Text(title, style: AppStyles.statusTitle, textAlign: TextAlign.center),
            AppStyles.smallSeparator,
            Text(message, style: AppStyles.statusMessage, textAlign: TextAlign.center),
            if (buttonLabel != null) ...[
              AppStyles.bigSeparator,
              FilledButton.icon(
                onPressed: onButtonPressed,
                icon: const Icon(Icons.refresh),
                label: Text(buttonLabel!),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
