import '../models/orderModel.dart';
import '../services/order_service.dart';

class OrderRepository {
  final OrderService service = OrderService();

  Future<List<OrderModel>> getOrders() => service.fetchOrders();

  Future<OrderModel> createOrder(OrderModel order) =>
      service.createOrder(order);

  Future<void> updateOrder(String id, Map<String, dynamic> data) =>
      service.updateOrder(id, data);

  Future<void> deleteOrder(String id) => service.deleteOrder(id);

  Future<String> generateOrderId() async {
    final lastId = await service.getLastOrderId();
    final number = int.parse(lastId.substring(3));
    final next = number + 1;

    return "ORD${next.toString().padLeft(3, '0')}"; 
  }
}
