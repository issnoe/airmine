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
            'Calidad del aire',
            style: bottomNavigationBarItemStyle,
          )),
    );
    bottomBarItems.add(
      BottomNavigationBarItem(
          icon: Icon(Icons.map, color: Colors.black),
          title: Text(
            'Mapa',
            style: bottomNavigationBarItemStyle,
          )),
    );
    bottomBarItems.add(
      BottomNavigationBarItem(
          icon: Icon(Icons.notifications, color: Colors.black),
          title: Text(
            'Notificaciones',
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
