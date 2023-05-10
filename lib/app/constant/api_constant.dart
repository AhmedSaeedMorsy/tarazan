class ApiConstant {
  static const String baseUrl = "https://tarzan.lineerp.live/";
  static const String registerPath = "api/v1/register";
  static const String loginPath = "api/v1/login";
  static String editProfilePath(String id) => "api/v1/user/$id";
  static String editProfileImagePath(String id) =>
      "api/v1/user_update_image/$id";
  static const String getUser = "api/v1/get_user";
  static const String travellingTicketPath = "api/v1/filtered_travels";
  static const String bookAticketPath = "api/v1/trip";
  static const String shippingTicketPath = "api/v1/filtered_shippings";
  static const String categoriesPath = "api/v1/shipping_category";
  static String quotationPath(int id) =>
      "api/v1/pending_shipping_order/user/$id";
  static String allowQuotationPath(int id) =>
      "api/v1/shipping_order/$id/accept_cost";
  static String denyQuotationPath(int id) =>
      "api/v1/shipping_order/$id/reject_cost";
  static String historyShippingPath(int id) => "api/v1/shipping_order/user/$id";
  static String historyTicketPath(int id) => "api/v1/trip/user/$id";
  static const String bookShippingTicketPath = "api/v1/shipping_order";
  static const String sendDeviceTokenPath = "api/v1/store-token";
}
