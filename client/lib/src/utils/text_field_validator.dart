class TextFieldValidator {
  static String? validateEmailField(String? textFieldValue) {
    final String textFieldText = textFieldValue!.trim();
    final emailRegex = RegExp("^\\S+@\\S+\\.\\S+\$");
    if (textFieldText.isEmpty) {
      return 'Email can\'t be empty!';
    } else if (!emailRegex.hasMatch(textFieldText)) {
      return 'Kindly input a valid email. e.g. hello@user.com';
    }
    return null;
  }

  static String? validatePasswordField(String? textFieldValue) {
    final String textFieldText = textFieldValue!.trim();
    if (textFieldText.isEmpty) {
      return 'Password can\'t be empty!';
    } else if (textFieldText.length < 5) {
      return 'Password can\'t be less than 5 characters!';
    }
    return null;
  }

  static String? validatePhoneField(String? textFieldValue) {
    final String textFieldText = textFieldValue!.trim();
    final invalidPriceInputRegex = RegExp(r"[a-z A-Z,.\';/-]+$");
    final phoneRegex = RegExp(r'\d');
    if (textFieldText.isEmpty) {
      return 'Phone can\'t be empty!';
    } else if (textFieldText.length < 7 ||
        !phoneRegex.hasMatch(textFieldText) ||
        textFieldText.contains(invalidPriceInputRegex)) {
      return 'Invalid phone number! Kindly input a valid phone number.';
    }
    return null;
  }

  static String? validatePriceField(String? textFieldValue) {
    final String textFieldText = textFieldValue!.trim();
    final invalidPriceInputRegex = RegExp(r"[a-z A-Z,.\';/-]+$");
    final phoneRegex = RegExp(r'\d');
    if (textFieldText.isEmpty) {
      return 'Price can\'t be empty!';
    } else if (textFieldText.startsWith('0') ||
        !phoneRegex.hasMatch(textFieldText) ||
        textFieldText.contains(invalidPriceInputRegex)) {
      return 'Invalid price! Kindly input a valid price.';
    } else if (textFieldText.length > 8) {
      return "Max price exceeded!";
    }

    return null;
  }

  static String? validateWeightField(String? textFieldValue) {
    final String textFieldText = textFieldValue!.trim();
    final invalidPriceInputRegex = RegExp(r"[a-z A-Z,.\';/-]+$");
    final phoneRegex = RegExp(r'\d');
    if (textFieldText.isEmpty) {
      return 'product weight can\'t be empty!';
    } else if (textFieldText.startsWith('0') ||
        !phoneRegex.hasMatch(textFieldText) ||
        textFieldText.contains(invalidPriceInputRegex)) {
      return 'Kindly input a valid weight.';
    } else if (textFieldText.length > 4) {
      return "Max weight exceeded!";
    }

    return null;
  }

  static String? validateCountryField(String? textFieldValue) {
    final String textFieldText = textFieldValue!.trim();
    final fullNameRegex = RegExp(r'^[a-z A-Z,.\-]+$');
    if (textFieldText.isEmpty) {
      return 'Country can\'t be empty!';
    } else if (textFieldText.length < 3 ||
        !fullNameRegex.hasMatch(textFieldText)) {
      return 'Kindly input a valid country. e.g. Singapore';
    }
    return null;
  }

  static String? validateAddressField(String? textFieldValue) {
    final String textFieldText = textFieldValue!.trim();
    if (textFieldText.isEmpty) {
      return 'We need your address for shipping!';
    } else if (textFieldText.length < 3) {
      return 'Kindly input a valid address.';
    }
    return null;
  }

  static String? validateZipCodeField(String? textFieldValue) {
    final String textFieldText = textFieldValue!.trim();
    if (textFieldText.isEmpty) {
      return 'We need your Zip code for shipping!';
    } else if (textFieldText.length < 3) {
      return 'Kindly input a valid zip code.';
    }
    return null;
  }

  static String? validateCityField(String? textFieldValue) {
    final String textFieldText = textFieldValue!.trim();
    final fullNameRegex = RegExp(r'^[a-z A-Z,.\-]+$');
    if (textFieldText.isEmpty) {
      return 'City can\'t be empty!';
    } else if (textFieldText.length < 3 ||
        !fullNameRegex.hasMatch(textFieldText)) {
      return 'Kindly input a valid city.';
    }
    return null;
  }

  static String? validateFullnameField(String? textFieldValue) {
    final String textFieldText = textFieldValue!.trim();
    final fullNameRegex = RegExp(r'^[a-z A-Z,.\-]+$');
    if (textFieldText.isEmpty) {
      return 'Full name can\'t be empty!';
    } else if (textFieldText.length < 3 ||
        !fullNameRegex.hasMatch(textFieldText)) {
      return 'Kindly input a valid full name. e.g. Akoi Grace';
    }
    return null;
  }

  static String? validatePickUpLocationField(String? textFieldValue) {
    final String textFieldText = textFieldValue!.trim();
    if (textFieldText.isEmpty) {
      return "Oops! 'pick up location' can't be empty";
    } else if (textFieldText.length < 3) {
      return 'Kindly input a valid location.';
    }
    return null;
  }
}
