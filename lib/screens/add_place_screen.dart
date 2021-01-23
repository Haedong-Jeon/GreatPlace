import 'dart:developer';

import 'package:GreatPlace/models/place.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/great_places.dart';
import '../widgets/image_input.dart';
import '../widgets/location_input.dart';
import '../models/place.dart';
import 'dart:io';

class AddPlaceScreen extends StatefulWidget {
  static const String routeName = './screens/add_place_screen';
  @override
  _AddPlaceScreenState createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  final _titleController = TextEditingController();
  File _pickedImage;
  PlaceLocation _pickedLocation;

  void _selectImage(File pickedImage) {
    _pickedImage = pickedImage;
  }

  void _selectPlace(double latitude, double longitude) {
    _pickedLocation = PlaceLocation(latitude: latitude, longitude: longitude);
  }

  void _savePlace() {
    if (_titleController.text.isEmpty ||
        _pickedImage == null ||
        _pickedLocation == null) return;
    print("save!");
    Provider.of<GreatePlaces>(context, listen: false).addPlace(
      _titleController.text,
      _pickedImage,
      _pickedLocation,
    );
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('add new place'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: <Widget>[
                    TextField(
                      decoration: InputDecoration(labelText: 'title'),
                      controller: _titleController,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ImageInput(_selectImage),
                    SizedBox(
                      height: 10,
                    ),
                    LocationInput(_selectPlace),
                  ],
                ),
              ),
            ),
          ),
          RaisedButton.icon(
            icon: Icon(
              Icons.add,
              color: Colors.white,
            ),
            label: Text(
              'add place',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            onPressed: () {
              _savePlace();
            },
            elevation: 0,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            color: Theme.of(context).primaryColor,
          ),
        ],
      ),
    );
  }
}
