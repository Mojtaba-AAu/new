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
                                elevation: 10,
                                child: Container(
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
                                            color: Colors.grey.shade200,
                                            borderRadius:
                                                BorderRadius.circular(15),
                                              border: Border.all(color: Colors.black54,width: 2,style: BorderStyle.solid)
                                          ),
                                          child: MaterialButton(
                                            onPressed: () {
                                              addStore(
                                                  context,
                                                  storeController
                                                      .store[index].storeID
                                                      .toString());
                                            },
                                            child: const Text(
                                              "إضافة منتج",
                                              style: TextStyle(
                                                  ),
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

  void addStore(context, storeID) {
    final formKey = GlobalKey<FormState>();
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => SingleChildScrollView(
        child: Container(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: GetX<ProductController>(
              init: ProductController(),
              builder: (productController) =>
                  ButtonSheat(formKey, productController, storeID)),
        ),
      ),
    );
  }

  ButtonSheat(formKey, ProductController productController, storeID) {
    return Padding(
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
                contentPadding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(color: Colors.grey)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(color: Colors.grey.shade400)),
                errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide:
                        const BorderSide(color: Colors.red, width: 2.0)),
                focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(100.0),
                    borderSide:
                        const BorderSide(color: Colors.red, width: 2.0)),
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
              height: 15,
            ),
            TextFormField(
              textInputAction: TextInputAction.next,
              controller: productController.code,
              // readOss
              // onTap: () {
              //   productController.barScan();
              // },
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
                contentPadding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(color: Colors.grey)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(color: Colors.grey.shade400)),
                errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide:
                        const BorderSide(color: Colors.red, width: 2.0)),
                focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(100.0),
                    borderSide:
                        const BorderSide(color: Colors.red, width: 2.0)),
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
                contentPadding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(color: Colors.grey)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(color: Colors.grey.shade400)),
                errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide:
                        const BorderSide(color: Colors.red, width: 2.0)),
                focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(100.0),
                    borderSide:
                        const BorderSide(color: Colors.red, width: 2.0)),
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
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(20)),
              child: productController.image != null
                  ? Image.file(
                      productController.image!,
                      width: 100,
                      height: 100,
                    )
                  : Container(),
            ),
            MaterialButton(
              onPressed: () {
                productController.getImage();
              },
              child: const Text("اضافة صورة للمنتج"),
            ),
            Container(
              decoration: ThemeHelper().buttonBoxDecoration(),
              child:productController.isLoad.value?const CircularProgressIndicator():ElevatedButton(
                  style: ThemeHelper().buttonStyle(),
                  child: const Padding(
                    padding:
                    EdgeInsets.symmetric(vertical: 10.0, horizontal: 40.0),
                    child: Text(
                      'g',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                          fontFamily: 'Cairo'),
                    ),
                  ),
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      if (productController.image != null) {
                        productController.addProduct(storeID);
                      } else {
                        Get.defaultDialog(
                            confirm: MaterialButton(
                                onPressed: () {
                                  Get.back();
                                  Get.to(() => productController.getImage());
                                },
                                child: const Text("حسنا")),
                            title: "حدد صورة للمنتج",
                            titleStyle: const TextStyle(color: Colors.red),
                            content: const Icon(
                              Icons.photo_outlined,
                              size: 100,
                              color: Colors.red,
                            ));
                      }
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
