import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:ordermanagement/modules/auth/auth_controller.dart';
import 'package:ordermanagement/utils/constants/colors.dart';

import '../../data/models/orderModel.dart';
import '../../utils/routes/app_routes.dart';
import '../orders/controllers/order_controller.dart';
import '../orders/widgets/order_filtersheet.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final OrdersController orderCtrl = Get.put(OrdersController());
  final AuthController authController=Get.put(AuthController());
  @override
  Widget build(BuildContext context) {



    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title:  Text(
          "Orders",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24.sp,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.filter_alt, color: AppColors.buttonPrimary, size: 28.sp),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                ),
                builder: (_) => OrderFilterSheet(),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.add_circle, color: AppColors.buttonPrimary, size: 28.sp),

            onPressed: () => Get.toNamed(Routes.addOrders),
          ),
          PopupMenuButton<String>(
            iconColor: AppColors.buttonPrimary,
            onSelected: (value) {
              if (value == 'logout') {
                Get.dialog(
                  AlertDialog(
                    title: const Text("Logout"),
                    content: const Text("Are you sure you want to logout?"),
                    actions: [
                      TextButton(
                        onPressed: () => Get.back(),
                        child: const Text("Cancel"),
                      ),
                      TextButton(
                        onPressed: () {
                          Get.back();
                          authController.logout();
                        },
                        child: const Text(
                          "Logout",
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    ],
                  ),
                );
              }
            },
            itemBuilder: (context) => const [
              PopupMenuItem(
                value: 'logout',
                child: Text('Logout'),
              ),
            ],
          ),
        ],
      ),
      body: Obx(() {
        if (orderCtrl.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 8.h),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Search orders...",
                  prefixIcon: Icon(Icons.search, size: 20.sp),
                  filled: true,
                  fillColor: Theme.of(context).cardColor,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: BorderSide.none,
                  ),
                ),
                onChanged: (value) {
                  orderCtrl.searchQuery.value = value;
                },
              ),
            ),

            Expanded(
              child: RefreshIndicator(
                onRefresh: () async => await orderCtrl.loadOrders(),
                child: Obx(() {
                  final list = orderCtrl.filteredOrders;

                  if (list.isEmpty) {
                    return const Center(
                      child: Text(
                        "No Orders Found",
                        style: TextStyle(fontSize: 16),
                      ),
                    );
                  }

                  return ListView.builder(
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: EdgeInsets.all(16.w),
                    itemCount: list.length,
                    itemBuilder: (context, index) {
                      final order = list[index];
                      return _buildOrderCard(order, context);
                    },
                  );
                }),
              ),
            )
          ],
        );
      }),
    );
  }
  Widget _buildOrderCard(OrderModel order, BuildContext context) {
    final status = order.status;

    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        color: Theme.of(context).cardColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10.r,
            offset: Offset(0, 4.h),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            Get.toNamed(Routes.orderdetails,arguments: order);
          },
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          child: Icon(Icons.receipt_long, color: Colors.blue, size: 24.sp),

                        ),
                        SizedBox(width: 12.w),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              order.orderId,
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              "${order.date.day} ${_getMonth(order.date.month)} ${order.date.year}",
                              style: TextStyle(fontSize: 12.sp),
                            ),
                          ],
                        ),
                      ],
                    ),

                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                      decoration: BoxDecoration(
                        color: _getStatusColor(status).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: Text(
                        status,
                        style: TextStyle(
                          color: _getStatusColor(status),
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),

                 SizedBox(height: 16.h),
                Divider(color: Colors.grey[300], height: 1.h),
                 SizedBox(height: 16.h),

                Row(
                  children: [
                     Icon(Icons.person_outline, size: 18.sp),
                     SizedBox(width: 8.w),
                    Text(
                      order.customerName,
                      style:  TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),

                 SizedBox(height: 12.h),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                         Icon(Icons.shopping_bag_outlined, size: 18.sp),
                         SizedBox(width: 8.w),
                        Text("${order.items} items"),
                      ],
                    ),
                    Text(
                      "₹${order.amount.toStringAsFixed(2)}",
                      style:  TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  String _getMonth(int month) {
    const months = [
      'Jan','Feb','Mar','Apr','May','Jun',
      'Jul','Aug','Sep','Oct','Nov','Dec'
    ];
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