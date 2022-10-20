//Plant Item class variable
// ignore_for_file: unnecessary_this

class PlantItem {
  final int id;
  final String name;
  final String description;
  final String category;
  final String image;
  final int price;

  PlantItem(this.id, this.name, this.description, this.category, this.image,
      this.price); //constructor

  @override
  String toString() {
    return 'id:${this.id}, name:${this.name}, description:${this.description} ,category:${this.category}, picture:${this.image}, price:${this.price}';
  }
}
