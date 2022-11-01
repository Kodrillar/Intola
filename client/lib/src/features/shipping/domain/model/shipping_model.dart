class ShippingModel {
  ShippingModel({
    this.id,
    required this.email,
    required this.address,
    this.apartmentSuite,
    required this.city,
    required this.country,
    required this.phone,
    required this.zipcode,
  });
  final String? id;
  final String email;
  final String address;
  final String? apartmentSuite;
  final String city;
  final String country;
  final String phone;
  final String zipcode;

  Map<String, dynamic> toJson() {
    //"id" would be set by default in server
    return {
      "email": email,
      "address": address,
      "apartment_suite": apartmentSuite,
      "city": city,
      "country": country,
      "phone": phone,
      "zipcode": zipcode
    };
  }
}
