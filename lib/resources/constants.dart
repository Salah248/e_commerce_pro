class ConstantManager {
  static const String baseUrl = 'https://fakestoreapi.com/';

  static const String loginUrl = '${baseUrl}auth/login';
  static const String registerUrl = '${baseUrl}users'; // POST للتسجيل
  static const String getAllUsersUrl = '${baseUrl}users';
  static const String getProductsUrl = '${baseUrl}products';
  static const String getCategoriesUrl = '${baseUrl}products/categories';
  static const String getCategoryProductsUrl = '${baseUrl}products/category/';
  static const String getCartUrl = '${baseUrl}carts/user/2';
  static const String addOrgetCartUrl = '${baseUrl}carts';
}
// https://fakestoreapi.com/users