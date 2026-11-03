import 'package:flutter/material.dart';
import 'package:postcodes/models/place.dart';
import 'package:postcodes/models/search_status.dart';
import 'package:postcodes/screens/place_detail_screen.dart';
import 'package:postcodes/services/geocoding_api.dart';
import 'package:postcodes/styles/app_styles.dart';
import 'package:postcodes/widgets/place_tile.dart';
import 'package:postcodes/widgets/status_message.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _controller = TextEditingController();

  SearchStatus _status = SearchStatus.initial;
  List<Place> _places = [];
  String _query = '';

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _search(String text) async {
    final query = text.trim();
    if (query.isEmpty) return;

    FocusScope.of(context).unfocus();
    setState(() {
      _query = query;
      _status = SearchStatus.loading;
    });

    try {
      final places = await GeocodingApi.search(query);
      // Ignore the answer if the user started a new search meanwhile.
      if (!mounted || query != _query) return;
      setState(() {
        _places = places;
        _status = places.isEmpty ? SearchStatus.notFound : SearchStatus.results;
      });
    } catch (e) {
      debugPrint('Search error: $e');
      if (!mounted || query != _query) return;
      setState(() => _status = SearchStatus.error);
    }
  }

  void _openDetail(Place place) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PlaceDetailScreen(place: place)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Codis postals')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(AppStyles.mediumSpace),
            child: TextField(
              controller: _controller,
              textInputAction: TextInputAction.search,
              onSubmitted: _search,
              decoration: InputDecoration(
                hintText: 'Codi postal o nom de població',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: AppStyles.surface,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppStyles.fieldRadius),
                ),
              ),
            ),
          ),
          Expanded(child: _buildBody()),
        ],
      ),
    );
  }

  Widget _buildBody() {
    switch (_status) {
      case SearchStatus.initial:
        return const StatusMessage(
          icon: Icons.travel_explore,
          title: 'Cerca una població',
          message:
              "Escriu un codi postal (per exemple, 17820) o el nom d'una "
              'població i prem la lupa del teclat.',
        );
      case SearchStatus.loading:
        return const Center(child: CircularProgressIndicator());
      case SearchStatus.notFound:
        return StatusMessage(
          icon: Icons.search_off,
          iconColor: AppStyles.accent,
          title: 'No hem trobat cap població per a «$_query»',
          message: 'Revisa el codi postal o prova amb un altre nom.',
        );
      case SearchStatus.error:
        return StatusMessage(
          icon: Icons.wifi_off,
          iconColor: AppStyles.error,
          title: "No s'ha pogut fer la cerca",
          message: 'Comprova la connexió a internet i torna-ho a provar.',
          buttonLabel: 'Torna-ho a provar',
          onButtonPressed: () => _search(_query),
        );
      case SearchStatus.results:
        return _buildResults();
    }
  }

  Widget _buildResults() {
    final count = _places.length;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppStyles.mediumSpace),
          child: Text(
            count == 1 ? '1 resultat' : '$count resultats',
            style: AppStyles.resultsCount,
          ),
        ),
        AppStyles.smallSeparator,
        Expanded(
          child: ListView.separated(
            itemCount: count,
            separatorBuilder: (context, index) => const Divider(height: 1),
            itemBuilder: (context, index) {
              final place = _places[index];
              return PlaceTile(
                place: place,
                onTap: () => _openDetail(place),
              );
            },
          ),
        ),
      ],
    );
  }
}
