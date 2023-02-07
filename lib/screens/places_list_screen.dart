import 'package:flutter/material.dart';
import 'package:great_places/providers/great_places.dart';
import 'package:provider/provider.dart';

import './add_place_screen.dart';
import 'place_detail_screen.dart';

class PlacesListScreen extends StatelessWidget {
  const PlacesListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Places'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
            },
          ),
        ],
      ),
      body: FutureBuilder(
          future: Provider.of<GreatPlaces>(context, listen: false)
              .fetchAndSetPlaces(),
          builder: (_, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return renderPlaces();
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }

  Widget renderPlaces() {
    return Consumer<GreatPlaces>(
      child: const Center(
        child: Text('Got no places yet, start adding some!'),
      ),
      builder: (ctx, greatPlaces, ch) => greatPlaces.items.isEmpty
          ? ch!
          : ListView.builder(
              itemCount: greatPlaces.items.length,
              itemBuilder: (_, i) => ListTile(
                leading: CircleAvatar(
                  backgroundImage: FileImage(
                    greatPlaces.items[i].image!,
                  ),
                ),
                title: Text(greatPlaces.items[i].title),
                subtitle: Text(greatPlaces.items[i].location?.address ?? ''),
                onTap: () {
                  // go to detail page
                  Navigator.of(ctx).pushNamed(PlaceDetailScreen.routeName,
                      arguments: greatPlaces.items[i].id);
                },
              ),
            ),
    );
  }
}
