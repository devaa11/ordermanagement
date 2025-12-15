import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../controllers/order_controller.dart';
import '../widgets/order_status_dropdown.dart';

class AddOrderScreen extends StatefulWidget {
  const AddOrderScreen({super.key});

  @override
  State<AddOrderScreen> createState() => _AddOrderPageState();
}

class _AddOrderPageState extends State<AddOrderScreen> {
  final _formKey = GlobalKey<FormState>();
  final _orderIdController = TextEditingController();
  final _customerNameController = TextEditingController();
  final _amountController = TextEditingController();
  final _itemsController = TextEditingController();
  final OrdersController orderCtrl = Get.put(OrdersController());


  String _selectedStatus = 'Pending';
  DateTime _selectedDate = DateTime.now();

  final List<String> _statusOptions = ['Pending', 'Processing', 'Delivered', 'Cancelled'];

  @override
  void dispose() {
    _orderIdController.dispose();
    _customerNameController.dispose();
    _amountController.dispose();
    _itemsController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _saveOrder() async {
    if (_formKey.currentState!.validate()) {
      final ctrl = Get.find<OrdersController>();

      final isSuccess = await ctrl.addOrder(
        customerName: _customerNameController.text,
        items: int.parse(_itemsController.text),
        amount: double.parse(_amountController.text),
        status: _selectedStatus,
        date: _selectedDate,
      );

      if (isSuccess) {
        Navigator.pop(context);
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          "Add New Order",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [


                buildSectionTitle('Order Details'),
                const SizedBox(height: 24),

                Obx(() {
                  return TextFormField(
                    readOnly: true,
                    controller: TextEditingController(
                      text: orderCtrl.nextOrderId.value,
                    ),
                    decoration: InputDecoration(
                      labelText: 'Order ID',
                      prefixIcon: Icon(Icons.tag, color: Colors.blue),
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  );
                }),

                const SizedBox(height: 16),

                buildTextField(
                  controller: _customerNameController,
                  label: 'Customer Name',
                  hint: 'Enter customer name',
                  icon: Icons.person_outline,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter customer name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                OrderStatusDropdown(
                  value: _selectedStatus,
                  onChanged: (val) {
                    setState(() => _selectedStatus = val);
                  },
                ),
                const SizedBox(height: 16),

                buildDatePicker(context),
                const SizedBox(height: 16),

                buildTextField(
                  controller: _itemsController,
                  label: 'Number of Items',
                  hint: 'Enter number of items',
                  icon: Icons.shopping_bag_outlined,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter number of items';
                    }
                    if (int.tryParse(value) == null) {
                      return 'Please enter a valid number';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                buildTextField(
                  controller: _amountController,
                  label: 'Total Amount',
                  hint: 'Enter total amount',
                  icon: Icons.attach_money,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter total amount';
                    }
                    if (double.tryParse(value) == null) {
                      return 'Please enter a valid amount';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 32),

                Obx((){
                  return SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: orderCtrl.isSaving.value ? null : _saveOrder,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child:  orderCtrl.isSaving.value
                          ? const CircularProgressIndicator(color: Colors.white)
                          : Text(
                        'Create Order',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                }),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(icon, color: Colors.blue),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        filled: true,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      ),
    );
  }

  Widget buildDatePicker(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: InkWell(
        onTap: () => _selectDate(context),
        borderRadius: BorderRadius.circular(12),
        child: InputDecorator(
          decoration: InputDecoration(
            labelText: 'Order Date',
            prefixIcon: const Icon(Icons.calendar_today, color: Colors.blue),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            filled: true,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          ),
          child: Text(
            '${_selectedDate.day} ${_getMonthName(_selectedDate.month)} ${_selectedDate.year}',
            style: const TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }

  String _getMonthName(int month) {
    const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    return months[month - 1];
  }

}