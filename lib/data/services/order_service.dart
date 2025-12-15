import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/orderModel.dart';

class OrderService {
  final _db = FirebaseFirestore.instance;
  final String collection = "orders";

  Future<List<OrderModel>> fetchOrders() async {
    final snap = await _db.collection(collection).orderBy("orderId").get();
    return snap.docs
        .map((doc) => OrderModel.fromMap(doc.data(), doc.id))
        .toList();
  }

  Future<OrderModel> createOrder(OrderModel order) async {
    final ref = await _db.collection(collection).add(order.toMap());
    final data = await ref.get();
    return OrderModel.fromMap(data.data()!, ref.id);
  }

  Future<void> updateOrder(String id, Map<String, dynamic> data) async {
    await _db.collection(collection).doc(id).update(data);
  }

  Future<void> deleteOrder(String id) async {
    await _db.collection(collection).doc(id).delete();
  }

  Future<String> getLastOrderId() async {
    final snap = await _db
        .collection(collection)
        .orderBy("orderId", descending: true)
        .limit(1)
        .get();

    if (snap.docs.isEmpty) return "ORD000";

    return snap.docs.first.data()["orderId"];
  }
}
