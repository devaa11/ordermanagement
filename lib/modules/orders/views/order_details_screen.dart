import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
        centerTitle: true,
        title: Obx(
              () => Text(
            orderCtrl.isEditing.value ? "Edit Order" : "Order Details",
            style: TextStyle(
              fontSize: 22.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),

      body: Obx(
            () => SingleChildScrollView(
          padding: EdgeInsets.all(20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _sectionTitle("Order Information"),
              SizedBox(height: 16.h),

              _displayField(
                icon: Icons.tag,
                label: "Order ID",
                value: order.orderId,
              ),

              SizedBox(height: 28.h),
              _sectionTitle("Order Details"),
              SizedBox(height: 16.h),

              _statusField(),
              SizedBox(height: 16.h),

              _dateField(context),
              SizedBox(height: 16.h),

              _inputField(
                label: "Customer Name",
                icon: Icons.person_outline,
                controller: customerNameController,
                enabled: orderCtrl.isEditing.value,
              ),

              SizedBox(height: 16.h),

              _inputField(
                label: "Number of Items",
                icon: Icons.shopping_bag_outlined,
                controller: itemsController,
                enabled: orderCtrl.isEditing.value,
                keyboardType: TextInputType.number,
              ),

              SizedBox(height: 16.h),

              _inputField(
                label: "Total Amount",
                icon: Icons.currency_rupee,
                controller: amountController,
                enabled: orderCtrl.isEditing.value,
                keyboardType: TextInputType.number,
              ),

              SizedBox(height: 120.h),
            ],
          ),
        ),
      ),

      bottomNavigationBar: Obx(
            () => Padding(
          padding: EdgeInsets.all(20.w),
          child: _buildBottomButtons(order.id),
        ),
      ),
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
                backgroundColor: Colors.blue,
                padding: EdgeInsets.symmetric(vertical: 16.h),
              ),
              child: Text(
                "Edit Order",
                style: TextStyle(fontSize: 16.sp, color: Colors.white),
              ),
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: ElevatedButton(
              onPressed: () => _confirmDelete(id),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                padding: EdgeInsets.symmetric(vertical: 16.h),
              ),
              child: Text(
                "Delete",
                style: TextStyle(fontSize: 16.sp, color: Colors.white),
              ),
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
              backgroundColor: Colors.green,
              padding: EdgeInsets.symmetric(vertical: 16.h),
            ),
            child: Text(
              "Save",
              style: TextStyle(fontSize: 16.sp, color: Colors.white),
            ),
          ),
        ),
        SizedBox(width: 16.w),
        Expanded(
          child: OutlinedButton(
            onPressed: _cancelEdit,
            style: OutlinedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 16.h),
            ),
            child: Text(
              "Cancel",
              style: TextStyle(fontSize: 16.sp),
            ),
          ),
        ),
      ],
    );
  }


  void _confirmDelete(String id) {
    Get.dialog(
      AlertDialog(
        title: Text("Delete Order", style: TextStyle(fontSize: 18.sp)),
        content: Text(
          "Are you sure you want to delete this order?",
          style: TextStyle(fontSize: 14.sp),
        ),
        actions: [
          TextButton(
            onPressed: Get.back,
            child: Text("Cancel", style: TextStyle(fontSize: 14.sp)),
          ),
          TextButton(
            onPressed: () async {
              final success = await orderCtrl.deleteOrder(id);
              if (success) {
                Get.back();
                Get.back();
                Get.snackbar(
                  "Deleted",
                  "Order deleted successfully",
                  backgroundColor: Colors.red,
                  colorText: Colors.white,
                );
              }
            },
            child: Text(
              "Delete",
              style: TextStyle(fontSize: 14.sp, color: Colors.red),
            ),
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
      Get.snackbar(
        "Updated",
        "Order updated successfully",
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    }
  }

  void _cancelEdit() {
    orderCtrl.isEditing.value = false;
  }


  Widget _sectionTitle(String text) => Text(
    text,
    style: TextStyle(
      fontSize: 18.sp,
      fontWeight: FontWeight.bold,
    ),
  );

  Widget _displayField({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return _box(
      child: Row(
        children: [
          Icon(icon, color: Colors.blue, size: 20.sp),
          SizedBox(width: 16.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: TextStyle(fontSize: 12.sp)),
              SizedBox(height: 4.h),
              Text(
                value,
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
              ),
            ],
          ),
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
        style: TextStyle(fontSize: 14.sp),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(fontSize: 14.sp),
          prefixIcon: Icon(icon, color: Colors.blue, size: 20.sp),
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget _statusField() {
    return Obx(() {
      if (!orderCtrl.isEditing.value) {
        return _displayField(
          icon: Icons.info_outline,
          label: "Order Status",
          value: orderCtrl.selectedStatus.value,
        );
      }
      return OrderStatusDropdown(
        value: orderCtrl.selectedStatus.value,
        onChanged: (val) => orderCtrl.selectedStatus.value = val,
      );
    });
  }

  Widget _dateField(BuildContext context) {
    return Obx(
          () => _box(
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
              Icon(Icons.calendar_today, color: Colors.blue, size: 20.sp),
              SizedBox(width: 16.w),
              Text(
                "${orderCtrl.selectedDate.value.day}/${orderCtrl.selectedDate.value.month}/${orderCtrl.selectedDate.value.year}",
                style: TextStyle(fontSize: 14.sp),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _box({required Widget child}) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Get.theme.cardColor,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10.r,
            offset: Offset(0, 2.h),
          ),
        ],
      ),
      child: child,
    );
  }
}
