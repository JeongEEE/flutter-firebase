import 'package:flutter/material.dart';
import 'package:instagram_clone/store/global_data.dart';


class AppScreen {
  static double getWidth() {
    return MediaQuery.of(appContext).size.width;
  }

  static getHeight() {
    return MediaQuery.of(appContext).size.height;
  }
}
