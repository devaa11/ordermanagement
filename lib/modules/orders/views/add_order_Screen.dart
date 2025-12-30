import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
  final _productIdController = TextEditingController();
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
        title:  Text(
          "Add New Order",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22.sp,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:  EdgeInsets.all(20.r),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [


                buildSectionTitle('Order Details'),
                 SizedBox(height: 24.h),

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
                        borderRadius: BorderRadius.circular(12.r),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  );
                }),

                 SizedBox(height: 16.h),

              TextFormField(

                controller: _productIdController,
                onChanged: (value) {
                  orderCtrl.getProductId(value.trim());
                },


                decoration: InputDecoration(
                  labelText: 'Product ID',
                  prefixIcon: Icon(Icons.tag, color: Colors.blue),
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),

                SizedBox(height: 16.h),

                Obx((){
                  if(orderCtrl.isProductLoading.value){
                    return SizedBox.shrink();
                  }

                  final product= orderCtrl.selectedProduct.value;

                  if(product ==null){
                    return Text("No product found");
                  }
                  return    Column(
                      children:[

                        Container(
                            child: Column(

                                crossAxisAlignment: CrossAxisAlignment.start,
                                children:[
                                  Text("Prodcut Name: ${product.productName}"),
                                  Text("Description: ${product.description}"),
                                  Text("type: ${product.type}"),
                                ]
                            )
                        ),
                        SizedBox(height: 16.h),

                      ]
                  );

                }),


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


                 SizedBox(height: 16.h),

                OrderStatusDropdown(
                  value: _selectedStatus,
                  onChanged: (val) {
                    setState(() => _selectedStatus = val);
                  },
                ),
                 SizedBox(height: 16.h),

                buildDatePicker(context),
                 SizedBox(height: 16.h),

           TextFormField(
             keyboardType: TextInputType.number,
             decoration:  InputDecoration(
               labelText: "Quantity",

             ),
             onChanged: (value) {
               orderCtrl.updateQuantity(int.tryParse(value) ?? 1);
             },

           ),
                 SizedBox(height: 16.h),
                 Obx((){
                   return TextFormField(
                     readOnly: true,
                     decoration:  InputDecoration(
                       labelText: "Total Amount",

                     ),
                     controller: TextEditingController(
                         text: orderCtrl.calculatedTotal.value.toString()
                     ),
                   );
                 }),



                 SizedBox(height: 32.h),

                Obx((){
                  return SizedBox(
                    width: double.infinity,
                    height: 45.h,
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
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                }),
                 SizedBox(height: 20.h),
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

  Widget  buildTextField({
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