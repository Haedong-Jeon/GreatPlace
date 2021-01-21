import 'package:GreatPlace/providers/great_places.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './add_place_screen.dart';
import '../providers/great_places.dart';

class PlacesListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your places'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
            },
          ),
        ],
      ),
      body: Consumer<GreatePlaces>(
        child: Center(
          child: Text('Got no places yet'),
        ),
        builder: (context, greatePlaces, ch) {
          return greatePlaces.items.length <= 0
              ? ch
              : ListView.builder(
                  itemCount: greatePlaces.items.length,
                  itemBuilder: (
                    context,
                    index,
                  ) {
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage:
                            FileImage(greatePlaces.items[index].image),
                      ),
                      title: Text(greatePlaces.items[index].title),
                      onTap: () {},
                    );
                  },
                );
        },
      ),
    );
  }
}
