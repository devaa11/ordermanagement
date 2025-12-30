import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ordermanagement/data/models/productModel.dart';
import 'package:ordermanagement/utils/Network/dio_client.dart';
import 'package:ordermanagement/utils/helpers/loaders.dart';

class ProductService{
  // final _db=FirebaseFirestore.instance;
  // final FirebaseAuth _auth = FirebaseAuth.instance;
  //
  // CollectionReference<Map<String, dynamic>> get _productRef {
  //   final uid = _auth.currentUser!.uid;
  //   return _db
  //       .collection('users')
  //       .doc(uid)
  //       .collection('products');
  // }
  //
  //
  // Future<Productmodel?> createProduct(Productmodel model) async{
  //
  //   final ref = await _productRef.add(model.toMap());
  //   final data = await ref.get();
  //   return Productmodel.fromMap(data.data()!, ref.id);
  //
  // }
  //
  // Future<Productmodel?> fetchOrderById(String id)async{
  //   final doc= await _productRef.doc(id).get();
  //   if(!doc.exists)return null;
  //
  //   return Productmodel.fromMap(doc.data()!,id );
  // }
  //

  final Dio _dio= ApiClient.dio;

  Future<ProductModel?> getProductById(String id)async{
    try{
      final response= await _dio.get('product/${id}',);
      if(response.statusCode ==200){
        return ProductModel.fromJson(response.data);
      }else{
        Loaders.errorSnackBar(title: "Error",message: "Not Found");
      }
      return null;
    }catch(e){
      rethrow;
    }
  }
  
  
  Future<List<ProductModel>> loadAllProducts()async{
    try{
      final response=await _dio.get('product');
      if(response.statusCode==200){
        return (response.data as List).map((e)=>
        ProductModel.fromJson(e)
        ).toList();
      }
      return [];
    }catch(e){
      rethrow;
    }
  }

  Future<ProductModel?> addProduct(ProductModel model)async{
    try{
      final response= await _dio.post('product', data: model.toJson());
      if(response.statusCode==200){
        return ProductModel.fromJson(response.data);
      }

    }catch(e){
      rethrow;
    }
  }

}