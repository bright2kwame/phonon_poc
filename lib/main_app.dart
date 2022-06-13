import 'package:flutter/material.dart';
import 'package:phonon_github/resources/color_resource.dart';
import 'package:phonon_github/widget/search_page.dart';

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PHONON SEARCH',
      theme: ThemeData(
        primarySwatch: AppColor.primaryMaterialColor,
      ),
      home: const SearchPage(),
    );
  }
}
