import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../providers/great_places.dart';
import '../utils/weather_service.dart';

class PlacesListScreen extends StatefulWidget {
  @override
  State<PlacesListScreen> createState() => _PlacesListScreenState();
}

class _PlacesListScreenState extends State<PlacesListScreen> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    Provider.of<GreatPlaces>(context, listen: false)
        .loadPlaces()
        .then((_) => setState(() => _isLoading = false));
  }

  @override
  Widget build(BuildContext context) {
    final places = Provider.of<GreatPlaces>(context).items;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Minhas Viagens"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => FirebaseAuth.instance.signOut(),
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : places.isEmpty
              ? const Center(child: Text("Nenhuma viagem cadastrada."))
              : ListView.builder(
                  itemCount: places.length,
                  itemBuilder: (ctx, i) {
                    final place = places[i];

                    return FutureBuilder(
                      future: WeatherService().getWeather(
                        place.location.latitude,
                        place.location.longitude,
                      ),
                      builder: (ctx, snapshot) {
                        if (!snapshot.hasData) {
                          return const ListTile(
                            title: Text("Carregando clima..."),
                          );
                        }

                        final weather = snapshot.data!;
                        final temp = weather['main']['temp'];

                        return ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(place.imageUrl),
                          ),
                          title: Text(place.title),
                          subtitle: Text("Temperatura: $temp°C"),
                        );
                      },
                    );
                  },
                ),
    );
  }
}
