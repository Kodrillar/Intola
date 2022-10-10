Map<String, String> endpoints = {
  "registerUser": "/user/register",
  "loginUser": "/user/auth",
  "getUser": "/user/auth",
  "getProducts": "/products",
  "getDonations": "/donations",
  "updateDonation": "/donations",
  "donate": "/donations/donate",
  "shipping": "/shipping",
  "addDelivery": "/delivery",
  "updateDeliveryImage": "/delivery",
  "getDelivery": "/delivery",
  "addPurchase": "/purchase",
  "getPurchase": "/purchase"
};

class Endpoints {
  static String get registerUser => "/user/register";
  static String get loginUser => "/user/auth";
  static String get fetchUserDetails => "/user/auth";
  static String get fetchProducts => "/products";
  static String get fetchDonations => "/donations";
  static String get updateDonation => "/donations";
  static String get addDonation => "/donations/donate";
  static String get addShippingInfo => "/shipping";
  static String get addDelivery => "/delivery";
  static String get updateDeliveryImage => "/delivery";
  static String get fetchDelivery => "/delivery";
  static String get addPurchase => "/purchase";
  static String get fetchPurchase => '/purchase';
}

class API {
  static String get baseUrl => "https://intola.herokuapp.com/api";

  //'https://intola-app.cyclic.app/api';

  //"https://cute-plum-cape-buffalo-fez.cyclic.app";



  static Uri getRequestUrl({required String path}) => Uri(
        scheme: "http",
        host: "localhost:3000/api",
        path: endpoints[path],
      );
}
