import 'package:flutter/material.dart';
import 'package:postcodes/models/place.dart';
import 'package:postcodes/styles/app_styles.dart';
import 'package:postcodes/utils/number_format.dart';
import 'package:postcodes/widgets/info_row.dart';
import 'package:postcodes/widgets/postcode_chips.dart';
import 'package:postcodes/widgets/section_card.dart';

class PlaceDetailScreen extends StatelessWidget {
  const PlaceDetailScreen({super.key, required this.place});

  final Place place;

  @override
  Widget build(BuildContext context) {
    final postcodes = place.postcodes ?? [];
    final population = place.population;

    return Scaffold(
      appBar: AppBar(title: Text(place.name)),
      body: ListView(
        padding: const EdgeInsets.all(AppStyles.mediumSpace),
        children: [
          SectionCard(
            title: 'Dades',
            child: Column(
              children: [
                InfoRow(
                  icon: Icons.map_outlined,
                  label: 'Província',
                  value: place.admin2,
                ),
                InfoRow(
                  icon: Icons.flag_outlined,
                  label: 'Comunitat autònoma',
                  value: place.admin1,
                ),
                InfoRow(
                  icon: Icons.people_outline,
                  label: 'Habitants',
                  value: population == null
                      ? 'Sense dades'
                      : formatThousands(population),
                ),
                InfoRow(
                  icon: Icons.location_on_outlined,
                  label: 'Coordenades',
                  value: '${place.latitude}, ${place.longitude}',
                ),
              ],
            ),
          ),
          AppStyles.mediumSeparator,
          SectionCard(
            title: postcodes.length == 1
                ? 'Codi postal'
                : 'Codis postals (${postcodes.length})',
            child: PostcodeChips(postcodes: postcodes),
          ),
        ],
      ),
    );
  }
}
