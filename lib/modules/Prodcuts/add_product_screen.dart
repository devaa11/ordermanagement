import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:ordermanagement/data/models/productModel.dart';
import 'package:ordermanagement/modules/Prodcuts/productController.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final productIdController =TextEditingController();
  final productDescriptionController =TextEditingController();
  final amountController =TextEditingController();
  final ProductController productController=Get.put(ProductController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Product'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:  EdgeInsets.all(20.r),
          child: Column(
            spacing:20.h,
            children: [

              TextFormField(
                controller: productDescriptionController,
                maxLines: 3,
                decoration: InputDecoration(
                  labelText: 'Product Description',
                  prefixIcon: Icon(Icons.description, color: Colors.blue),
                  filled: true,

                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),

              TextFormField(
                controller: amountController,

                decoration: InputDecoration(
                  labelText: 'Type',
                  prefixIcon: Icon(Icons.category, color: Colors.blue),
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),

              TextFormField(

                controller: amountController,

                decoration: InputDecoration(
                  labelText: 'Amount',
                  prefixIcon: Icon(Icons.attach_money, color: Colors.blue),
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),

              Obx((){
                return SizedBox(
                  width: double.infinity,
                  height: 45.h,
                  child: ElevatedButton(
                    onPressed: (){
                      final  data ={
                        'productName': productIdController.text,
                        'description': productDescriptionController.text,
                        'type': amountController.text,
                        'amount': double.parse(amountController.text),
                      };
                      // productController.createProdcut(data);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: productController.isLoading.value ?CircularProgressIndicator() :
                    Text(
                      'Create Product',
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );

              }),


            ],
          ),
        ),
      )
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

  }
}
