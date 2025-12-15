import 'package:flutter/material.dart';

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

  void _saveOrder() {
    if (_formKey.currentState!.validate()) {
      // Save order logic here
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Order created successfully!'),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.pop(context);
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
                buildSectionTitle('Order Information'),
                const SizedBox(height: 16),
                buildTextField(
                  controller: _orderIdController,
                  label: 'Order ID',
                  hint: 'Enter order ID (e.g., ORD1001)',
                  icon: Icons.tag,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter order ID';
                    }
                    return null;
                  },
                ),
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
                const SizedBox(height: 24),

                buildSectionTitle('Order Details'),
                const SizedBox(height: 16),

                buildStatusDropdown(),
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

                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: _saveOrder,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: const Text(
                      'Create Order',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
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

  Widget buildStatusDropdown() {
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
      child: DropdownButtonFormField<String>(
        value: _selectedStatus,
        decoration: InputDecoration(
          labelText: 'Order Status',
          prefixIcon: const Icon(Icons.info_outline, color: Colors.blue),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          filled: true,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        ),
        items: _statusOptions.map((String status) {
          return DropdownMenuItem<String>(
            value: status,
            child: Row(
              children: [
                Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: _getStatusColor(status),
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 12),
                Text(status),
              ],
            ),
          );
        }).toList(),
        onChanged: (String? newValue) {
          setState(() {
            _selectedStatus = newValue!;
          });
        },
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

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Delivered':
        return Colors.green;
      case 'Processing':
        return Colors.orange;
      case 'Pending':
        return Colors.blue;
      case 'Cancelled':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}