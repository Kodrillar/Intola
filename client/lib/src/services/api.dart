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

class API {
  // String baseUrl = "";
  static const baseUrl = "https://intola.herokuapp.com/api";

  static Uri getRequestUrl({required String path}) => Uri(
        scheme: "http",
        host: "localhost:3000/api",
        path: endpoints[path],
      );
}
