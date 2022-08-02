import 'package:flutter/material.dart';

class report extends StatefulWidget {
  const report({Key? key}) : super(key: key);

  @override
  _reportState createState() => _reportState();
}
var expand =false;
class _reportState extends State<report> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ExpansionPanelList(
        animationDuration: Duration(milliseconds: 1000),
        expansionCallback: (int index, bool isExpanded) {
          setState(() {
            expand= !expand;
          });
        },
        children: [
          // ExpansionPanel(
          //   headerBuilder: (BuildContext context, bool isExpanded) {
          //     return ListTile(
          //       title: Text('Item 1'),
          //     );
          //   },
          //   body: ListTile(
          //     title: Text('Item 1 child'),
          //     subtitle: Text('Details goes here'),
          //   ),
          //   isExpanded: expand,
          // ),
        ],
      ),
    );
  }
}
