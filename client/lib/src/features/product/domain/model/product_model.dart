class ProductModel {
  const ProductModel({
    this.id,
    required this.name,
    required this.image,
    required this.price,
    required this.slashprice,
    required this.description,
    required this.quantity,
  });
  final id;
  final String name;
  final String image;
  final String price;
  final String slashprice;
  final String description;
  final String quantity;

  ProductModel.fromJson(json)
      : id = json["id"],
        name = json["name"],
        image = json["image"],
        price = json["price"],
        slashprice = json["slashprice"],
        description = json["description"],
        quantity = json["quantity"];
}
