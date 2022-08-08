import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:project101/Controller/Supervisor/users_controller.dart';
import 'package:project101/theme_helper.dart';

class UserManager extends StatelessWidget {
  UserManager({Key? key}) : super(key: key);

  final CoordinatorController controller = Get.put(CoordinatorController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("إدارة المستخدمين"),
        flexibleSpace: ThemeHelper().appBar(),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx(() => (controller != null && controller.coordinator.isNotEmpty)
                ? Expanded(
                    child: ListView.builder(
                        itemCount: controller.coordinator.length,
                        itemBuilder: (context, index) {
                          return Card(
                            elevation: 10,
                            child: Container(
                              child: ExpansionTile(
                                backgroundColor: Colors.blueGrey.shade50,
                                leading: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        color: HexColor('#FD9418FF')),
                                    child: const Icon(Icons.person)),
                                textColor: Colors.cyan.shade700,
                                iconColor: Colors.cyan.shade700,
                                title: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ListTile(
                                      title: Text(controller
                                          .coordinator[index].userName
                                          .toString()),
                                      // leading: Icon(Icons.manage_accounts),
                                    )
                                  ],
                                ),
                                children: [
                                  Container(
                                      padding: const EdgeInsets.only(right: 10),
                                      width: Get.width,
                                      child: const Text("المتاجر :")),
                                  controller.buildStore(controller
                                      .coordinator[index].uid
                                      .toString()),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    decoration:
                                        ThemeHelper().buttonBoxDecoration(),
                                    child: ElevatedButton(
                                        style: ThemeHelper().buttonStyle(),
                                        child: const Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 10.0, horizontal: 40.0),
                                          child: Text(
                                            'تعيين المتاجر',
                                            style: TextStyle(
                                                // color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16.0,
                                                fontFamily: 'Cairo'),
                                          ),
                                        ),
                                        onPressed: () {
                                          addStores(controller
                                              .coordinator[index].uid
                                              .toString());
                                        }),
                                  ),
                                  // const SizedBox(
                                  //   height: 10,
                                  // ),
                                  Container(
                                      padding: const EdgeInsets.only(right: 10),
                                      width: Get.width,
                                      child: const Text("العلامات التجارية :")),
                                  controller.buildBrand(controller
                                      .coordinator[index].uid
                                      .toString()),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    decoration:
                                        ThemeHelper().buttonBoxDecoration(),
                                    child: ElevatedButton(
                                        style: ThemeHelper().buttonStyle(),
                                        child: const Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 40.0),
                                          child: Text(
                                            'تعيين العلامات التجارية',
                                            style: TextStyle(
                                                // color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16.0,
                                                fontFamily: 'Cairo'),
                                          ),
                                        ),
                                        onPressed: () {
                                          addBrand(controller
                                              .coordinator[index].uid
                                              .toString());
                                        }),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  )
                                ],
                              ),
                            ),
                          );
                        }))
                : const Text("Loading....."))
          ],
        ),
      ),
    );
  }

  void addStores(String suID) {
    Get.bottomSheet(
      SizedBox(
          height: Get.height / 2,
          child: GetBuilder<CoordinatorController>(
              init: CoordinatorController(),
              builder: (_controller) => Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListView.builder(
                            itemCount: _controller.stores.length,
                            shrinkWrap: true,
                            itemBuilder: (BuildContext context, index) {
                              return Container(
                                margin:
                                    const EdgeInsets.fromLTRB(20, 0, 20, 10),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5),
                                  border:
                                      Border.all(color: Colors.grey, width: 1),
                                  shape: BoxShape.rectangle,
                                ),
                                child: _controller.checkStores(index),
                              );
                            }),
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
                            onPressed: () {
                              _controller.addStore(suID, _controller.stores);
                              Get.back();
                            }),
                      ),
                    ],
                  ))),
      backgroundColor: Colors.white,
      isScrollControlled: true,
      elevation: 0,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10), topRight: Radius.circular(10)),
      ),
    );
  }

  void addBrand(String suID) {
    Get.bottomSheet(
      SizedBox(
          height: Get.height / 2,
          child: GetBuilder<CoordinatorController>(
              init: CoordinatorController(),
              builder: (_controller) {
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListView.builder(
                          itemCount: _controller.brand.length,
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, index) {
                            return Container(
                              margin:
                              const EdgeInsets.fromLTRB(20, 0, 20, 10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5),
                                border:
                                Border.all(color: Colors.grey, width: 1),
                                shape: BoxShape.rectangle,
                              ),
                              child: _controller.checkBrand(index),
                            );
                          }),
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
                          onPressed: () {
                            _controller.addBrand(suID, _controller.brand);
                            Get.back();
                          }),
                    ),
                  ],
                );
              })),
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
