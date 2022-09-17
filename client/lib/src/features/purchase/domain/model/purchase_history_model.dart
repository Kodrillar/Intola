class PurchaseHistoryModel {
  PurchaseHistoryModel({
    this.id,
    required this.email,
    required this.image,
    required this.name,
    this.status,
    this.date,
  });

  final String? id;
  final String email;
  final String image;
  final String name;
  final String? date;
  final String? status;

  PurchaseHistoryModel.fromJson(json)
      : id = json["id"],
        email = json["email"],
        image = json["image"],
        name = json["name"],
        date = json["created_at"],
        status = json["status"];

  Map<String, dynamic> toJson() {
    //"date(created_at)", "status" and "id" is set by server
    return {
      "email": email,
      "image": image,
      "name": name,
    };
  }
}
