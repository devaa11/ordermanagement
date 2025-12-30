import 'package:ordermanagement/data/models/productModel.dart';

import '../models/orderModel.dart';
import '../services/order_service.dart';
import '../services/prodcut_service.dart';

class ProductRepository {
  final ProductService service = ProductService();


  Future<Productmodel?> createProduct(Productmodel model) =>
      service.createProduct(model);
  Future<Productmodel?> fetchById(String Id) =>
      service.fetchOrderById(Id);



}
