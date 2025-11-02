import 'package:flutter/material.dart';
import '../pages/home_page.dart';


void main() {
runApp(const AdotaPetApp());
}


class AdotaPetApp extends StatelessWidget {
const AdotaPetApp({Key? key}) : super(key: key);


@override
Widget build(BuildContext context) {
return MaterialApp(
debugShowCheckedModeBanner: false,
title: 'AdotaPet',
theme: ThemeData(
primarySwatch: Colors.teal,
useMaterial3: true,
),
home: const HomePage(),
);
}
}