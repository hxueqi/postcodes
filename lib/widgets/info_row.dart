import 'package:flutter/material.dart';
import 'package:postcodes/styles/app_styles.dart';

class InfoRow extends StatelessWidget {
  const InfoRow({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppStyles.smallSpace),
      child: Row(
        children: [
          Icon(icon, color: AppStyles.primary, size: AppStyles.infoIconSize),
          AppStyles.mediumSeparator,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: AppStyles.infoLabel),
                Text(value, style: AppStyles.infoValue),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
