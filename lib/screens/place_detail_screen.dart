import 'package:flutter/material.dart';
import 'package:postcodes/models/current.dart';
import 'package:postcodes/models/place.dart';
import 'package:postcodes/services/weather_api.dart';
import 'package:postcodes/styles/app_styles.dart';
import 'package:postcodes/utils/number_format.dart';
import 'package:postcodes/widgets/info_row.dart';
import 'package:postcodes/widgets/postcode_chips.dart';
import 'package:postcodes/widgets/section_card.dart';
import 'package:postcodes/widgets/weather_info.dart';

class PlaceDetailScreen extends StatefulWidget {
  const PlaceDetailScreen({super.key, required this.place});

  final Place place;

  @override
  State<PlaceDetailScreen> createState() => _PlaceDetailScreenState();
}

class _PlaceDetailScreenState extends State<PlaceDetailScreen> {
  late Future<Current> _weatherFuture;

  @override
  void initState() {
    super.initState();
    _loadWeather();
  }

  void _loadWeather() {
    _weatherFuture = WeatherApi.getCurrent(
      widget.place.latitude,
      widget.place.longitude,
    );
  }

  @override
  Widget build(BuildContext context) {
    final place = widget.place;
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
          SectionCard(title: 'El temps ara', child: _buildWeather()),
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

  Widget _buildWeather() {
    return FutureBuilder<Current>(
      future: _weatherFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Padding(
            padding: EdgeInsets.all(AppStyles.mediumSpace),
            child: Center(child: CircularProgressIndicator()),
          );
        }
        if (snapshot.hasError || !snapshot.hasData) {
          return Row(
            children: [
              const Icon(Icons.cloud_off, color: AppStyles.error),
              AppStyles.smallSeparator,
              const Expanded(
                child: Text(
                  "No s'ha pogut carregar el temps.",
                  style: AppStyles.statusMessage,
                ),
              ),
              TextButton(
                onPressed: () => setState(_loadWeather),
                child: const Text('Torna-ho a provar'),
              ),
            ],
          );
        }
        return WeatherInfo(current: snapshot.data!);
      },
    );
  }
}
