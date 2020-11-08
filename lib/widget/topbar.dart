import 'package:flutter/material.dart';

AppBar topBar() {
  return AppBar(
    title: Text('Humble Plank',
        style: TextStyle(color: Colors.black.withOpacity(0.6))),
    backgroundColor: Colors.white,
    elevation: 0,
  );
}
