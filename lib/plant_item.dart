//Plant Item class variable
// ignore_for_file: unnecessary_this

import 'package:automated_ios/plant_image.dart';

class PlantItem {
  final String plant_id;
  final String name;
  final String description;
  final String category;
  final PlantImage plant_image;
  final double price;

  PlantItem(this.plant_id, this.name, this.description, this.category,
      this.plant_image, this.price); //constructor

  @override
  String toString() {
    return 'id:${this.plant_id}, name:${this.name}, description:${this.description} ,category:${this.category}, picture:${this.plant_image}, price:${this.price}';
  }
}
