import 'package:flutter/material.dart';
import 'package:postcodes/models/place.dart';
import 'package:postcodes/styles/app_styles.dart';

class PlaceTile extends StatelessWidget {
  const PlaceTile({super.key, required this.place, this.onTap});

  final Place place;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: AppStyles.surface,
      leading: const CircleAvatar(
        backgroundColor: AppStyles.primaryLight,
        foregroundColor: AppStyles.primary,
        child: Icon(Icons.location_city),
      ),
      title: Text(place.name, style: AppStyles.placeName),
      subtitle: Text(
        '${place.admin2} · ${place.admin1}',
        style: AppStyles.placeRegion,
      ),
      trailing: onTap == null ? null : const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}
