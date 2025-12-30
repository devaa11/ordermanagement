import 'package:get/get.dart';
import 'package:ordermanagement/data/models/productModel.dart';
import 'package:ordermanagement/data/repositories/product_repository.dart';
import 'package:ordermanagement/utils/helpers/loaders.dart';
import '../../../data/models/orderModel.dart';
import '../../../data/repositories/order_repository.dart';

class OrdersController extends GetxController {
  final repo = OrderRepository();
  final productrepo=ProductRepository();

  var orders = <OrderModel>[].obs;
  var isLoading = false.obs;
  var nextOrderId = "".obs;
  var isSaving = false.obs;
  var selectedStatus = "".obs;
  var selectedDate = DateTime.now().obs;
  var isEditing = false.obs;
  var searchQuery = "".obs;
  var selectedStatuses = <String>[].obs;
  var minAmount = 0.0.obs;
  var maxAmount = 999999.0.obs;
  var startDate = Rxn<DateTime>();
  var endDate = Rxn<DateTime>();
  var selectedProduct = Rxn<Productmodel>();
  var quantity = 1.obs;
  var calculatedTotal = 0.0.obs;
  var isProductLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadOrders();
    generateOrderId();
  }

  Future<void> loadOrders() async {
    isLoading.value = true;
    resetFilters();
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

  List<OrderModel> get filteredOrders {
    List<OrderModel> temp = orders;

    if (searchQuery.value.isNotEmpty) {
      final q = searchQuery.value.toLowerCase();
      temp = temp.where((o) =>
      o.customerName.toLowerCase().contains(q) ||
          o.orderId.toLowerCase().contains(q) ||
          o.status.toLowerCase().contains(q)
      ).toList();
    }

    if (selectedStatuses.isNotEmpty) {
      temp = temp.where((o) => selectedStatuses.contains(o.status)).toList();
    }

    temp = temp.where((o) =>
    o.amount >= minAmount.value &&
        o.amount <= maxAmount.value).toList();

    if (startDate.value != null && endDate.value != null) {
      temp = temp.where((o) =>
      o.date.isAfter(startDate.value!) &&
          o.date.isBefore(endDate.value!)).toList();
    }

    return temp;
  }

  void resetFilters() {
    searchQuery.value = "";
    selectedStatuses.clear();
    minAmount.value = 0.0;
    maxAmount.value = 999999.0;
    startDate.value = null;
    endDate.value = null;
  }

  Future<void> getProductId(String id) async {
    try {
      isProductLoading.value = true;

      final product = await productrepo.fetchById(id);

      if (product != null) {
        selectedProduct.value = product;
        calculateTotal();
      } else {
        selectedProduct.value = null;
        calculatedTotal.value = 0;
      }
    } catch (e) {
      print(e);
    } finally {
      isProductLoading.value = false;
    }
  }

  void calculateTotal() {
    if (selectedProduct.value != null) {
      calculatedTotal.value =
          selectedProduct.value!.amount * quantity.value;
    }
  }
  void updateQuantity(int value) {
    quantity.value = value;
    calculateTotal();
  }


}
