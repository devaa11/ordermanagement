import 'package:get/get.dart';
import 'package:ordermanagement/data/models/productModel.dart';
import 'package:ordermanagement/data/repositories/product_repository.dart';

class ProductController extends GetxController{
   var isLoading = false.obs;

   final repo= ProductRepository();

   Future<void> createProdcut(Productmodel product)async{
     try{
       final prodcut =await repo.createProduct(product);
       if(product !=null){

       }else{

       }
     }catch(e){

     }
   }
}