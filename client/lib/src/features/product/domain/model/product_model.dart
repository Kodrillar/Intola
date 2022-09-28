import 'dart:convert';

class ProductModel {
  const ProductModel({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
    required this.slashprice,
    required this.description,
    required this.quantity,
  });
  final String id;
  final String name;
  final String image;
  final String price;
  final String slashprice;
  final String description;
  //Number of the exact product left
  final String? quantity;

  factory ProductModel.fromJson(json) {
    return ProductModel(
      id: json["id"],
      name: json["name"],
      image: json["image"],
      price: json["price"],
      slashprice: json["slashprice"],
      description: json["description"],
      quantity: json["quantity"],
    );
  }

  @override
  String toString() {
    return 'ProductModel(id: $id, name: $name, image: $image, price: $price, slashprice: $slashprice, description: $description, quantity: $quantity)';
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'name': name});
    result.addAll({'image': image});
    result.addAll({'price': price});
    result.addAll({'slashprice': slashprice});
    result.addAll({'description': description});
    result.addAll({'quantity': quantity});

    return result;
  }

  String toJson() => jsonEncode(toMap());
}
