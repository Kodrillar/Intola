class Endpoints {
  static String get registerUser => "/auth/sign-up";
  static String get loginUser => "/auth/sign-in";
  static String get fetchUserDetails => "/users";
  static String get fetchProducts => "/products";
  static String get fetchDonations => "/donations";
  static String get updateDonation => "/donations";
  static String get addDonation => "/donations";
  static String get addShippingInfo => "/shipping";
  static String get addDelivery => "/deliveries";
  static String get updateDeliveryImage => "/deliveries";
  static String get fetchDelivery => "/deliveries";
  static String get addPurchase => "/purchases";
  static String get fetchPurchase => '/purchases';
}

enum EndpointParam {
  products;

  Object get param {
    switch (EndpointParam.products) {
      case EndpointParam.products:
        return ProductEndpointParams();
    }
  }
}

class ProductEndpointParams {
  final String top = '/top';
  final String supermarket = '/supermarket';
}

class API {
  static String get baseUrl => 'https://intola-app.cyclic.app/api/v2';

  //"https://cute-plum-cape-buffalo-fez.cyclic.app";

  static Uri getRequestUrl({required String path}) => Uri(
        scheme: "http",
        host: "localhost:3000/api/v2",
        path: path,
      );
}
