import 'package:flutter/material.dart';

class IconButtonBugView extends StatefulWidget {
  @override
  _IconButtonBugViewState createState() => _IconButtonBugViewState();
}

class _IconButtonBugViewState extends State<IconButtonBugView> {
  static const double _appBarBottomBtnPosition =
  24.0; //change this value to position your button vertically

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            // title: Text(
            //   'Testing',
            //   style: TextStyle(color: Colors.red),
            // ),
          ),
          SliverAppBar(
            // pinned: true,
            floating: true,
            expandedHeight: 300.0,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              titlePadding: EdgeInsets.only(bottom: 25),
              // title: Text('Title'),
              background: Image.asset(
                'images/log.png',
                fit: BoxFit.cover,
              ),
            ),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(0.0),
              child: Transform.translate(
                offset: const Offset(0, _appBarBottomBtnPosition),
                child: RaisedButton(
                  shape: StadiumBorder(),
                  child: Text("Click Here"),
                  onPressed: () {},
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.only(top: _appBarBottomBtnPosition),
          ),
          // SliverFixedExtentList(itemExtent: null, delegate: null,
            //extentlist
          // ),
        ],
      ),
    );
  }
}