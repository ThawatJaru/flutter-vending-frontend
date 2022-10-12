//Plant Item class variable
class PlantItem {
  final int id;
  final String name;
  final String category;
  final String picture;
  final int price;

  PlantItem(this.id, this.name, this.category, this.picture,
      this.price); //constructor

  String toString() {
    return 'id:${this.id}, name:${this.name}, category:${this.category}, picture:${this.picture}, price:${this.price}';
  }
}
