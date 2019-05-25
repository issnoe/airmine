import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  final List<BottomNavigationBarItem> bottomBarItems = [];
  final bottomNavigationBarItemStyle = TextStyle(
    fontStyle: FontStyle.normal,
    color: Colors.black,
  );
  CustomAppBar() {
    bottomBarItems.add(
      BottomNavigationBarItem(
          icon: Icon(Icons.cloud, color: Colors.black),
          title: Text(
            'Calidad del Aire',
            style: bottomNavigationBarItemStyle,
          )),
    );
    bottomBarItems.add(
      BottomNavigationBarItem(
          icon: Icon(Icons.wb_sunny, color: Colors.black),
          title: Text(
            'UV',
            style: bottomNavigationBarItemStyle,
          )),
    );

    bottomBarItems.add(
      BottomNavigationBarItem(
          icon: Icon(Icons.settings, color: Colors.black),
          title: Text(
            'Ajustes',
            style: bottomNavigationBarItemStyle,
          )),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 15.0,
      child: BottomNavigationBar(
        items: bottomBarItems,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
