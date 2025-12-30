import 'package:ordermanagement/data/models/productModel.dart';

import '../models/orderModel.dart';
import '../services/order_service.dart';
import '../services/prodcut_service.dart';

class ProductRepository {
  final ProductService service = ProductService();

  Future<ProductModel?> addProduct(ProductModel model)async{
    return service.addProduct(model);
  }

  Future<List<ProductModel>> loadAllProduct()async{
    return service.loadAllProducts();
  }

  Future<ProductModel?>getProductById(String id)async{
    return service.getProductById(id);
  }

}
