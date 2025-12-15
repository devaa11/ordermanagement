import 'package:get/get.dart';
import 'package:ordermanagement/utils/helpers/loaders.dart';
import '../../../data/models/orderModel.dart';
import '../../../data/repositories/order_repository.dart';

class OrdersController extends GetxController {
  final repo = OrderRepository();

  var orders = <OrderModel>[].obs;
  var isLoading = false.obs;
  var nextOrderId = "".obs;
  var isSaving = false.obs;
  var selectedStatus = "".obs;
  var selectedDate = DateTime.now().obs;
  var isEditing = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadOrders();
    generateOrderId();
  }

  Future<void> loadOrders() async {
    isLoading.value = true;
    orders.value = await repo.getOrders();
    isLoading.value = false;
  }

  Future<void> generateOrderId() async {
    nextOrderId.value = await repo.generateOrderId();
  }

  Future<bool> addOrder({
    required String customerName,
    required int items,
    required double amount,
    required String status,
    required DateTime date,
  }) async {
    try {
      isSaving.value = true;

      final order = OrderModel(
        id: "",
        orderId: nextOrderId.value,
        customerName: customerName,
        items: items,
        amount: amount,
        status: status,
        date: date,
      );

      final newOrder = await repo.createOrder(order);
      orders.add(newOrder);

      await generateOrderId();

      Loaders.successSnackBar(title: "Success", message: "Order created");
      return true;
    } catch (e) {
      Loaders.errorSnackBar(title: "Error", message: e.toString());
      return false;
    } finally {
      isSaving.value = false;
    }
  }

  Future<bool> deleteOrder(String id) async {
    try {
      await repo.deleteOrder(id);
      orders.removeWhere((o) => o.id == id);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> updateOrder(String id, Map<String, dynamic> data) async {
    try {
      await repo.updateOrder(id, data);

      int index = orders.indexWhere((o) => o.id == id);
      if (index != -1) {
        final old = orders[index];
        orders[index] = OrderModel(
          id: id,
          orderId: old.orderId,
          customerName: data["customerName"] ?? old.customerName,
          items: data["items"] ?? old.items,
          amount: data["amount"] ?? old.amount,
          status: data["status"] ?? old.status,
          date: DateTime.parse(data["date"] ?? old.date.toIso8601String()),
        );
      }
      return true;
    } catch (e) {
      return false;
    }
  }
}
