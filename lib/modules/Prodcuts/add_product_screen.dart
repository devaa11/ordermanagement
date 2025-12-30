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
  final pNameController = TextEditingController();
  final pDescController = TextEditingController();
  final amountController = TextEditingController();
  final pTypeController = TextEditingController();
  final ProductController productController = Get.put(ProductController());


  @override
  void initState() {
    super.initState();

    productController.loadAllProduct();
  }

  void _clearFields(){
    pNameController.clear();
    pDescController.clear();
    amountController.clear();
    pTypeController.clear();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Product')),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.r),
          child: Column(
            spacing: 20.h,
            children: [
              TextFormField(
                controller: pNameController,
                decoration: InputDecoration(
                  labelText: 'Product Name',
                  prefixIcon: Icon(Icons.description, color: Colors.blue),
                  filled: true,

                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),

              TextFormField(
                controller: pDescController,
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
                controller: pTypeController,

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

              Obx(() {
                return SizedBox(
                  width: double.infinity,
                  height: 45.h,
                  child: ElevatedButton(
                    onPressed: () {
                      productController.createProdcut(
                        pNameController.text,
                        pDescController.text,
                        amountController.text,
                        pTypeController.text,
                      );

                      _clearFields();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: productController.isProductAdded.value
                        ? CircularProgressIndicator()
                        : Text(
                            'Create Product',
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                );
              }),

              Obx(()=>Column(
                children: productController.product.map((e)=>
               Row(
                 spacing: 30.w,
                 children: [
                   Text(e.id ?? ""),
                   Text(e.pName ?? ""),
                   Text(e.pAmount.toString())
                   
                 ],
               )
                ).toList(),


              )),

            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {

    super.dispose();
  }
}
