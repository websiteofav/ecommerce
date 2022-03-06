class API {
  static const baseUrl = 'http://10.0.2.2:5000/api';

  // Auth
  static const users = '/users';

  static const auth = baseUrl + users;

  static const login = auth + '/login';

  static const register = auth + '/register';

  // Mobile
  static const products = '/products';

  static const getAllMobiles = baseUrl + products + '/mobiles';

  static const searchMobiles = baseUrl + products + '/mobiles/search/all';

  //Cart
  static const carts = '/cart';

  static const getCart = baseUrl + carts;
}
