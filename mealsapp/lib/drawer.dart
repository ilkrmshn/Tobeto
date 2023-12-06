import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue, Colors.green],
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
              ),
            ),
            child: Text(
              'Tarifler',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            title: const Text('Başlangıçlar'),
            onTap: () {
              Navigator.pop(context); 
            },
          ),
          ListTile(
            title: const Text('Ara Sıcaklar'),
            onTap: () {
              Navigator.pop(context); 
            },
          ),
          ListTile(
            title: const Text('Ana Yemekler'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text('Tatlılar'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
