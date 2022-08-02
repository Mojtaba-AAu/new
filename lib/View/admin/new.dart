import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ListItem {
  int id;
  String headerName;
  String description;
  bool isExpanded;

  ListItem({
    required this.id,
    required this.headerName,
    required this.description,
    this.isExpanded = false,
  });
}

 generateItems() async{
 //  CollectionReference user = FirebaseFirestore.instance.collection("users");
 //  await user
 //      .get()
 //      .then((value) {
 //    List<ListItem>.generate(value.docs.length, (int index) {
 //      return ListItem(
 //        id:index,
 //        headerName:'Expansion Panel $index',
 //        description: 'This is body of item number $index',
 //      );
 //    });
 //  });
}

List<ExpansionPanel> _getExpansionPanels(_items)
{
  return _items.map<ExpansionPanel>((ListItem item) {
    return ExpansionPanel(
      headerBuilder: (BuildContext context, bool isExpanded) {
        return ListTile(
          title: Text(item.headerName),
        );
      },
      body: ListTile(
        title: Text(item.description),
      ),
      isExpanded: item.isExpanded,
    );
  }).toList();
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Learning',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState()
  {
    return _MyHomePageState();
  }
}

class _MyHomePageState extends State<MyHomePage> {
  List<ListItem> _items = generateItems();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter Epansion Panel"),
      ),
      body: SingleChildScrollView(
          child: ExpansionPanelList(
            animationDuration: Duration(milliseconds: 1000),
            children: _getExpansionPanels(_items),
            expansionCallback: (panelIndex, isExpanded) {
              _items[panelIndex].isExpanded = !isExpanded;
              setState(() {

              });
            },
          )
      ),
    );
  }
}