import 'package:get/get.dart';
import 'package:ordermanagement/data/models/productModel.dart';
import 'package:ordermanagement/data/repositories/product_repository.dart';
import 'package:ordermanagement/utils/helpers/loaders.dart';

class ProductController extends GetxController{
   var isLoading = false.obs;
   var isProductAdded=false.obs;
   var product=<ProductModel>[].obs;
   final repo= ProductRepository();

   @override
  void onInit() {

    loadAllProduct();
    super.onInit();
  }

   Future<void> createProdcut(String pName,String pDesc,String amount,String type)async{
     try{
       isProductAdded.value=true;
       final ProductModel model=ProductModel(
         pName: pName,
         pAmount: double.tryParse(amount),
         pDesc: pDesc,
         pType: type,
         createdAt: DateTime.now()
       );
       final response =await repo.addProduct(model);
       if(response !=null){
         Loaders.successSnackBar(title: "Sucess",message: 'Product added');
       }else{

       }
     }catch(e){

     }finally{
       isProductAdded.value=false;
     }
   }
   
   
   Future<void>loadAllProduct()async{
     try{
       final response= await repo.loadAllProduct();
         product.value=response;
         print("Controller product count ${response.length}");

     }catch(e){
       print(e);
     }
   }


}