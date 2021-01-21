import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import '../models/place.dart';
import 'dart:io';

class GreatePlaces with ChangeNotifier {
  List<Place> _items = [];
  List<Place> get items {
    return [..._items];
  }

  void addPlace(
    String title,
    File pickedImage,
  ) {
    final newPlace = Place(
      id: DateTime.now().toString(),
      image: pickedImage,
      title: title,
      location: null,
    );
    _items.add(newPlace);
    notifyListeners();
  }
}