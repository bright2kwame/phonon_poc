import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:phonon_github/resources/color_resource.dart';
import 'package:phonon_github/resources/image_resource.dart';

class AppBarWidget {
//MARK:the app bar to be used in the app
  static primaryAppBar() => AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          systemNavigationBarColor: Colors.white, // Navigation bar
          statusBarColor: Colors.white,
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        title: Image.asset(
          ImageResource.appLogo,
          height: 100,
          width: 200,
        ),
        backgroundColor: AppColor.primaryColor,
        centerTitle: true,
        elevation: 4,
      );
}
