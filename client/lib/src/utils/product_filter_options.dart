class ProductFilterOptions {
  static const String _phonesAndTablets = "Phones and Tablets";
  static const String _computing = "Computing";
  static const String _gaming = "Gaming";
  // static const String _supermarket = 'Supermarket';

  static String categoryFilter(String filterOption) {
    if (filterOption == _phonesAndTablets) {
      return "/phones_and_tablets";
    } else if (filterOption == _computing) {
      return "/computing";
    } else if (filterOption == _gaming) {
      return "/gaming";
    } else {
      return "/supermarket";
    }
  }
}
