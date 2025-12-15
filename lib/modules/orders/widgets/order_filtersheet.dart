import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/order_controller.dart';

class OrderFilterSheet extends StatelessWidget {
  final OrdersController orderCtrl = Get.find<OrdersController>();

  final List<String> statusOptions = [
    "Pending",
    "Processing",
    "Delivered",
    "Cancelled"
  ];

  OrderFilterSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.blue.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(
                          Icons.filter_list,
                          color: Colors.blue,
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Text(
                        "Filter Orders",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  _buildSectionTitle("Status"),
                  const SizedBox(height: 12),
                  Obx(() => Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: statusOptions.map((status) {
                      final isSelected =
                      orderCtrl.selectedStatuses.contains(status);

                      return ChoiceChip(
                        label: Text(status),
                        selected: isSelected,
                        selectedColor: Colors.blue,
                        backgroundColor: Theme.of(context).cardColor,
                        labelStyle: TextStyle(
                          color: isSelected ? Colors.white : null,
                          fontWeight: isSelected
                              ? FontWeight.w600
                              : FontWeight.normal,
                        ),
                        side: BorderSide(
                          color: isSelected
                              ? Colors.blue
                              : Colors.grey.shade300,
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        onSelected: (_) {
                          if (isSelected) {
                            orderCtrl.selectedStatuses.remove(status);
                          } else {
                            orderCtrl.selectedStatuses.add(status);
                          }
                        },
                      );
                    }).toList(),
                  )),

                  const SizedBox(height: 24),

                  _buildSectionTitle("Amount Range"),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Obx(() => Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _buildAmountBox(
                              "Min",
                              "₹${orderCtrl.minAmount.value.toInt()}",
                            ),
                            Container(
                              width: 40,
                              height: 2,
                              color: Colors.grey[300],
                            ),
                            _buildAmountBox(
                              "Max",
                              "₹${orderCtrl.maxAmount.value.toInt()}",
                            ),
                          ],
                        )),
                        const SizedBox(height: 8),
                        Obx(() => RangeSlider(
                          min: 0,
                          max: 50000,
                          divisions: 50,
                          values: RangeValues(
                            orderCtrl.minAmount.value.clamp(0, 50000),
                            orderCtrl.maxAmount.value.clamp(0, 50000),
                          ),
                          onChanged: (values) {
                            orderCtrl.minAmount.value = values.start;
                            orderCtrl.maxAmount.value = values.end;
                          },
                        )),
                      ],
                    ),
                  ),

                  const SizedBox(height: 32),

                  _buildSectionTitle("Order Date Range"),
                  const SizedBox(height: 12),

                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Obx(() => _buildDateBox(
                          label: "Start Date",
                          value: orderCtrl.startDate.value == null
                              ? "Select"
                              : "${orderCtrl.startDate.value!.day}/${orderCtrl.startDate.value!.month}/${orderCtrl.startDate.value!.year}",
                          onTap: () async {
                            final date = await showDatePicker(
                              context: context,
                              initialDate: orderCtrl.startDate.value ?? DateTime.now(),
                              firstDate: DateTime(2020),
                              lastDate: DateTime(2035),
                            );
                            if (date != null) {
                              orderCtrl.startDate.value = date;

                              if (orderCtrl.endDate.value != null &&
                                  orderCtrl.endDate.value!.isBefore(date)) {
                                orderCtrl.endDate.value = date;
                              }
                            }
                          },
                        )),

                        Container(
                          width: 40,
                          height: 2,
                          color: Colors.grey[300],
                        ),

                        Obx(() => _buildDateBox(
                          label: "End Date",
                          value: orderCtrl.endDate.value == null
                              ? "Select"
                              : "${orderCtrl.endDate.value!.day}/${orderCtrl.endDate.value!.month}/${orderCtrl.endDate.value!.year}",
                          onTap: () async {
                            final date = await showDatePicker(
                              context: context,
                              initialDate: orderCtrl.endDate.value ??
                                  orderCtrl.startDate.value ??
                                  DateTime.now(),
                              firstDate: DateTime(2020),
                              lastDate: DateTime(2035),
                            );
                            if (date != null) {
                              if (orderCtrl.startDate.value != null &&
                                  date.isBefore(orderCtrl.startDate.value!)) {
                                Get.snackbar(
                                  "Invalid Date",
                                  "End date cannot be before start date",
                                  backgroundColor: Colors.red,
                                  colorText: Colors.white,
                                );
                                return;
                              }
                              orderCtrl.endDate.value = date;
                            }
                          },
                        )),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            orderCtrl.selectedStatuses.clear();
                            orderCtrl.minAmount.value = 0;
                            orderCtrl.maxAmount.value = 50000;
                            orderCtrl.startDate.value = null;
                            orderCtrl.endDate.value = null;
                          },
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            side: BorderSide(color: Colors.grey.shade300),
                          ),
                          child: const Text(
                            "Reset",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        flex: 2,
                        child: ElevatedButton(
                          onPressed: () => Get.back(),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 0,
                          ),
                          child: const Text(
                            "Apply Filters",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 8),


                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    );
  }
  Widget _buildDateBox({
    required String label,
    required String value,
    required Function() onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              )),
          const SizedBox(height: 6),
          Row(
            children: [
              const Icon(Icons.calendar_today, size: 18, color: Colors.blue),
              const SizedBox(width: 6),
              Text(
                value,
                style: const TextStyle(
                    fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAmountBox(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        ),
      ],
    );
  }
}