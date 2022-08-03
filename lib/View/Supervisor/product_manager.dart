import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project101/Controller/Supervisor/product_controller.dart';
import 'package:project101/Controller/Supervisor/store_controller.dart';
import 'package:project101/theme_helper.dart';

class ProductManager extends StatelessWidget {
  ProductManager({Key? key}) : super(key: key);
  ProductController productController = Get.put(ProductController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("إدارة المنتجات"),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GetX<StoreController>(
                init: Get.put<StoreController>(StoreController()),
                builder: (StoreController storeController) {
                  if (storeController != null &&
                      storeController.store.isNotEmpty) {
                    return Expanded(
                        child: ListView.builder(
                            itemCount: storeController.store.length,
                            itemBuilder: (context, index) {
                              return Card(
                                elevation: 5,
                                child: Container(
                                  color: Colors.grey.shade300,
                                  child: ExpansionTile(
                                    title: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        ListTile(
                                          leading: const Text("اسم المتجر :"),
                                          title: Text(storeController
                                              .store[index].name
                                              .toString()),
                                        ),
                                        Container(
                                          width: Get.width,
                                          decoration: BoxDecoration(
                                            color: Colors.blueGrey,
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          child: MaterialButton(
                                            onPressed: () {
                                              addStore();
                                            },
                                            child: Text(
                                              "إضافة منتج",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    children: [
                                      productController.buildBody(
                                          storeController.store[index].storeID
                                              .toString())
                                    ],
                                  ),
                                ),
                              );
                            }));
                  } else {
                    return const Text("Loading.....");
                  }
                })
          ],
        ),
      ),
    );
  }

  void addStore() {
    final formKey = GlobalKey<FormState>();
    Get.bottomSheet(
      SizedBox(
        height: Get.height * 0.5,
        child: SingleChildScrollView(
          child: GetBuilder<ProductController>(
              init: ProductController(),
              builder: (sroductController) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Form(
                      key: formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            textInputAction: TextInputAction.next,
                            controller: productController.product,
                            decoration: InputDecoration(
                              labelText: 'المنتج',
                              // hintText: hintText,
                              fillColor: Colors.white,
                              filled: true,
                              contentPadding:
                                  const EdgeInsets.fromLTRB(20, 10, 20, 10),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide:
                                      const BorderSide(color: Colors.grey)),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide:
                                      BorderSide(color: Colors.grey.shade400)),
                              errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: const BorderSide(
                                      color: Colors.red, width: 2.0)),
                              focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(100.0),
                                  borderSide: const BorderSide(
                                      color: Colors.red, width: 2.0)),
                            ),
                            onChanged: (value) {},
                            validator: (value) {
                              if (value!.trim().isEmpty) {
                                return "ادخل إسم المنتج";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          TextFormField(
                            textInputAction: TextInputAction.next,
                            controller: productController.code,
                            decoration: InputDecoration(
                              labelText: 'الباركود',
                              // hintText: hintText,
                              prefixIcon: IconButton(
                                onPressed: () {
                                  productController.barScan();
                                },
                                icon: const Icon(Icons.qr_code_scanner),
                              ),
                              fillColor: Colors.white,
                              filled: true,
                              contentPadding:
                                  const EdgeInsets.fromLTRB(20, 10, 20, 10),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide:
                                      const BorderSide(color: Colors.grey)),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide:
                                      BorderSide(color: Colors.grey.shade400)),
                              errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: const BorderSide(
                                      color: Colors.red, width: 2.0)),
                              focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(100.0),
                                  borderSide: const BorderSide(
                                      color: Colors.red, width: 2.0)),
                            ),
                            validator: (value) {
                              if (value!.trim().isEmpty) {
                                return "ادخل الباركود";
                              }

                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          TextFormField(
                            textInputAction: TextInputAction.next,
                            controller: productController.desc,
                            decoration: InputDecoration(
                              labelText: 'الوصف',
                              // hintText: hintText,
                              fillColor: Colors.white,
                              filled: true,
                              contentPadding:
                                  const EdgeInsets.fromLTRB(20, 10, 20, 10),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide:
                                      const BorderSide(color: Colors.grey)),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide:
                                      BorderSide(color: Colors.grey.shade400)),
                              errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: const BorderSide(
                                      color: Colors.red, width: 2.0)),
                              focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(100.0),
                                  borderSide: const BorderSide(
                                      color: Colors.red, width: 2.0)),
                            ),
                            validator: (value) {
                              if (value!.trim().isEmpty) {
                                return "ادخل وصف المنتج";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Container(
                            width: 150,
                            height: 150,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20)
                            ),
                            child: productController.url!.isNotEmpty
                                ? Image.file(
                                    productController.image)
                                : Container(),
                          ),
                          MaterialButton(
                            onPressed: () {
                              productController.getImage();
                            },
                            child: const Text("اضافة صورة المنتج"),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Container(
                            decoration: ThemeHelper().buttonBoxDecoration(),
                            child: ElevatedButton(
                                style: ThemeHelper().buttonStyle(),
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 10.0, horizontal: 40.0),
                                  child: Text(
                                    'تعيين',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16.0,
                                        fontFamily: 'Cairo'),
                                  ),
                                ),
                                onPressed: () {}),
                          ),
                        ],
                      ),
                    ),
                  )),
        ),
      ),
      backgroundColor: Colors.white,
      isScrollControlled: true,
      elevation: 0,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10), topRight: Radius.circular(10)),
      ),
    );
  }
}
