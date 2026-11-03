import 'package:flutter/material.dart';

/// Description of the sky for an Open-Meteo weather_code.
String weatherDescription(int code) {
  if (code == 0) return 'Cel serè';
  if (code >= 1 && code <= 3) return 'Alguns núvols';
  if (code == 45 || code == 48) return 'Boira';
  if (code >= 51 && code <= 67) return 'Pluja';
  if (code >= 71 && code <= 77) return 'Neu';
  if (code >= 80 && code <= 82) return 'Ruixats';
  if (code == 85 || code == 86) return 'Ruixats de neu';
  if (code >= 95 && code <= 99) return 'Tempesta';
  return 'Desconegut';
}

/// Icon that matches an Open-Meteo weather_code.
IconData weatherIcon(int code) {
  if (code == 0) return Icons.wb_sunny_outlined;
  if (code >= 1 && code <= 3) return Icons.cloud_outlined;
  if (code == 45 || code == 48) return Icons.foggy;
  if ((code >= 71 && code <= 77) || code == 85 || code == 86) {
    return Icons.ac_unit;
  }
  if (code >= 95 && code <= 99) return Icons.thunderstorm_outlined;
  if (code >= 51 && code <= 82) return Icons.water_drop_outlined;
  return Icons.help_outline;
}
