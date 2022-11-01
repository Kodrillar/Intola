class DeliveryModel {
  DeliveryModel({
    this.id,
    this.email,
    this.image,
    required this.weight,
    required this.price,
    required this.description,
    required this.location,
    required this.contact,
  });
  final String? id;
  final String? email;
  final String? image;
  final String weight;
  final String price;
  final String description;
  final String location;
  final String contact;

  DeliveryModel.fromJson(json)
      : id = json["id"],
        email = json["email"],
        image = json["image"],
        weight = json["weight"],
        price = json["price"],
        description = json["description"],
        location = json["location"],
        contact = json["contact"];

  Map<String, dynamic> toJson() {
    //id ,image and email is set in server
    return {
      "weight": weight,
      "price": price,
      "description": description,
      "location": location,
      "contact": contact
    };
  }
}
