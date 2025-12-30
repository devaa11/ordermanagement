import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ordermanagement/data/models/productModel.dart';

class ProductService{
  final _db=FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  CollectionReference<Map<String, dynamic>> get _productRef {
    final uid = _auth.currentUser!.uid;
    return _db
        .collection('users')
        .doc(uid)
        .collection('products');
  }


  Future<Productmodel?> createProduct(Productmodel model) async{

    final ref = await _productRef.add(model.toMap());
    final data = await ref.get();
    return Productmodel.fromMap(data.data()!, ref.id);

  }

  Future<Productmodel?> fetchOrderById(String id)async{
    final doc= await _productRef.doc(id).get();
    if(!doc.exists)return null;

    return Productmodel.fromMap(doc.data()!,id );
  }



}