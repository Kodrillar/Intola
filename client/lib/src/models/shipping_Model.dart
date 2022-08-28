class ShippingModel {
  ShippingModel({
    this.id,
    required this.email,
    required this.address,
    this.apartment_suite,
    required this.city,
    required this.country,
    required this.phone,
    required this.zipcode,
  });
  final id;
  final String email;
  final String address;
  final String? apartment_suite;
  final String city;
  final String country;
  final String phone;
  final String zipcode;

  Map<String, dynamic> toJson() {
    //"id" would be set by default in server
    return {
      "email": email,
      "address": address,
      "apartment_suite": apartment_suite,
      "city": city,
      "country": country,
      "phone": phone,
      "zipcode": zipcode
    };
  }
}
