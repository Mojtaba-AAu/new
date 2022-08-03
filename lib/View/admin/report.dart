import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project101/Controller/Admin/report_controller.dart';
import 'package:project101/theme_helper.dart';

class AD_Report extends GetWidget<ReportsController> {
  const AD_Report({Key? key}) : super(key: key);

  // ReportsController _controller = Get.put(ReportsController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("التقارير"), flexibleSpace: ThemeHelper().appBar()),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GetX<ReportsController>(
                init: Get.put<ReportsController>(ReportsController()),
                builder: (ReportsController reportcontroller) {
                  if (reportcontroller != null &&
                      reportcontroller.report_m != null) {
                    return Expanded(
                        child: ListView.builder(
                            itemCount: reportcontroller.report_m.length,
                            itemBuilder: (context, index) {
                              return Card(
                                child: ExpansionTile(
                                  title: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          "المندوب :${reportcontroller.report_m[index].coordinator}"),
                                      Text(
                                          "المتجر :${reportcontroller.report_m[index].store}"),
                                      ConstrainedBox(
                                          constraints:
                                              const BoxConstraints.expand(
                                                  height: 50),
                                          child: Text(
                                              "التاريخ والوقت :  ${reportcontroller.report_m[index].dateTime!.toDate()}"))
                                    ],
                                  ),
                                  children: [
                                    reportcontroller.buildBody(
                                        reportcontroller.report_m[index].docID
                                            .toString(),
                                        Timestamp.fromDate(reportcontroller
                                            .report_m[index].dateTime!
                                            .toDate()))
                                  ],
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
}
