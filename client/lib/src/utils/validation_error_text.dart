class ValidationErrorModel {
  static const Map<String, String> validationError = {
    "fullnameError": "Oops! fullname can't be empty",
    "emailError": "Oops! 'email' can't be empty",
    "passwordError": "Oops! 'password' can't be empty",
    "addressError": "We need your address for shipping!",
    "cityError": "Oops! 'city' cant be empty!",
    "countryError": "Kindly input country to aid delivery",
    "phoneError": "Oops! We need to be able to contact you",
    "zipcodeError": "Oops!, zip/postal code can't be empty",
    "descriptionError": "Oops! your product must have a description",
    "pickupError": "Oops! 'pick up location' can't be empty",
    "contactError": "Oops! 'contact' can't be empty",
    "weightError": "product weight is required!"
  };
}

enum ValidationErrorMessage {
  fullnameError("Oops! fullname can't be empty"),
  emailError("Oops! 'email' can't be empty"),
  passwordError("Oops! 'password' can't be empty"),
  cityError("Oops! 'city' cant be empty!"),
  countryError("Kindly input country to aid delivery"),
  phoneError("Oops! We need to be able to contact you"),
  zipcodeError("Oops!, zip/postal code can't be empty"),
  descriptionError("Oops! your product must have a description"),
  pickupError("Oops! 'pick up location' can't be empty"),
  contactError("Oops! 'contact' can't be empty"),
  weightError("product weight is required!");

  const ValidationErrorMessage(this.message);
  final String message;
}
