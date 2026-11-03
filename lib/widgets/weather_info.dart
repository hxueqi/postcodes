import 'package:flutter/material.dart';
import 'package:postcodes/models/current.dart';
import 'package:postcodes/styles/app_styles.dart';
import 'package:postcodes/utils/weather_code.dart';

class WeatherInfo extends StatelessWidget {
  const WeatherInfo({super.key, required this.current});

  final Current current;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          weatherIcon(current.weatherCode),
          size: AppStyles.weatherIconSize,
          color: AppStyles.accent,
        ),
        AppStyles.mediumSeparator,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${current.temperature2M.toStringAsFixed(1)} °C',
                style: AppStyles.temperature,
              ),
              Text(
                weatherDescription(current.weatherCode),
                style: AppStyles.infoValue,
              ),
              AppStyles.tinySeparator,
              Row(
                children: [
                  const Icon(
                    Icons.air,
                    size: AppStyles.infoIconSize,
                    color: AppStyles.greyText,
                  ),
                  AppStyles.tinySeparator,
                  Text(
                    'Vent: ${current.windSpeed10M.toStringAsFixed(1)} km/h',
                    style: AppStyles.infoLabel,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
