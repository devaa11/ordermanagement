import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/models/orderModel.dart';
import '../controllers/order_controller.dart';
import '../widgets/order_status_dropdown.dart';

class OrderDetailsScreen extends StatelessWidget {
  OrderDetailsScreen({super.key});

  final OrdersController orderCtrl = Get.find<OrdersController>();

  final customerNameController = TextEditingController();
  final amountController = TextEditingController();
  final itemsController = TextEditingController();

  late final OrderModel order;

  @override
  Widget build(BuildContext context) {
    order = Get.arguments as OrderModel;

    customerNameController.text = order.customerName;
    amountController.text = order.amount.toString();
    itemsController.text = order.items.toString();

    orderCtrl.selectedStatus.value = order.status;
    orderCtrl.selectedDate.value = order.date;
    orderCtrl.isEditing.value = false;

    return Scaffold(
      appBar: AppBar(
        title: Obx(() => Text(
          orderCtrl.isEditing.value ? "Edit Order" : "Order Details",
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        )),
        centerTitle: true,
      ),

      body: Obx(
            () => SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _sectionTitle("Order Information"),

                const SizedBox(height: 16),

                _displayField(
                    icon: Icons.tag,
                    label: "Order ID",
                    value: order.orderId),

                const SizedBox(height: 16),

                _inputField(
                    label: "Customer Name",
                    icon: Icons.person_outline,
                    controller: customerNameController,
                    enabled: orderCtrl.isEditing.value),

                const SizedBox(height: 28),
                _sectionTitle("Order Details"),
                const SizedBox(height: 16),

                _statusField(),
                const SizedBox(height: 16),

                _dateField(context),
                const SizedBox(height: 16),

                _inputField(
                  label: "Number of Items",
                  icon: Icons.shopping_bag_outlined,
                  controller: itemsController,
                  enabled: orderCtrl.isEditing.value,
                  keyboardType: TextInputType.number,
                ),

                const SizedBox(height: 16),

                _inputField(
                  label: "Total Amount",
                  icon: Icons.currency_rupee,
                  controller: amountController,
                  enabled: orderCtrl.isEditing.value,
                  keyboardType: TextInputType.number,
                ),

                const SizedBox(height: 120),
              ]),
        ),
      ),

      bottomNavigationBar: Obx(() {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: _buildBottomButtons(order.id),
        );
      }),
    );
  }



  Widget _buildBottomButtons(String id) {
    if (!orderCtrl.isEditing.value) {
      return Row(
        children: [
          Expanded(
            child: ElevatedButton(
              onPressed: () => orderCtrl.isEditing.value = true,
              style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: Colors.blue),
              child: const Text("Edit Order",
                  style: TextStyle(fontSize: 16, color: Colors.white)),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: ElevatedButton(
              onPressed: () => _confirmDelete(id),
              style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: Colors.red),
              child: const Text("Delete",
                  style: TextStyle(fontSize: 16, color: Colors.white)),
            ),
          ),
        ],
      );
    }

    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: () => _updateOrder(id),
            style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                backgroundColor: Colors.green),
            child: const Text("Save",
                style: TextStyle(fontSize: 16, color: Colors.white)),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: OutlinedButton(
            onPressed: () => _cancelEdit(),
            style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16)),
            child:
            const Text("Cancel", style: TextStyle(fontSize: 16)),
          ),
        ),
      ],
    );
  }


  void _confirmDelete(String id) {
    Get.dialog(
      AlertDialog(
        title: const Text("Delete Order"),
        content: const Text("Are you sure you want to delete this order?"),
        actions: [
          TextButton(
              onPressed: () => Get.back(),
              child: const Text("Cancel")),
          TextButton(
            onPressed: () async {
              final success = await orderCtrl.deleteOrder(id);
              if (success) {
                Get.back();
                Get.back();
                Get.snackbar("Deleted", "Order deleted successfully",
                    backgroundColor: Colors.red, colorText: Colors.white);
              }
            },
            child:
            const Text("Delete", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }


  Future<void> _updateOrder(String id) async {
    final success = await orderCtrl.updateOrder(id, {
      "customerName": customerNameController.text,
      "amount": double.parse(amountController.text),
      "items": int.parse(itemsController.text),
      "status": orderCtrl.selectedStatus.value,
      "date": orderCtrl.selectedDate.value.toIso8601String(),
    });

    if (success) {
      orderCtrl.isEditing.value = false;
      Get.snackbar("Updated", "Order updated successfully",
          backgroundColor: Colors.green, colorText: Colors.white);
    }
  }

  void _cancelEdit() {
    orderCtrl.isEditing.value = false;
  }



  Widget _sectionTitle(String text) => Text(text,
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold));

  Widget _displayField(
      {required IconData icon,
        required String label,
        required String value}) {
    return _box(
      child: Row(
        children: [
          Icon(icon, color: Colors.blue),
          const SizedBox(width: 16),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(label, style: const TextStyle(fontSize: 12)),
            const SizedBox(height: 4),
            Text(value,
                style:
                const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
          ])
        ],
      ),
    );
  }

  Widget _inputField({
    required String label,
    required IconData icon,
    required TextEditingController controller,
    required bool enabled,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return _box(
      child: TextField(
        controller: controller,
        enabled: enabled,
        keyboardType: keyboardType,
        decoration: InputDecoration(
            labelText: label,
            prefixIcon: Icon(icon, color: Colors.blue),
            border: InputBorder.none),
      ),
    );
  }

  Widget _statusField() {
    return Obx(() {
      if (!orderCtrl.isEditing.value) {
        return _displayField(
            icon: Icons.info_outline,
            label: "Order Status",
            value: orderCtrl.selectedStatus.value);
      }

      return OrderStatusDropdown(
        value: orderCtrl.selectedStatus.value,
        onChanged: (val) {
          orderCtrl.selectedStatus.value = val;
        });

    });
  }

  Widget _dateField(BuildContext context) {
    return Obx(() {
      return _box(
        child: InkWell(
          onTap: orderCtrl.isEditing.value
              ? () async {
            final picked = await showDatePicker(
              context: context,
              initialDate: orderCtrl.selectedDate.value,
              firstDate: DateTime(2020),
              lastDate: DateTime(2030),
            );
            if (picked != null) {
              orderCtrl.selectedDate.value = picked;
            }
          }
              : null,
          child: Row(
            children: [
              const Icon(Icons.calendar_today, color: Colors.blue),
              const SizedBox(width: 16),
              Text(
                  "${orderCtrl.selectedDate.value.day}/${orderCtrl.selectedDate.value.month}/${orderCtrl.selectedDate.value.year}"),
            ],
          ),
        ),
      );
    });
  }

  Widget _box({required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Get.theme.cardColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 2)),
        ],
      ),
      child: child,
    );
  }
}
