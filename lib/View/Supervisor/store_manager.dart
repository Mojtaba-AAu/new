import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project101/Controller/Supervisor/store_controller.dart';
import 'package:project101/View/Supervisor/map.dart';
import 'package:project101/theme_helper.dart';
import 'package:simple_speed_dial/simple_speed_dial.dart';

class StoreManager extends StatefulWidget {
  const StoreManager({Key? key}) : super(key: key);

  @override
  State<StoreManager> createState() => _StoreManagerState();
}

class _StoreManagerState extends State<StoreManager>
    with SingleTickerProviderStateMixin {
  // Animation controller
  late AnimationController _animationController;

  // This is used to animate the icon of the main FAB
  late Animation<double> _buttonAnimatedIcon;

  @override
  initState() {
    super.initState();

    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300))
      ..addListener(() {
        setState(() {});
      });

    _buttonAnimatedIcon =
        Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
  }

  // dispose the animation controller
  @override
  dispose() {
    _animationController.dispose();
    super.dispose();
  }

  ////////////////////////////////////////////////////////////////////////////////
  StoreController storeController = Get.put(StoreController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("إدارة المتاجر والعلامات التجارية"),
      ),
      body: SafeArea(
        child: Obx(() => (storeController.store.isNotEmpty)
            ? ListView.builder(
                itemCount: storeController.store.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 5,
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        children: [
                          Container(
                            width: Get.width / 1.3,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  " الإسم : ${storeController.store[index].name}",
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const Divider(
                                  color: Colors.grey,
                                ),
                                Text(
                                  "الإحداثيات : ${storeController.store[index].lat} , ${storeController.store[index].long}",
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const Divider(
                                  color: Colors.grey,
                                ),
                                Text(
                                  "الوصف : ${storeController.store[index].Description}",
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                          const Spacer(),
                          Container(
                            child: IconButton(
                                onPressed: () {}, icon: const Icon(Icons.edit)),
                          )
                        ],
                      ),
                    ),
                  );
                })
            : const Center(
                child: Text("empty"),
              )),
      ),
      floatingActionButton: SpeedDial(
        child: AnimatedIcon(
          icon: AnimatedIcons.menu_close,
          progress: _buttonAnimatedIcon,
        ),
        // closedForegroundColor: Colors.black,
        // openForegroundColor: Colors.white,
        // closedBackgroundColor: Colors.white,
        // openBackgroundColor: Colors.black,
        // labelsStyle: /* Your label TextStyle goes here */,
        labelsBackgroundColor: Colors.grey.shade100,
        controller: _animationController,
        speedDialChildren: <SpeedDialChild>[
          SpeedDialChild(
            child: const Icon(Icons.add_business_outlined),
            foregroundColor: Colors.white,
            backgroundColor: Colors.blue,
            label: 'إضافة متجر',
            onPressed: () {
              addStore();
            },
          ),
          SpeedDialChild(
            child: const Icon(Icons.add_card_outlined),
            foregroundColor: Colors.white,
            backgroundColor: Colors.amber.shade800,
            label: 'علامة تجارية',
            onPressed: () {},
          ),
          //  Your other SpeedDialChildren go here.
        ],
      ),
    );
  }

  void addStore() {
    final formKey = GlobalKey<FormState>();
    Get.bottomSheet(
      Container(
        height: Get.height * 0.5,
        child: SingleChildScrollView(
          child: GetBuilder<StoreController>(
              init: StoreController(),
              builder: (storeController) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Form(
                      key: formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            textInputAction: TextInputAction.next,
                            controller: storeController.name,
                            decoration: ThemeHelper()
                                .textInputDecoration("إسم المتجر", Icons.store),
                            onChanged: (value) {
                              if (value.length <= 4) {
                                print("jjjj");
                              }
                            },
                            validator: (value) {
                              if (value!.trim().isEmpty) {
                                return "ادخل إسم المتجر";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          TextFormField(
                            textInputAction: TextInputAction.next,
                            controller: storeController.desc,
                            decoration: ThemeHelper().textInputDecoration(
                                "الوصف", Icons.description),
                            validator: (value) {
                              if (value!.trim().isEmpty) {
                                return "ادخل وصف المتجر";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          MaterialButton(
                            onPressed: () {
                              Get.to(() => GoogleMaps());
                            },
                            child: const Text("تحديد مكان المتجر"),
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
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    if (storeController.longitude != null &&
                                        storeController.latitude != null) {
                                      storeController.addStore();
                                      Get.back();
                                    } else {
                                      Get.defaultDialog(
                                          cancel: MaterialButton(
                                              onPressed: () {
                                                Get.back();
                                              },
                                              child: const Text("حسنا")),
                                          confirm: MaterialButton(
                                              onPressed: () {
                                                Get.back();
                                              },
                                              child: const Text("حسنا")),
                                          title: "حدد مكان المتجر",titleStyle: TextStyle(color: Colors.red),
                                          content: Image.asset("images/profile.png",width: 200,height: 200,));
                                    }
                                  }
                                }),
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
