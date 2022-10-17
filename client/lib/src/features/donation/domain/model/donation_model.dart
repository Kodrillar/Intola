class DonationModel {
  DonationModel({
    this.id,
    this.email,
    required this.image,
    required this.price,
    required this.description,
    required this.name,
    required this.quantity,
    required this.spotsleft,
  });

  final String? id;
  final String? email;
  final String image;
  final String price;
  final String description;
  final String name;
  final String quantity;
  final String spotsleft;

  DonationModel.fromJson(json)
      : id = json["id"],
        email = json["email"],
        image = json["image"],
        price = json["price"],
        description = json["description"],
        name = json["name"],
        quantity = json["quantity"],
        spotsleft = json["spotsleft"];

  Map<String, dynamic> toJson() {
    //"id" would be set by default in server
    return {
      "email": email,
      "image": image,
      "price": price,
      "description": description,
      "name": name,
      "quantity": quantity,
      "spotsleft": spotsleft
    };
  }
}
