import '../../../product/domain/model/product_model.dart';

class PurchaseHistoryModel {
  PurchaseHistoryModel({
    this.id,
    required this.image,
    required this.name,
    this.status,
    this.date,
  });

  final String? id;
  final String image;
  final String name;
  final String? date;
  final String? status;

  PurchaseHistoryModel.fromJson(json)
      : id = json['id'],
        date = json["date"],
        image = json['image'],
        name = json['name'],
        status = json['status'];

  static Map<String, dynamic> generateJsonPurchaseList(
      List<ProductModel> products) {
    // "date(created_at)", and "id" is set by server

    // initial status of  purchase delivery is set to 'pending '
    // and updated in server on delivery

    final List<Map> productPurchases = [];

    for (var product in products) {
      productPurchases.add(
        {
          'name': product.name,
          'image': product.image,
          'status': 'pending',
        },
      );
    }

    return {
      "products": productPurchases,
    };
  }
}
