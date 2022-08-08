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
        vsync: this, duration: const Duration(milliseconds: 600))
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
        child: SingleChildScrollView(
          physics: const ScrollPhysics(),
          child: Column(
            children: [
              storeController.store.isNotEmpty
                  ? ListView(
                shrinkWrap: true,
                    children: [
                      Text("المتاجر :"),
                    ],
                  )
                  : Container(),
              Obx(() => (storeController.store.isNotEmpty)
                  ? ListView.builder(
                      shrinkWrap: true,
                      itemCount: storeController.store.length,
                      itemBuilder: (context, index) {
                        return Card(
                          elevation: 5,
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            child: Container(
                              width: Get.width / 1.3,
                              child: Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
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
                                    "الوصف : ${storeController.store[index].description}",
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      })
                  : const Center(
                      child: Text("empty"),
                    )),
              storeController.brand.isNotEmpty
                  ? ListView(
                shrinkWrap: true,
                children: [
                  Text("العلامات التجارية :"),
                ],
              )
                  : Container(),

              Obx(() => (storeController.brand.isNotEmpty)
                  ? ListView.builder(
                  shrinkWrap: true,
                  itemCount: storeController.brand.length,
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: 5,
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        child: ListTile(
                          leading:  Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50)),
                            child:Image.network(
                              storeController.brand[index].image.toString(),
                              width: 70,
                              height: 70,
                            )
                          ),
                          title: Text(storeController.brand[index].brandName.toString()),
                          trailing: Container(
                            decoration: BoxDecoration(
                                color: Colors.blueGrey,
                                borderRadius: BorderRadius.circular(50),
                                border: Border.all(
                                    color:
                                    Get.theme.colorScheme.secondary,
                                    width: 2)),
                            child: IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.edit,
                                  color: Get.theme.colorScheme.secondary,
                                )),
                          ),
                        )
                      ),
                    );
                  })
                  : const Center(
                child: Text("empty"),
              )),
            ],
          ),
        ),
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
            onPressed: () {
              addMarking();
            },
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
                            onChanged: (value) {},
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
                                          confirm: MaterialButton(
                                              onPressed: () {
                                                Get.back();
                                                Get.to(() => GoogleMaps());
                                              },
                                              child: const Text("حسنا")),
                                          title: "حدد مكان المتجر",
                                          titleStyle:
                                              TextStyle(color: Colors.red),
                                          content: Image.asset(
                                            "images/location.png",
                                            width: 150,
                                            height: 150,
                                          ));
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

  void addMarking() {
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
                            controller: storeController.brandName,
                            decoration: InputDecoration(
                              labelText: "اسم الشعار",
                              // hintText: hintText,
                              fillColor: Colors.white,
                              filled: true,
                              contentPadding:
                                  EdgeInsets.fromLTRB(20, 10, 20, 10),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: BorderSide(color: Colors.grey)),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide:
                                      BorderSide(color: Colors.grey.shade400)),
                              errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: BorderSide(
                                      color: Colors.red, width: 2.0)),
                              focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(100.0),
                                  borderSide: BorderSide(
                                      color: Colors.red, width: 2.0)),
                            ),
                            onChanged: (value) {},
                            validator: (value) {
                              if (value!.trim().isEmpty) {
                                return "ادخل إسم الشركة";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20)),
                            child: storeController.image != null
                                ? Image.file(
                                    storeController.image!,
                                    width: 100,
                                    height: 100,
                                  )
                                : Container(),
                          ),
                          MaterialButton(
                            onPressed: () {
                              storeController.getImage();
                            },
                            child: const Text("إضافة شعار"),
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
                                    if (storeController.image != null) {
                                      storeController.addBrand();
                                    } else {
                                      Get.defaultDialog(
                                          confirm: MaterialButton(
                                              onPressed: () {
                                                Get.back();
                                                Get.to(() =>
                                                    storeController.getImage());
                                              },
                                              child: const Text("حسنا")),
                                          title: "حدد صورة للمنتج",
                                          titleStyle: const TextStyle(
                                              color: Colors.red),
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
