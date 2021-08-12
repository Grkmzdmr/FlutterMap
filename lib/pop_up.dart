import 'package:flutter/material.dart';

class popUp extends StatefulWidget {
  const popUp({Key key}) : super(key: key);

  @override
  _popUpState createState() => _popUpState();
}

class _popUpState extends State<popUp> {
  String _secilentus = "";
  @override
  Widget build(BuildContext context) {
    return Center(
      child: PopupMenuButton<String>(onSelected: (String secenek) {
        print("Seçilen Seçenek $secenek");
        _secilentus = secenek;
      }, itemBuilder: (BuildContext context) {
        return <PopupMenuEntry<String>>[
          PopupMenuItem(
            child: Text('Menü'),
            value: 'Menu',
          ),
          PopupMenuItem(
            child: Text('Ayarlar'),
            value: 'Ayarlar',
          ),
          PopupMenuItem(
            child: Text('İletişim'),
            value: 'Iletisim',
          ),
        ];
      }),
    );
  }
}
