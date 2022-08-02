import 'dart:ffi';

import 'package:flutter/material.dart';

class drop extends StatefulWidget {
  @override
  _dropState createState() => _dropState();
}

class _dropState extends State<drop> {
  List<String> map=['الخرطوم', 'أم درمان', 'بحري'];
  var init_locat;
  @override
  Widget build(BuildContext context) {

    print(init_locat);
    return Scaffold(
      body: Container(
        child: DropdownButton(
          iconSize: 50,
          isExpanded: true,
          hint: Text("اختر مدينة"),
          value: init_locat.toString().isEmpty?"jjjjj":init_locat,
          onChanged: (location) {
            setState(() {
              init_locat = location;
            });

          },
          items: map.map<DropdownMenuItem<String>>((e) {
            return DropdownMenuItem<String>(
              child: Text(e),
              value: e,
            );
          }).toList(),
        ),
      ),
    );
  }
}
