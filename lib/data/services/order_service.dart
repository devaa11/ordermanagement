import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/orderModel.dart';

class OrderService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  CollectionReference<Map<String, dynamic>> get _ordersRef {
    final uid = _auth.currentUser!.uid;
    return _db
        .collection('users')
        .doc(uid)
        .collection('orders');
  }

  Future<List<OrderModel>> fetchOrders() async {
    final snap = await _ordersRef.orderBy("orderId").get();
    return snap.docs
        .map((doc) => OrderModel.fromMap(doc.data(), doc.id))
        .toList();
  }

  Future<OrderModel> createOrder(OrderModel order) async {
    final ref = await _ordersRef.add(order.toMap());
    final data = await ref.get();
    return OrderModel.fromMap(data.data()!, ref.id);
  }

  Future<void> updateOrder(String id, Map<String, dynamic> data) async {
    await _ordersRef.doc(id).update(data);
  }

  Future<void> deleteOrder(String id) async {
    await _ordersRef.doc(id).delete();
  }

  Future<String> getLastOrderId() async {
    final snap = await _ordersRef
        .orderBy("orderId", descending: true)
        .limit(1)
        .get();

    if (snap.docs.isEmpty) return "ORD000";

    return snap.docs.first.data()["orderId"];
  }
}
