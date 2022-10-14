//Plant Item class variable
class PlantItem {
  final int id;
  final String name;
  final String description;
  final String category;
  final String picture;
  final int price;

  PlantItem(this.id, this.name, this.description, this.category, this.picture,
      this.price); //constructor

  String toString() {
    return 'id:${this.id}, name:${this.name}, description:${this.description} ,category:${this.category}, picture:${this.picture}, price:${this.price}';
  }
}
