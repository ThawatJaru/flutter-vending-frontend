//Plant Item class variable
// ignore_for_file: unnecessary_this

class PlantItem {
  final String id;
  final String name;
  final String description;
  final String category;
  final String picture;
  final double price;

  PlantItem(this.id, this.name, this.description, this.category, this.picture,
      this.price); //constructor

  @override
  String toString() {
    return 'id:${this.id}, name:${this.name}, description:${this.description} ,category:${this.category}, picture:${this.picture}, price:${this.price}';
  }
}
